//===--- CodeGen/ExpandVectorPredication.cpp - Expand VP intrinsics -===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This pass implements IR expansion for vector predication intrinsics, allowing
// targets to enable vector predication until just before codegen.
//
//===----------------------------------------------------------------------===//

#include "llvm/CodeGen/ExpandVectorPredication.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/CodeGen/Passes.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PredicatedInst.h"
#include "llvm/InitializePasses.h"
#include "llvm/Pass.h"
#include "llvm/Support/Debug.h"

using namespace llvm;

#define DEBUG_TYPE "expand-vec-pred"

STATISTIC(NumFoldedVL, "Number of folded vector length params");
STATISTIC(numLoweredVPOps, "Number of folded vector predication operations");

/// \returns Whether the vector mask \p MaskVal has all lane bits set.
static bool IsAllTrueMask(Value *MaskVal) {
  auto ConstVec = dyn_cast<ConstantVector>(MaskVal);
  if (!ConstVec)
    return false;
  return ConstVec->isAllOnesValue();
}

/// \returns The constant \p ConstVal broadcasted to \p VecTy.
static Value *BroadcastConstant(Constant *ConstVal, VectorType *VecTy) {
  return ConstantDataVector::getSplat(VecTy->getVectorNumElements(), ConstVal);
}

/// \returns The neutral element of the reduction \p VPRedID.
static Value *GetNeutralElementVector(Intrinsic::ID VPRedID,
                                      VectorType *VecTy) {
  unsigned ElemBits = VecTy->getScalarSizeInBits();

  switch (VPRedID) {
  default:
    abort(); // invalid vp reduction intrinsic

  case Intrinsic::vp_reduce_add:
  case Intrinsic::vp_reduce_or:
  case Intrinsic::vp_reduce_xor:
  case Intrinsic::vp_reduce_umax:
    return Constant::getNullValue(VecTy);

  case Intrinsic::vp_reduce_mul:
    return BroadcastConstant(
        ConstantInt::get(VecTy->getElementType(), 1, false), VecTy);

  case Intrinsic::vp_reduce_and:
  case Intrinsic::vp_reduce_umin:
    return Constant::getAllOnesValue(VecTy);

  case Intrinsic::vp_reduce_smin:
    return BroadcastConstant(
        ConstantInt::get(VecTy->getContext(),
                         APInt::getSignedMaxValue(ElemBits)),
        VecTy);
  case Intrinsic::vp_reduce_smax:
    return BroadcastConstant(
        ConstantInt::get(VecTy->getContext(),
                         APInt::getSignedMinValue(ElemBits)),
        VecTy);

  case Intrinsic::vp_reduce_fmin:
  case Intrinsic::vp_reduce_fmax:
    return BroadcastConstant(ConstantFP::getQNaN(VecTy->getElementType()),
                             VecTy);
  case Intrinsic::vp_reduce_fadd:
    return BroadcastConstant(ConstantFP::get(VecTy->getElementType(), 0.0),
                             VecTy);
  case Intrinsic::vp_reduce_fmul:
    return BroadcastConstant(ConstantFP::get(VecTy->getElementType(), 1.0),
                             VecTy);
  }
}

