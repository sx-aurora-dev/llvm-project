#include <llvm/IR/VPBuilder.h>
#include <llvm/IR/Intrinsics.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/PredicatedInst.h>
#include <llvm/ADT/SmallVector.h>
#include <llvm/IR/FPEnv.h>

namespace {
  using namespace llvm;
  using ShortTypeVec = VPIntrinsic::ShortTypeVec;
  using ShortValueVec = SmallVector<Value*, 4>;
}

namespace llvm {

Module &
VPBuilder::getModule() const {
  return *Builder.GetInsertBlock()->getParent()->getParent();
}

Value&
VPBuilder::RequestPred() {
  if (Mask) return *Mask;

  auto * boolTy = Builder.getInt1Ty();
  auto * maskTy = VectorType::get(boolTy, StaticVectorLength);
  return *ConstantInt::getAllOnesValue(maskTy);
}

Value&
VPBuilder::RequestEVL() {
  if (ExplicitVectorLength) return *ExplicitVectorLength;

  auto * intTy = Builder.getInt32Ty();
  return *ConstantInt::get(intTy, StaticVectorLength);
}

Value*
VPBuilder::CreateVectorCopy(Instruction & Inst, ValArray VecOpArray) {
  auto OC = Inst.getOpcode();
  auto VPID = VPIntrinsic::GetForOpcode(OC);
  if (VPID == Intrinsic::not_intrinsic) {
    return nullptr;
  }

  Optional<int> MaskPosOpt = VPIntrinsic::GetMaskParamPos(VPID);
  Optional<int> VLenPosOpt = VPIntrinsic::GetVectorLengthParamPos(VPID);
  Optional<int> FPRoundPosOpt = VPIntrinsic::GetRoundingModeParamPos(VPID);
  Optional<int> FPExceptPosOpt = VPIntrinsic::GetExceptionBehaviorParamPos(VPID);

  Optional<int> CmpPredPos = None;
  if (isa<CmpInst>(Inst)) {
    CmpPredPos = 2;
  }

  // construct VP vector operands (including pred and evl)
  SmallVector<Value*, 6> VecParams;
  for (size_t i = 0; i < Inst.getNumOperands() + 5; ++i) {
    if (MaskPosOpt && (i == (size_t) MaskPosOpt.getValue())) {
      VecParams.push_back(&RequestPred());
      // First operand of select is mask (singular exception)
      if (VPID == Intrinsic::vp_select) continue;
    }
    if (VLenPosOpt && (i == (size_t) VLenPosOpt.getValue())) {
      VecParams.push_back(&RequestEVL());
    }
    if (FPRoundPosOpt && (i == (size_t) FPRoundPosOpt.getValue())) {
      // TODO decode fp env from constrained intrinsics
      VecParams.push_back(GetConstrainedFPRounding(Builder.getContext(), fp::RoundingMode::rmToNearest));
    }
    if (FPExceptPosOpt && (i == (size_t) FPExceptPosOpt.getValue())) {
      // TODO decode fp env from constrained intrinsics
      VecParams.push_back(GetConstrainedFPExcept(Builder.getContext(), fp::ExceptionBehavior::ebIgnore));
    }
    if (CmpPredPos && (i == (size_t) CmpPredPos.getValue())) {
      auto &CmpI = cast<CmpInst>(Inst);
      VecParams.push_back(ConstantInt::get(Type::getInt8Ty(Builder.getContext()), CmpI.getPredicate()));
    }
    if (i < VecOpArray.size()) VecParams.push_back(VecOpArray[i]);
  }

  Type *ScaRetTy = Inst.getType();
  Type *VecRetTy = ScaRetTy->isVoidTy() ? ScaRetTy : &getVectorType(*ScaRetTy);
  auto &M = *Builder.GetInsertBlock()->getParent()->getParent();
  auto VPDecl = VPIntrinsic::GetDeclarationForParams(&M, VPID, VecParams, VecRetTy);

  return Builder.CreateCall(VPDecl, VecParams, Inst.getName() + ".vp");
}


VectorType&
VPBuilder::getVectorType(Type &ElementTy) {
  return *VectorType::get(&ElementTy, StaticVectorLength);
}

Value&
VPBuilder::CreateContiguousStore(Value & Val, Value & Pointer, Align Alignment) {
  auto * StoreFunc = Intrinsic::getDeclaration(&getModule(), Intrinsic::vp_store, {Val.getType(), Pointer.getType()});
  ShortValueVec Args{&Val, &Pointer, &RequestPred(), &RequestEVL()};
  CallInst &StoreCall = *Builder.CreateCall(StoreFunc, Args);
  if (Alignment != None) StoreCall.addParamAttr(1, Attribute::getWithAlignment(getContext(), Alignment));
  return StoreCall;
}

Value&
VPBuilder::CreateContiguousLoad(Value & Pointer, Align Alignment) {
  auto & PointerTy = cast<PointerType>(*Pointer.getType());
  auto & VecTy = getVectorType(*PointerTy.getPointerElementType());

  auto * LoadFunc = Intrinsic::getDeclaration(&getModule(), Intrinsic::vp_load, {&VecTy, &PointerTy});
  ShortValueVec Args{&Pointer, &RequestPred(), &RequestEVL()};
  CallInst &LoadCall= *Builder.CreateCall(LoadFunc, Args);
  if (Alignment != None) LoadCall.addParamAttr(1, Attribute::getWithAlignment(getContext(), Alignment));
  return LoadCall;
}

Value&
VPBuilder::CreateScatter(Value & Val, Value & PointerVec, Align Alignment) {
  auto * ScatterFunc = Intrinsic::getDeclaration(&getModule(), Intrinsic::vp_scatter, {Val.getType(), PointerVec.getType()});
  ShortValueVec Args{&Val, &PointerVec, &RequestPred(), &RequestEVL()};
  CallInst &ScatterCall = *Builder.CreateCall(ScatterFunc, Args);
  if (Alignment != None) ScatterCall.addParamAttr(1, Attribute::getWithAlignment(getContext(), Alignment));
  return ScatterCall;
}

Value&
VPBuilder::CreateGather(Value & PointerVec, Align Alignment) {
  auto & PointerVecTy = cast<VectorType>(*PointerVec.getType());
  auto & ElemTy = *cast<PointerType>(*PointerVecTy.getVectorElementType()).getPointerElementType();
  auto & VecTy = *VectorType::get(&ElemTy, PointerVecTy.getNumElements());
  auto * GatherFunc = Intrinsic::getDeclaration(&getModule(), Intrinsic::vp_gather, {&VecTy, &PointerVecTy});

  ShortValueVec Args{&PointerVec, &RequestPred(), &RequestEVL()};
  CallInst &GatherCall = *Builder.CreateCall(GatherFunc, Args);
  if (Alignment != None) GatherCall.addParamAttr(1, Attribute::getWithAlignment(getContext(), Alignment));
  return GatherCall;
}

} // namespace llvm
