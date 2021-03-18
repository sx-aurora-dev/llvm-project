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

enum class ERROR {
  NONE = 0,
  NO_BR,  // The terminator is not a conditional branch
  NO_MD,  // The branch has no metadata
};

enum class BRANCH_WEIGHT_RESULT {
  CORRECT,
  NO_APPROPRIATE_BLOCK,
  NEVER_REACHED,
};

static ERROR
getWeightOfTerminatorBr(BasicBlock *BB, int64_t *Weight, WEIGHT_TYPE WType = WEIGHT_TYPE::TRUEW) {
  BranchInst *CondBr =
    dyn_cast<BranchInst>(BB->getTerminator());
  if (!CondBr || CondBr->isUnconditional()) {
    return ERROR::NO_BR;
  }
  MDNode *BrWeightMD = CondBr->getMetadata("prof");
  if (!BrWeightMD) {
    return ERROR::NO_MD;
  }
  Metadata *WeightMD;
  if (WType == WEIGHT_TYPE::TRUEW)
    WeightMD = BrWeightMD->getOperand(1);
  else
    WeightMD = BrWeightMD->getOperand(2);
  assert(WeightMD);
  ConstantAsMetadata *WeightMDConst =
    dyn_cast<ConstantAsMetadata>(WeightMD);
  assert(WeightMDConst);
  *Weight = WeightMDConst->getValue()->getUniqueInteger().getSExtValue();
  return ERROR::NONE;
}

// Return true if an appropriate branch was found. Otherwise, false.
static BRANCH_WEIGHT_RESULT
getLoopBranchWeight(const Loop *L, int64_t *Weight, WEIGHT_TYPE WType = WEIGHT_TYPE::TRUEW) {
  BasicBlock *Header = L->getHeader();
  assert(Header);
  ERROR error = ERROR::NONE;
  if (L->isLoopExiting(Header)) {
    error = getWeightOfTerminatorBr(Header, Weight, WType);
    if (error == ERROR::NONE) {
      return BRANCH_WEIGHT_RESULT::CORRECT;
    } else if (error == ERROR::NO_MD) {
      return BRANCH_WEIGHT_RESULT::NEVER_REACHED;
    } // else: try latch
    assert(error == ERROR::NO_BR);
  }
  BasicBlock *Latch = L->getLoopLatch();
  // We have run loop-simplify before
  assert(Latch);
  if (L->isLoopExiting(Latch)) {
    error = getWeightOfTerminatorBr(Latch, Weight, WType);
    if (error == ERROR::NONE) {
      return BRANCH_WEIGHT_RESULT::CORRECT;
    } else if (error == ERROR::NO_MD) {
      return BRANCH_WEIGHT_RESULT::NEVER_REACHED;
    } // else: try exiting block
    assert(error == ERROR::NO_BR);
  }
  BasicBlock *ExitingBlock = L->getExitingBlock();
  if (!ExitingBlock) {
    return BRANCH_WEIGHT_RESULT::NO_APPROPRIATE_BLOCK;
  }
  error = getWeightOfTerminatorBr(Latch, Weight, WType);
  if (error == ERROR::NONE) {
    return BRANCH_WEIGHT_RESULT::CORRECT;
  } else if (error == ERROR::NO_MD) {
    return BRANCH_WEIGHT_RESULT::NEVER_REACHED;
  }
  assert(error == ERROR::NO_BR);
  return BRANCH_WEIGHT_RESULT::NO_APPROPRIATE_BLOCK;
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

    // TripCount is the same as the true weight, although we don't account
    // for the fact that the loop may have been reached multiple times.
    int64_t TripCount = -1;
    os << "    ";
    switch (getLoopBranchWeight(L, &TripCount)) {
    case BRANCH_WEIGHT_RESULT::NO_APPROPRIATE_BLOCK:
    {
      os << "ERROR: No appropriate block was found.\n";
    } break;
    case BRANCH_WEIGHT_RESULT::NEVER_REACHED:
    {
      os << "ERROR: Never reached\n";
    } break;
    default:
      os << "(Cumulative) Trip Count: " << TripCount << "\n";
    }
  }
  return llvm::PreservedAnalyses::all();
}