namespace {

/// \brief The logical vector element size of this operation.
int32_t GetFunctionalVectorElementSize() {
  return 64; // TODO infer from operation (eg
             // VPIntrinsic::getVectorElementSize())
}

/// \returns A vector with ascending integer indices (<0, 1, ..., NumElems-1>).
Value *CreateStepVector(IRBuilder<> &Builder, int32_t ElemBits,
                        int32_t NumElems) {
  // TODO add caching
  SmallVector<Constant *, 16> ConstElems;

  Type *LaneTy = Builder.getIntNTy(ElemBits);

  for (int32_t Idx = 0; Idx < NumElems; ++Idx) {
    ConstElems.push_back(ConstantInt::get(LaneTy, Idx, false));
  }

  return ConstantVector::get(ConstElems);
}

/// \returns A bitmask that is true where the lane position is less-than
///
/// \p Builder
///    Used for instruction creation.
/// \p VLParam
///    The explicit vector length parameter to test against the lane
///    positions.
// \p ElemBits
///    Integer bitsize used for the generated ICmp instruction.
/// \p NumElems
///    Static vector length of the operation.
Value *ConvertVLToMask(IRBuilder<> &Builder, Value *VLParam, int32_t ElemBits,
                       int32_t NumElems) {
  // TODO increase elem bits to shrink wrap VLParam where necessary (eg if
  // operating on i8)
  Type *LaneTy = Builder.getIntNTy(ElemBits);

  auto ExtVLParam = Builder.CreateSExt(VLParam, LaneTy);
  auto VLSplat = Builder.CreateVectorSplat(NumElems, ExtVLParam);

  auto IdxVec = CreateStepVector(Builder, ElemBits, NumElems);

  return Builder.CreateICmp(CmpInst::ICMP_ULT, IdxVec, VLSplat);
}

/// \returns A non-excepting divisor constant for this type.
Constant *GetSafeDivisor(Type *DivTy) {
  if (DivTy->isIntOrIntVectorTy()) {
    return Constant::getAllOnesValue(DivTy);
  }
  if (DivTy->isFPOrFPVectorTy()) {
    return ConstantVector::getSplat(
        DivTy->getVectorElementCount(),
        ConstantFP::get(DivTy->getVectorElementType(), 1.0));
  }
  llvm_unreachable("Not a valid type for division");
}

/// Transfer operation properties from \p OldVPI to \p NewVal.
void TransferDecorations(Value *NewVal, VPIntrinsic *OldVPI) {
  auto NewInst = dyn_cast<Instruction>(NewVal);
  if (!NewInst || !isa<FPMathOperator>(NewVal))
    return;

  auto OldFMOp = dyn_cast<FPMathOperator>(OldVPI);
  if (!OldFMOp)
    return;

  NewInst->setFastMathFlags(OldFMOp->getFastMathFlags());
}

/// Transfer all properties from \p OldOp to \p NewOp and replace all uses.
/// OldVP gets erased.
void ReplaceOperation(Value *NewOp, VPIntrinsic *OldOp) {
  TransferDecorations(NewOp, OldOp);
  OldOp->replaceAllUsesWith(NewOp);
  OldOp->eraseFromParent();
}

/// \brief Lower this vector-predicated operator into standard IR.
void LowerVPUnaryOperator(VPIntrinsic *VPI) {
  assert(VPI->canIgnoreVectorLengthParam());
  auto OC = VPI->getFunctionalOpcode();
  auto FirstOp = VPI->getOperand(0);
  assert(OC == Instruction::FNeg);
  auto I = cast<Instruction>(VPI);
  IRBuilder<> Builder(I);
  auto NewFNeg = Builder.CreateFNegFMF(FirstOp, I, I->getName());
  ReplaceOperation(NewFNeg, VPI);
}

/// \brief Lower this VP binary operator to a non-VP binary operator.
void LowerVPBinaryOperator(VPIntrinsic *VPI) {
  assert(VPI->canIgnoreVectorLengthParam());
  assert(VPI->isBinaryOp());

  auto OldBinOp = cast<Instruction>(VPI);

  auto FirstOp = VPI->getOperand(0);
  auto SndOp = VPI->getOperand(1);

  IRBuilder<> Builder(OldBinOp);
  auto Mask = VPI->getMaskParam();

  // Blend in safe operands
  if (!IsAllTrueMask(Mask)) {
    switch (VPI->getFunctionalOpcode()) {
    default:
      // can safely ignore the predicate
      break;

    // Division operators need a safe divisor on masked-off lanes (1.0)
    case Instruction::FDiv:
    case Instruction::FRem:
    case Instruction::UDiv:
    case Instruction::SDiv:
    case Instruction::URem:
    case Instruction::SRem:
      // 2nd operand must not be zero
      auto SafeDivisor = GetSafeDivisor(VPI->getType());
      SndOp = Builder.CreateSelect(Mask, SndOp, SafeDivisor);
    }
  }

  auto NewBinOp = Builder.CreateBinOp(
      static_cast<Instruction::BinaryOps>(VPI->getFunctionalOpcode()), FirstOp,
      SndOp, VPI->getName(), nullptr);

  ReplaceOperation(NewBinOp, VPI);
}

/// \brief Lower this vector-predicated cast operator.
void LowerVPCastOperator(VPIntrinsic *VPI) {
  assert(VPI->canIgnoreVectorLengthParam());
  assert(!VPI->isConstrainedOp());
  auto OC = VPI->getFunctionalOpcode();
  IRBuilder<> Builder(cast<Instruction>(VPI));
  auto NewCast =
      Builder.CreateCast(static_cast<Instruction::CastOps>(OC),
                         VPI->getArgOperand(0), VPI->getType(), VPI->getName());

  ReplaceOperation(NewCast, VPI);
}

/// \brief Lower llvm.vp.compose.* into a select instruction
void LowerVPCompose(VPIntrinsic *VPI) {
  auto ElemBits = GetFunctionalVectorElementSize();
  ElementCount ElemCount = VPI->getStaticVectorLength();
  assert(!ElemCount.Scalable && "TODO scalable type support");

  IRBuilder<> Builder(cast<Instruction>(VPI));
  auto PivotMask =
      ConvertVLToMask(Builder, VPI->getOperand(2), ElemBits, ElemCount.Min);
  auto NewCompose = Builder.CreateSelect(PivotMask, VPI->getOperand(0),
                                         VPI->getOperand(1), VPI->getName());

  ReplaceOperation(NewCompose, VPI);
}

/// \brief Lower this llvm.vp.fma intrinsic to a llvm.fma intrinsic.
void LowerToIntrinsic(VPIntrinsic *VPI) {
  assert(VPI->canIgnoreVectorLengthParam());

  auto I = cast<Instruction>(VPI);
  auto M = I->getParent()->getModule();
  IRBuilder<> Builder(I);
  Intrinsic::ID IID = VPI->getFunctionalIntrinsicID();
  assert(IID != Intrinsic::not_intrinsic && "cannot lower to non-VP intrinsic");
  assert(!VPI->isConstrainedOp() &&
         "TODO implement lowering to constrained fp");
  assert(!VPIntrinsic::IsVPIntrinsic(IID));

  SmallVector<Type *, 2> IntrinTypeVec;
  IntrinTypeVec.push_back(VPI->getType()); // TODO simplify

  // Implicitly assumes that the return type is sufficient for disambiguation.
  Function *IntrinFunc = Intrinsic::getDeclaration(M, IID, IntrinTypeVec);
  assert(IntrinFunc);

  LLVM_DEBUG(dbgs() << "Using " << *IntrinFunc << " to lower "
                    << VPI->getCalledFunction() << "\n");

  // Construct argument vector.
  assert(!IntrinFunc->getFunctionType()->isVarArg());
  unsigned NumIntrinParams = IntrinFunc->getFunctionType()->getNumParams();
  SmallVector<Value *, 4> IntrinArgs;
  for (unsigned i = 0; i < NumIntrinParams; ++i) {
    IntrinArgs.push_back(VPI->getArgOperand(i));
  }

  auto NewIntrin = Builder.CreateCall(IntrinFunc, IntrinArgs, VPI->getName());

  ReplaceOperation(NewIntrin, VPI);
}

/// \brief Lower this llvm.vp.reduce.* intrinsic to a llvm.experimental.reduce.*
/// intrinsic.
void LowerVPReduction(VPIntrinsic *VPI) {
  assert(VPI->canIgnoreVectorLengthParam());
  assert(VPI->isReductionOp());

  auto &I = *cast<Instruction>(VPI);
  IRBuilder<> Builder(&I);
  auto M = Builder.GetInsertBlock()->getModule();
  assert(M && "No module to declare reduction intrinsic in!");

  SmallVector<Value *, 3> Args;

  Value *RedVectorParam = VPI->getReductionVectorParam();
  Value *RedAccuParam = VPI->getReductionAccuParam();
  Value *MaskParam = VPI->getMaskParam();
  auto FunctionalID = VPI->getFunctionalIntrinsicID();

  // Insert neutral element in masked-out positions
  bool IsUnmasked = IsAllTrueMask(VPI->getMaskParam());
  if (!IsUnmasked) {
    auto *NeutralVector = GetNeutralElementVector(
        VPI->getIntrinsicID(), cast<VectorType>(RedVectorParam->getType()));
    RedVectorParam =
        Builder.CreateSelect(MaskParam, RedVectorParam, NeutralVector);
  }

  auto VecTypeArg = RedVectorParam->getType();

  Value *NewReduct;
  switch (FunctionalID) {
  default: {
    auto RedIntrinFunc = Intrinsic::getDeclaration(M, FunctionalID, VecTypeArg);
    NewReduct = Builder.CreateCall(RedIntrinFunc, RedVectorParam, I.getName());
    assert(!RedAccuParam && "accu dropped");
  } break;

  case Intrinsic::experimental_vector_reduce_v2_fadd:
  case Intrinsic::experimental_vector_reduce_v2_fmul: {
    auto TypeArg = RedAccuParam->getType();
    auto RedIntrinFunc =
        Intrinsic::getDeclaration(M, FunctionalID, {TypeArg, VecTypeArg});
    NewReduct = Builder.CreateCall(RedIntrinFunc,
                                   {RedAccuParam, RedVectorParam}, I.getName());
  } break;
  }

  TransferDecorations(NewReduct, VPI);
  I.replaceAllUsesWith(NewReduct);
  I.eraseFromParent();
}

/// \brief Lower this llvm.vp.(load|store|gather|scatter) to a non-vp
/// instruction.
void LowerVPMemoryIntrinsic(VPIntrinsic *VPI) {
  assert(VPI->canIgnoreVectorLengthParam());
  auto &I = cast<Instruction>(*VPI);

  auto MaskParam = VPI->getMaskParam();
  auto PtrParam = VPI->getMemoryPointerParam();
  auto DataParam = VPI->getMemoryDataParam();
  bool IsUnmasked = IsAllTrueMask(MaskParam);

  IRBuilder<> Builder(&I);
  MaybeAlign AlignOpt = VPI->getPointerAlignment();

  Value *NewMemoryInst = nullptr;
  switch (VPI->getIntrinsicID()) {
  default:
    abort(); // not a VP memory intrinsic

  case Intrinsic::vp_store: {
    if (IsUnmasked) {
      StoreInst *NewStore = Builder.CreateStore(DataParam, PtrParam, false);
      if (AlignOpt.hasValue())
        NewStore->setAlignment(AlignOpt.getValue());
      NewMemoryInst = NewStore;
    } else {
      NewMemoryInst = Builder.CreateMaskedStore(
          DataParam, PtrParam, AlignOpt.valueOrOne(), MaskParam);
    }
  } break;

  case Intrinsic::vp_load: {
    if (IsUnmasked) {
      LoadInst *NewLoad = Builder.CreateLoad(PtrParam, false);
      if (AlignOpt.hasValue())
        NewLoad->setAlignment(AlignOpt.getValue());
      NewMemoryInst = NewLoad;
    } else {
      NewMemoryInst =
          Builder.CreateMaskedLoad(PtrParam, AlignOpt.valueOrOne(), MaskParam);
    }
  } break;

  case Intrinsic::vp_scatter: {
    // if (IsUnmasked) {
    //   StoreInst *NewStore = Builder.CreateStore(DataParam, PtrParam, false);
    //   if (AlignOpt.hasValue()) NewStore->setAlignment(AlignOpt.getValue());
    //   NewMemoryInst = NewStore;
    // } else {
    NewMemoryInst = Builder.CreateMaskedScatter(DataParam, PtrParam,
                                                AlignOpt.valueOrOne(), MaskParam);
    // }
  } break;

  case Intrinsic::vp_gather: {
    // if (IsUnmasked) {
    //   LoadInst *NewLoad = Builder.CreateLoad(I.getType(), PtrParam, false);
    //   if (AlignOpt.hasValue()) NewLoad->setAlignment(AlignOpt.getValue());
    //   NewMemoryInst = NewLoad;
    // } else {
    NewMemoryInst = Builder.CreateMaskedGather(PtrParam, AlignOpt.valueOrOne(),
                                               MaskParam, nullptr, I.getName());
    // }
  } break;
  }

  assert(NewMemoryInst);
  ReplaceOperation(NewMemoryInst, VPI);
}

/// \brief Lower llvm.vp.select.* to a select instruction.
void LowerVPSelectInst(VPIntrinsic *VPI) {
  auto I = cast<Instruction>(VPI);

  auto NewSelect = SelectInst::Create(VPI->getMaskParam(), VPI->getOperand(1),
                                      VPI->getOperand(2), I->getName(), I, I);
  ReplaceOperation(NewSelect, VPI);
}

/// \brief Lower llvm.vp.(icmp|fcmp) to an icmp or fcmp instruction.
void LowerVPCompare(VPIntrinsic *VPI) {
  auto NewCmp = CmpInst::Create(
      static_cast<Instruction::OtherOps>(VPI->getFunctionalOpcode()),
      VPI->getCmpPredicate(), VPI->getOperand(0), VPI->getOperand(1),
      VPI->getName(), cast<Instruction>(VPI));
  ReplaceOperation(NewCmp, VPI);
}

/// \brief Try to lower this vp_vshift operation.
bool TryLowerVShift(VPIntrinsic *VPI) {
  // vshift(vec, amount, mask, vlen)

  // cannot lower dynamic shift amount
  auto *SrcVal = VPI->getArgOperand(0);
  auto *AmountVal = VPI->getArgOperand(1);
  if (!isa<ConstantInt>(AmountVal))
    return false;
  int64_t Amount = cast<ConstantInt>(AmountVal)->getSExtValue();

  // cannot lower scalable vector size
  auto ElemCount = VPI->getType()->getVectorElementCount();
  if (ElemCount.Scalable)
    return false;
  int VecWidth = ElemCount.Min;

  auto IntTy = Type::getInt32Ty(VPI->getContext());

  // constitute shuffle mask.
  std::vector<Constant *> Elems;
  for (int i = 0; i < (int)ElemCount.Min; ++i) {
    int64_t SrcLane = i - Amount;
    if (SrcLane < 0 || SrcLane >= VecWidth)
      Elems.push_back(UndefValue::get(IntTy));
    else
      Elems.push_back(ConstantInt::get(IntTy, SrcLane));
  }
  auto *ShuffleMask = ConstantVector::get(Elems);

  auto *V2 = UndefValue::get(SrcVal->getType());

  // Translate to a shuffle
  auto NewI = new ShuffleVectorInst(SrcVal, V2, ShuffleMask, VPI->getName(),
                                    cast<Instruction>(VPI));
  ReplaceOperation(NewI, VPI);
  return true;
}

/// \brief Lower a llvm.vp.* intrinsic that is not functionally equivalent to a
/// standard IR instruction.
void LowerUnmatchedVPIntrinsic(VPIntrinsic *VPI) {
  if (VPI->isReductionOp())
    return LowerVPReduction(VPI);

  switch (VPI->getIntrinsicID()) {
  default:
    LowerToIntrinsic(VPI);
    break;

  // Shuffles
  case Intrinsic::vp_compress:
  case Intrinsic::vp_expand:
  case Intrinsic::vp_vshift:
    if (TryLowerVShift(VPI))
      return;

    LLVM_DEBUG(dbgs() << "Silently keeping VP intrinsic: can not substitute: "
                      << *VPI << "\n");
    return;

  case Intrinsic::vp_compose:
    LowerVPCompose(VPI);
    break;

  case Intrinsic::vp_gather:
  case Intrinsic::vp_scatter:
    LowerVPMemoryIntrinsic(VPI);
    break;
  }
}

/// \brief Expand llvm.vp.* intrinsics as requested by \p TTI.
bool expandVectorPredication(Function &F, const TargetTransformInfo *TTI) {
  bool Changed = false;

  // Holds all vector-predicated ops with an effective vector length param that
  // needs to be folded into the mask param.
  SmallVector<VPIntrinsic *, 4> ExpandVLWorklist;

  // Holds all vector-predicated ops that need to translated into non-VP ops.
  SmallVector<VPIntrinsic *, 4> ExpandOpWorklist;

  for (auto &I : instructions(F)) {
    auto *VPI = dyn_cast<VPIntrinsic>(&I);
    if (!VPI)
      continue;

    auto &PI = cast<PredicatedInstruction>(*VPI);

    bool supportsVPOp = TTI->supportsVPOperation(PI);
    bool hasEffectiveVLParam = !VPI->canIgnoreVectorLengthParam();
    bool shouldFoldVLParam =
        !supportsVPOp || TTI->shouldFoldVectorLengthIntoMask(PI);

    LLVM_DEBUG(dbgs() << "Inspecting " << *VPI
                      << "\n:: target-support=" << supportsVPOp
                      << ", effectiveVecLen=" << hasEffectiveVLParam
                      << ", shouldFoldVecLen=" << shouldFoldVLParam << "\n");

    if (shouldFoldVLParam) {
      if (hasEffectiveVLParam && VPI->getMaskParam()) {
        ExpandVLWorklist.push_back(VPI);
      } else {
        ExpandOpWorklist.push_back(VPI);
      }
    }
  }

  // Fold vector-length params into the mask param.
  LLVM_DEBUG(dbgs() << "\n:::: Folding vlen into mask. ::::\n");
  for (VPIntrinsic *VPI : ExpandVLWorklist) {
    ++NumFoldedVL;
    Changed = true;

    LLVM_DEBUG(dbgs() << "Folding vlen for op: " << *VPI << '\n');

    IRBuilder<> Builder(cast<Instruction>(VPI));

    Value *OldMaskParam = VPI->getMaskParam();
    Value *OldVLParam = VPI->getVectorLengthParam();
    assert(OldMaskParam && "no mask param to fold the vl param into");
    assert(OldVLParam && "no vector length param to fold away");

    LLVM_DEBUG(dbgs() << "OLD vlen: " << *OldVLParam << '\n');
    LLVM_DEBUG(dbgs() << "OLD mask: " << *OldMaskParam << '\n');

    // Determine the lane bit size that should be used to lower this op
    auto ElemBits = GetFunctionalVectorElementSize();
    ElementCount ElemCount = VPI->getStaticVectorLength();
    assert(!ElemCount.Scalable && "TODO scalable vector support");

    // Lower VL to M
    auto *VLMask =
        ConvertVLToMask(Builder, OldVLParam, ElemBits, ElemCount.Min);
    auto NewMaskParam = Builder.CreateAnd(VLMask, OldMaskParam);
    VPI->setMaskParam(
        NewMaskParam); // FIXME cannot trivially use the PI abstraction here.

    // Disable VL
    auto FullVL = Builder.getInt32(ElemCount.Min);
    VPI->setVectorLengthParam(FullVL);
    assert(VPI->canIgnoreVectorLengthParam() &&
           "transformation did not render the vl param ineffective!");

    LLVM_DEBUG(dbgs() << "NEW vlen: " << *FullVL << '\n');
    LLVM_DEBUG(dbgs() << "NEW mask: " << *NewMaskParam << '\n');

    auto &PI = cast<PredicatedInstruction>(*VPI);
    if (!TTI->supportsVPOperation(PI)) {
      ExpandOpWorklist.push_back(VPI);
    }
  }

  // Translate into non-VP ops
  LLVM_DEBUG(dbgs() << "\n:::: Lowering VP into non-VP ops ::::\n");
  for (VPIntrinsic *VPI : ExpandOpWorklist) {
    ++numLoweredVPOps;
    Changed = true;

    LLVM_DEBUG(dbgs() << "Lowering vp op: " << *VPI << '\n');

    // Try lowering to a LLVM instruction first.
    unsigned OC = VPI->getFunctionalOpcode();
#define FIRST_UNARY_INST(X) unsigned FirstUnOp = X;
#define LAST_UNARY_INST(X) unsigned LastUnOp = X;
#define FIRST_BINARY_INST(X) unsigned FirstBinOp = X;
#define LAST_BINARY_INST(X) unsigned LastBinOp = X;
#define FIRST_CAST_INST(X) unsigned FirstCastOp = X;
#define LAST_CAST_INST(X) unsigned LastCastOp = X;
#include "llvm/IR/Instruction.def"

    if (FirstBinOp <= OC && OC <= LastBinOp) {
      LowerVPBinaryOperator(VPI);
      continue;
    }
    if (FirstUnOp <= OC && OC <= LastUnOp) {
      LowerVPUnaryOperator(VPI);
      continue;
    }
    if (FirstCastOp <= OC && OC <= LastCastOp) {
      LowerVPCastOperator(VPI);
      continue;
    }

    // Lower to a non-VP intrinsic.
    switch (OC) {
    default:
      abort(); // unexpected intrinsic

    case Instruction::Call:
      LowerUnmatchedVPIntrinsic(VPI);
      break;

    case Instruction::Select:
      LowerVPSelectInst(VPI);
      break;

    case Instruction::Store:
    case Instruction::Load:
      LowerVPMemoryIntrinsic(VPI);
      break;

    case Instruction::ICmp:
    case Instruction::FCmp:
      LowerVPCompare(VPI);
      break;
    }
  }

  return Changed;
}

class ExpandVectorPredication : public FunctionPass {
public:
  static char ID;
  ExpandVectorPredication() : FunctionPass(ID) {
    initializeExpandVectorPredicationPass(*PassRegistry::getPassRegistry());
  }

