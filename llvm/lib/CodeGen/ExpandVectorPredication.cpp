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
#include "llvm/IR/Dominators.h"
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
#include "llvm/Transforms/Utils/LoopUtils.h"

using namespace llvm;

#define DEBUG_TYPE "expand-vec-pred"

STATISTIC(NumFoldedVL, "Number of folded vector length params");
STATISTIC(numLoweredVPOps, "Number of folded vector predication operations");

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
        DivTy->getVectorNumElements(),
        ConstantFP::get(DivTy->getVectorElementType(), 1.0));
  }
  llvm_unreachable("Not a valid type for division");
}

/// Transfer all properties from \p OldOp to \p NewOp and replace all uses.
/// OldVP gets erased.
void ReplaceOperation(Value *NewOp, VPIntrinsic *OldOp) {
  OldOp->replaceAllUsesWith(NewOp);
  OldOp->eraseFromParent();
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

  switch (VPI->getFunctionalOpcode()) {
  default:
    // can safely ignore the predicate
    break;

  // Division operators need a safe divisor on masked-off lanes (1.0)
  case Instruction::UDiv:
  case Instruction::SDiv:
  case Instruction::URem:
  case Instruction::SRem:
    // 2nd operand must not be zero
    auto SafeDivisor = GetSafeDivisor(VPI->getType());
    SndOp = Builder.CreateSelect(Mask, SndOp, SafeDivisor);
  }

  auto NewBinOp = Builder.CreateBinOp(
      static_cast<Instruction::BinaryOps>(VPI->getFunctionalOpcode()), FirstOp,
      SndOp, VPI->getName(), nullptr);

  ReplaceOperation(NewBinOp, VPI);
}

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
    ElementCount ElemCount = VPI->getVectorLength();
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

    llvm_unreachable("cannot lower this VP operation");
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
