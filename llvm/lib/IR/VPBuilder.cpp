#include <llvm/ADT/SmallVector.h>
#include <llvm/IR/FPEnv.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/Intrinsics.h>
#include <llvm/IR/PredicatedInst.h>
#include <llvm/IR/VPBuilder.h>

namespace {
using namespace llvm;
using ShortTypeVec = VPIntrinsic::ShortTypeVec;
using ShortValueVec = SmallVector<Value *, 4>;
} // namespace

namespace llvm {

Module &VPBuilder::getModule() const {
  return *Builder.GetInsertBlock()->getParent()->getParent();
}

Value &VPBuilder::RequestPred() {
  if (Mask)
    return *Mask;

  auto *boolTy = Builder.getInt1Ty();
  auto *maskTy = VectorType::get(boolTy, StaticVectorLength);
  return *ConstantInt::getAllOnesValue(maskTy);
}

Value &VPBuilder::RequestEVL() {
  if (ExplicitVectorLength)
    return *ExplicitVectorLength;

  auto *intTy = Builder.getInt32Ty();
  return *ConstantInt::get(intTy, StaticVectorLength);
}

Value *VPBuilder::CreateVectorCopy(Instruction &Inst, ValArray VecOpArray) {
  auto OC = Inst.getOpcode();
  auto VPID = VPIntrinsic::GetForOpcode(OC);
  if (VPID == Intrinsic::not_intrinsic) {
    return nullptr;
  }

  Optional<int> MaskPosOpt = VPIntrinsic::GetMaskParamPos(VPID);
  Optional<int> VLenPosOpt = VPIntrinsic::GetVectorLengthParamPos(VPID);
  Optional<int> FPRoundPosOpt = VPIntrinsic::GetRoundingModeParamPos(VPID);
  Optional<int> FPExceptPosOpt =
      VPIntrinsic::GetExceptionBehaviorParamPos(VPID);

  Optional<int> CmpPredPos = None;
  if (isa<CmpInst>(Inst)) {
    CmpPredPos = 2;
  }

  // TODO transfer alignment

  // construct VP vector operands (including pred and evl)
  SmallVector<Value *, 6> VecParams;
  for (size_t i = 0; i < Inst.getNumOperands() + 5; ++i) {
    if (MaskPosOpt && (i == (size_t)MaskPosOpt.getValue())) {
      // First operand of select is mask (singular exception)
      if (VPID != Intrinsic::vp_select)
        VecParams.push_back(&RequestPred());
    }
    if (VLenPosOpt && (i == (size_t)VLenPosOpt.getValue())) {
      VecParams.push_back(&RequestEVL());
    }
    if (FPRoundPosOpt && (i == (size_t)FPRoundPosOpt.getValue())) {
      // TODO decode fp env from constrained intrinsics
      VecParams.push_back(GetConstrainedFPRounding(
          Builder.getContext(), fp::RoundingMode::rmToNearest));
    }
    if (FPExceptPosOpt && (i == (size_t)FPExceptPosOpt.getValue())) {
      // TODO decode fp env from constrained intrinsics
      VecParams.push_back(GetConstrainedFPExcept(
          Builder.getContext(), fp::ExceptionBehavior::ebIgnore));
    }
    if (CmpPredPos && (i == (size_t)CmpPredPos.getValue())) {
      auto &CmpI = cast<CmpInst>(Inst);
      VecParams.push_back(ConstantInt::get(
          Type::getInt8Ty(Builder.getContext()), CmpI.getPredicate()));
    }
    if (i < VecOpArray.size())
      VecParams.push_back(VecOpArray[i]);
  }

  Type *ScaRetTy = Inst.getType();
  Type *VecRetTy = ScaRetTy->isVoidTy() ? ScaRetTy : &getVectorType(*ScaRetTy);
  auto &M = *Builder.GetInsertBlock()->getParent()->getParent();
  auto VPDecl =
      VPIntrinsic::GetDeclarationForParams(&M, VPID, VecParams, VecRetTy);

  // Transfer FMF flags
  auto VPCall = Builder.CreateCall(VPDecl, VecParams, Inst.getName() + ".vp");
  auto FPOp = dyn_cast<FPMathOperator>(&Inst);
  if (FPOp) {
    VPCall->setFastMathFlags(FPOp->getFastMathFlags());
  }

  return VPCall;
}

VectorType &VPBuilder::getVectorType(Type &ElementTy) {
  return *VectorType::get(&ElementTy, StaticVectorLength);
}

Value &VPBuilder::CreateContiguousStore(Value &Val, Value &ElemPointer,
                                        MaybeAlign AlignOpt) {
  auto &PointerTy = cast<PointerType>(*ElemPointer.getType());
  auto &VecTy = getVectorType(*PointerTy.getPointerElementType());
  auto *VecPtrTy = VecTy.getPointerTo(PointerTy.getAddressSpace());
  auto *VecPtr = Builder.CreatePointerCast(&ElemPointer, VecPtrTy);

  auto *StoreFunc = Intrinsic::getDeclaration(&getModule(), Intrinsic::vp_store,
                                              {&VecTy, VecPtrTy});
  ShortValueVec Args{&Val, VecPtr, &RequestPred(), &RequestEVL()};
  CallInst &StoreCall = *Builder.CreateCall(StoreFunc, Args);
  if (AlignOpt.hasValue()) {
    unsigned PtrPos =
        VPIntrinsic::GetMemoryPointerParamPos(Intrinsic::vp_store).getValue();
    StoreCall.addParamAttr(
        PtrPos, Attribute::getWithAlignment(getContext(), AlignOpt.getValue()));
  }
  return StoreCall;
}

Value &VPBuilder::CreateContiguousLoad(Value &ElemPointer,
                                       MaybeAlign AlignOpt) {
  auto &PointerTy = cast<PointerType>(*ElemPointer.getType());
  auto &VecTy = getVectorType(*PointerTy.getPointerElementType());
  auto *VecPtrTy = VecTy.getPointerTo(PointerTy.getAddressSpace());
  auto *VecPtr = Builder.CreatePointerCast(&ElemPointer, VecPtrTy);

  auto *LoadFunc = Intrinsic::getDeclaration(&getModule(), Intrinsic::vp_load,
                                             {&VecTy, VecPtrTy});
  ShortValueVec Args{VecPtr, &RequestPred(), &RequestEVL()};
  CallInst &LoadCall = *Builder.CreateCall(LoadFunc, Args);
  if (AlignOpt.hasValue()) {
    unsigned PtrPos =
        VPIntrinsic::GetMemoryPointerParamPos(Intrinsic::vp_load).getValue();
    LoadCall.addParamAttr(
        PtrPos, Attribute::getWithAlignment(getContext(), AlignOpt.getValue()));
  }
  return LoadCall;
}

Value &VPBuilder::CreateScatter(Value &Val, Value &PointerVec,
                                MaybeAlign AlignOpt) {
  auto *ScatterFunc =
      Intrinsic::getDeclaration(&getModule(), Intrinsic::vp_scatter,
                                {Val.getType(), PointerVec.getType()});
  ShortValueVec Args{&Val, &PointerVec, &RequestPred(), &RequestEVL()};
  CallInst &ScatterCall = *Builder.CreateCall(ScatterFunc, Args);
  if (AlignOpt.hasValue()) {
    unsigned PtrPos =
        VPIntrinsic::GetMemoryPointerParamPos(Intrinsic::vp_scatter).getValue();
    ScatterCall.addParamAttr(
        PtrPos, Attribute::getWithAlignment(getContext(), AlignOpt.getValue()));
  }
  return ScatterCall;
}

Value &VPBuilder::CreateGather(Value &PointerVec, MaybeAlign AlignOpt) {
  auto &PointerVecTy = cast<VectorType>(*PointerVec.getType());
  auto &ElemTy = *cast<PointerType>(*PointerVecTy.getVectorElementType())
                      .getPointerElementType();
  auto &VecTy = *VectorType::get(&ElemTy, PointerVecTy.getNumElements());
  auto *GatherFunc = Intrinsic::getDeclaration(
      &getModule(), Intrinsic::vp_gather, {&VecTy, &PointerVecTy});

  ShortValueVec Args{&PointerVec, &RequestPred(), &RequestEVL()};
  CallInst &GatherCall = *Builder.CreateCall(GatherFunc, Args);
  if (AlignOpt.hasValue()) {
    unsigned PtrPos =
        VPIntrinsic::GetMemoryPointerParamPos(Intrinsic::vp_gather).getValue();
    GatherCall.addParamAttr(
        PtrPos, Attribute::getWithAlignment(getContext(), AlignOpt.getValue()));
  }
  return GatherCall;
}

Value *VPBuilder::CreateVectorShift(Value *SrcVal, Value *Amount, Twine Name) {
  auto D = VPIntrinsic::GetDeclarationForParams(
      &getModule(), Intrinsic::vp_vshift, {SrcVal, Amount});
  return Builder.CreateCall(D, {SrcVal, Amount, &RequestPred(), &RequestEVL()},
                            Name);
}

} // namespace llvm
