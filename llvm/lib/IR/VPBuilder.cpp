#include <llvm/ADT/SmallVector.h>
#include <llvm/IR/FPEnv.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/Intrinsics.h>
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

Value *VPBuilder::getAllTrueMask() {
  auto *boolTy = Builder.getInt1Ty();
  auto *maskTy = VectorType::get(boolTy, StaticVectorLength);
  return ConstantInt::getAllOnesValue(maskTy);
}

Value &VPBuilder::RequestPred() {
  if (Mask)
    return *Mask;

  return *getAllTrueMask();
}

Value &VPBuilder::RequestEVL() {
  if (ExplicitVectorLength)
    return *ExplicitVectorLength;

  assert(!StaticVectorLength.isScalable() && "TODO vscale lowering");
  auto *intTy = Builder.getInt32Ty();
  return *ConstantInt::get(intTy, StaticVectorLength.getFixedValue());
}

Value *VPBuilder::CreateVectorCopy(Instruction &Inst, ValArray VecOpArray) {
  auto OC = Inst.getOpcode();
  auto VPID = VPIntrinsic::getForOpcode(OC);
  if (VPID == Intrinsic::not_intrinsic) {
    return nullptr;
  }

  std::optional<unsigned> MaskPosOpt = VPIntrinsic::getMaskParamPos(VPID);
  std::optional<unsigned> VLenPosOpt = VPIntrinsic::getVectorLengthParamPos(VPID);

  std::optional<int> CmpPredPos = std::nullopt;
  if (isa<CmpInst>(Inst)) {
    CmpPredPos = 2;
  }

  // TODO transfer alignment
  // Simply ignore masking where it does not matter.
  bool IgnoreMask = !Inst.mayHaveSideEffects();

  // construct VP vector operands (including pred and evl)
  SmallVector<Value *, 6> VecParams;
  for (size_t i = 0; i < Inst.getNumOperands() + 5; ++i) {
    if (MaskPosOpt && (i == (size_t)MaskPosOpt.value())) {
      // First operand of select is mask (singular exception)
      if (VPID != Intrinsic::vp_select) {
        Value * VecMask = nullptr;
        if (IgnoreMask)
          VecMask = getAllTrueMask();
        else 
          VecMask = &RequestPred();

        VecParams.push_back(&RequestPred());
      }
    }
    if (VLenPosOpt && (i == (size_t)VLenPosOpt.value())) {
      VecParams.push_back(&RequestEVL());
    }
    if (CmpPredPos && (i == (size_t)CmpPredPos.value())) {
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
      VPIntrinsic::getDeclarationForParams(&M, VPID, VecRetTy, VecParams);

  // Prepare constraint fp params
  // FIXME: \p Inst could also be just another VP intrinsic.
  const auto *CFPIntrin = dyn_cast<ConstrainedFPIntrinsic>(&Inst);
  SmallVector<OperandBundleDef, 2> ConstraintBundles;
  if (CFPIntrin) {
    auto RoundOpt = CFPIntrin->getRoundingMode();
    if (RoundOpt) {
      auto *RoundParam =
          GetConstrainedFPRounding(Builder.getContext(), RoundOpt.value());
      ConstraintBundles.emplace_back("cfp-round", RoundParam);
    }
    auto ExceptOpt = CFPIntrin->getExceptionBehavior();
    if (ExceptOpt) {
      auto *ExceptParam =
          GetConstrainedFPExcept(Builder.getContext(), ExceptOpt.value());
      ConstraintBundles.emplace_back("cfp-except", ExceptParam);
    }
  }

  // Transfer FMF flags
  auto VPCall = Builder.CreateCall(VPDecl, VecParams, ConstraintBundles,
                                   Inst.getName() + ".vp");
  if (CFPIntrin) {
    // FIXME:
    // VPCall->addAttribute(-1, Attribute::StrictFP);
  }

  auto FPOp = dyn_cast<FPMathOperator>(&Inst);
  if (FPOp && isa<FPMathOperator>(VPCall)) {
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
  if (AlignOpt.has_value()) {
    unsigned PtrPos =
        VPIntrinsic::getMemoryPointerParamPos(Intrinsic::vp_store).value();
    StoreCall.addParamAttr(
        PtrPos, Attribute::getWithAlignment(getContext(), AlignOpt.value()));
  }
  return StoreCall;
}

Value &VPBuilder::CreateContiguousLoad(Type *ReturnTy,
                                       Value &ElemPointer,
                                       MaybeAlign AlignOpt) {
  auto *LoadFunc = VPIntrinsic::getDeclarationForParams(
      &getModule(), Intrinsic::vp_load, ReturnTy, {&ElemPointer});
  ShortValueVec Args{&ElemPointer, &RequestPred(), &RequestEVL()};
  CallInst &LoadCall = *Builder.CreateCall(LoadFunc, Args);
  if (AlignOpt.has_value()) {
    unsigned PtrPos =
        VPIntrinsic::getMemoryPointerParamPos(Intrinsic::vp_load).value();
    LoadCall.addParamAttr(
        PtrPos, Attribute::getWithAlignment(getContext(), AlignOpt.value()));
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
#if 0
  if (AlignOpt.has_value()) {
    unsigned PtrPos =
        VPIntrinsic::GetMemoryPointerParamPos(Intrinsic::vp_scatter).getValue();
    // FIXME 'align' invalid here.
    // ScatterCall.addParamAttr(
    //     PtrPos, Attribute::getWithAlignment(getContext(), AlignOpt.getValue()));
  }
#endif
  return ScatterCall;
}

Value &VPBuilder::CreateGather(Type *RetTy, Value &PointerVec, MaybeAlign AlignOpt) {
  auto *GatherFunc = VPIntrinsic::getDeclarationForParams(
      &getModule(), Intrinsic::vp_gather, RetTy, {&PointerVec});

  ShortValueVec Args{&PointerVec, &RequestPred(), &RequestEVL()};
  CallInst &GatherCall = *Builder.CreateCall(GatherFunc, Args);
#if 0
  if (AlignOpt.has_value()) {
    unsigned PtrPos =
        VPIntrinsic::GetMemoryPointerParamPos(Intrinsic::vp_gather).getValue();
    // FIXME 'align' invalid here.
    // GatherCall.addParamAttr(
    //     PtrPos, Attribute::getWithAlignment(getContext(), AlignOpt.getValue()));
  }
#endif
  return GatherCall;
}

Value *VPBuilder::CreateVectorShift(Value *SrcVal, Value *Amount, Twine Name) {
  auto D = VPIntrinsic::getDeclarationForParams(
      &getModule(), Intrinsic::vp_vshift, SrcVal->getType(), {SrcVal, Amount});
  return Builder.CreateCall(D, {SrcVal, Amount, &RequestPred(), &RequestEVL()},
                            Name);
}

} // namespace llvm