  bool runOnFunction(Function &F) override {
    const auto *TTI = &getAnalysis<TargetTransformInfoWrapperPass>().getTTI(F);
    return expandVectorPredication(F, TTI);
  }

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequired<TargetTransformInfoWrapperPass>();
    AU.setPreservesCFG();
  }
};
} // namespace

char ExpandVectorPredication::ID;
INITIALIZE_PASS_BEGIN(ExpandVectorPredication, "expand-vec-pred",
                      "Expand vector predication intrinsics", false, false)
INITIALIZE_PASS_DEPENDENCY(TargetTransformInfoWrapperPass)
INITIALIZE_PASS_DEPENDENCY(DominatorTreeWrapperPass)
INITIALIZE_PASS_END(ExpandVectorPredication, "expand-vec-pred",
                    "Expand vector predication intrinsics", false, false)

FunctionPass *llvm::createExpandVectorPredicationPass() {
  return new ExpandVectorPredication();
}

PreservedAnalyses
ExpandVectorPredicationPass::run(Function &F, FunctionAnalysisManager &AM) {
  const auto &TTI = AM.getResult<TargetIRAnalysis>(F);
  if (!expandVectorPredication(F, &TTI))
    return PreservedAnalyses::all();
  PreservedAnalyses PA;
  PA.preserveSet<CFGAnalyses>();
  return PA;
}
