//===----------- LoopDependenceAnalysis.cpp - Iter Dependences -------------==//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Internal pass that prints loop hotness stats based on `branch_weights`
// metadata provided by profiling.
//
//===----------------------------------------------------------------------===//

#include <llvm/Analysis/LoopHotnessStats.h>
#include <llvm/Analysis/LoopInfo.h>

using namespace llvm;

//#define DEBUG_TYPE "print<loop-hotness>"

enum class WEIGHT_TYPE {
  TRUEW,
  FALSEW
};

static int64_t
getWeightOfTerminatorBr(BasicBlock *BB, WEIGHT_TYPE WType = WEIGHT_TYPE::TRUEW) {
  BranchInst *CondBr =
    dyn_cast<BranchInst>(BB->getTerminator());
  assert(CondBr);
  MDNode *BrWeightMD = CondBr->getMetadata("prof");
  if (!BrWeightMD) {
    dbgs() << "PROBLEM!!!: " << *BB << "\n";
  }
  assert(BrWeightMD);
  Metadata *WeightMD;
  if (WType == WEIGHT_TYPE::TRUEW)
    WeightMD = BrWeightMD->getOperand(1);
  else
    WeightMD = BrWeightMD->getOperand(2);
  assert(WeightMD);
  ConstantAsMetadata *WeightMDConst =
    dyn_cast<ConstantAsMetadata>(WeightMD);
  assert(WeightMDConst);
  int64_t Weight =
    WeightMDConst->getValue()->getUniqueInteger().getSExtValue();
  return Weight;

}

static int64_t
getLoopBranchWeight(const Loop *L, WEIGHT_TYPE WType = WEIGHT_TYPE::TRUEW) {
  BasicBlock *ExitingBlock = L->getExitingBlock();
  // We want one exiting block because we want one branch
  // to control whether we exit the loop as it can be used
  // as a metric of how many times we iterated this loop.
  assert(ExitingBlock && "The loop has more than one exiting blocks");
  return getWeightOfTerminatorBr(ExitingBlock, WType);
}

static int64_t
numTimesLoopWasReached(const Loop *L) {
  /*
  TODO:
  This doesn't work and neither does it work
  if we use `loop-simplify` to make sure the header has
  a single predecessor, the preheaer. For some reason, none
  of this predecessor branches gets profiled.

  BasicBlock *Header = L->getHeader();
  assert(Header);
  int64_t SumWeights = 0;
  for (auto It = pred_begin(Header); It != pred_end(Header); ++It) {
    BasicBlock *Pred = *It;
    SumWeights += getWeightOfTerminatorBr(Pred);
  }
  return SumWeights;
  */
  return -1;
}

llvm::PreservedAnalyses LoopHotnessStats::run(Function &F,
                                              FunctionAnalysisManager &FAM) {
  LoopInfo &LI = FAM.getResult<LoopAnalysis>(F);
  // TODO: Maybe order them by line.
  for (const Loop *L : LI) {
    DebugLoc LoopLoc = L->getStartLoc();
    os << "Loop at: ";
    LoopLoc.print(os);
    os << "\n";

    int64_t NumReached = numTimesLoopWasReached(L);
    os << "    Reached: " << NumReached << "\n";

    int64_t TrueWeight = getLoopBranchWeight(L);
    int64_t FalseWeight = getLoopBranchWeight(L, WEIGHT_TYPE::FALSEW);
    os << "    True Weight (Trip Count): " << TrueWeight << "\n";
    os << "    False Weight: " << FalseWeight << "\n";
    os << "\n";
  }
  return llvm::PreservedAnalyses::all();
}
