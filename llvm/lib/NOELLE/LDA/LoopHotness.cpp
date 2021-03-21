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

#include "llvm/NOELLE/LDA/LoopHotness.h"
#include "llvm/NOELLE/LDA/LoopDependenceAnalysis.h"

#include "llvm/Analysis/DependenceAnalysis.h"
#include "llvm/Analysis/VectorUtils.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Support/CommandLine.h"
#include <llvm/Analysis/LoopInfo.h>

using namespace llvm;

#define DEBUG_TYPE "print<loop-hotness>"


static llvm::cl::opt<std::string>
    LoopHotnessPath("loop-hotness-path",
                    llvm::cl::desc("Path of the file being analyzed."),
                    llvm::cl::init(""));

enum class WEIGHT_TYPE { TRUEW, FALSEW };

enum class ERROR {
  NONE = 0,
  NO_BR, // The terminator is not a conditional branch
  NO_MD, // The branch has no metadata
};

enum class BRANCH_WEIGHT_RESULT {
  CORRECT,
  NO_APPROPRIATE_BLOCK,
  NEVER_REACHED,
};

static ERROR getWeightOfTerminatorBr(BasicBlock *BB, int64_t *Weight,
                                     WEIGHT_TYPE WType = WEIGHT_TYPE::TRUEW) {
  BranchInst *CondBr = dyn_cast<BranchInst>(BB->getTerminator());
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
  ConstantAsMetadata *WeightMDConst = dyn_cast<ConstantAsMetadata>(WeightMD);
  assert(WeightMDConst);
  *Weight = WeightMDConst->getValue()->getUniqueInteger().getSExtValue();
  return ERROR::NONE;
}

// Return true if an appropriate branch was found. Otherwise, false.
static BRANCH_WEIGHT_RESULT
getLoopBranchWeight(const Loop *L, int64_t *Weight,
                    WEIGHT_TYPE WType = WEIGHT_TYPE::TRUEW) {
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






struct DepVectorComponent {
  char Dir;
  // TODO: Probably change to SCEV
  int64_t Dist;
  const llvm::Loop *Loop = nullptr;

  void print() const {
    dbgs() << "{" << Dir << ", " << Dist << ", "
           << ((Loop) ? Loop->getName() : "") << "}";
  }
  void negate() {
    assert(Dir == '=' || Dir == '<' || Dir == '>');
    if (Dir == '=')
      return;
    Dist = -Dist;
    Dir = (Dir == '<') ? '>' : '<';
  }
};

struct DepVector {
  constexpr static size_t MaxComps = 4;
  SmallVector<DepVectorComponent, MaxComps> Comps;

  DepVector(int Dimensions) : Comps(Dimensions) {
    // Start with everything destined to be squashed
    // and only fill those that don't.
    for (DepVectorComponent &DVC : Comps) {
      DVC.Dir = 'S';
    }
    assert(Dimensions <= MaxComps);
  }

  const DepVectorComponent operator[](size_t I) const { return Comps[I]; }
  DepVectorComponent &operator[](size_t I) { return Comps[I]; }

  void print() const {
    if (Comps.size() == 0) {
      dbgs() << "(Empty)";
      return;
    }
    dbgs() << "(";
    Comps[0].print();
    for (size_t i = 1; i < Comps.size(); ++i) {
      dbgs() << ", ";
      Comps[i].print();
    }
    dbgs() << ")";
    dbgs() << "\n";
  }

  size_t size() const { return Comps.size(); }

  bool verify() const {
    for (DepVectorComponent DVC : Comps) {
      if (DVC.Dir == '<' && DVC.Dist <= 0)
        return false;
      else if (DVC.Dir == '>' && DVC.Dist >= 0)
        return false;
      else if (DVC.Dir == '=' && DVC.Dist != 0)
        return false;
    }
    return true;
  }

  void reflect() {
    for (DepVectorComponent &DVC : Comps) {
      DVC.negate();
    }
  }
};

static bool pointsToPrevious(DepVector &IterDV, size_t StartFrom = 0) {
  int64_t FirstNonZero = 0;
  for (size_t I = StartFrom; I < IterDV.size(); ++I) {
    if (IterDV[I].Dist != 0) {
      FirstNonZero = IterDV[I].Dist;
      break;
    }
  }
  // We didn't find non-zero element.
  if (FirstNonZero > 0)
    return false;
  assert(FirstNonZero <= 0);
  return true;
}

static void reflectIfNeeded(DepVector &IterDV) {
  if (pointsToPrevious(IterDV))
    IterDV.reflect();
  return;
}

static ConstVF getMaxAllowedVecFact(DepVector &IterDV) {
  assert(IterDV.verify());
  ConstVF Best = LoopDependence::getBestPossible().VectorizationFactor;
  if (!IterDV.size())
    return Best;

  if (IterDV.size() == 1) {
    int Dist = IterDV[0].Dist;
    if (Dist) {
      return Dist;
    }
    return Best;
  }

  // Squash the first dimension which is the equivalent of vectorizing it.
  if (pointsToPrevious(IterDV, 1))
    return IterDV[0].Dist;
  return Best;
}

static ConstVF getMaxAllowedVecFact(std::unique_ptr<Dependence> &Dep) {
  ConstVF Worst = LoopDependence::getWorstPossible().VectorizationFactor;
  DepVector IterDV(Dep->getLevels());
  // Verify that all levels are constant (remember, counting starts from 1)
  // TODO: This is quite conservative.
  for (unsigned Level = 1; Level <= Dep->getLevels(); ++Level) {
    const SCEV *SCEVDist = Dep->getDistance(Level);
    if (!SCEVDist)
      return Worst;
    const SCEVConstant *Const = dyn_cast<SCEVConstant>(SCEVDist);
    if (!Const)
      return Worst;
    int64_t Dist = Const->getAPInt().getSExtValue();
    IterDV[Level - 1].Dist = Dist;
    if (Dist == 0)
      IterDV[Level - 1].Dir = '=';
    else if (Dist > 0)
      IterDV[Level - 1].Dir = '<';
    else
      IterDV[Level - 1].Dir = '>';
  }

  reflectIfNeeded(IterDV);
  return getMaxAllowedVecFact(IterDV);
}

static LoopDependence handleLoop(const Loop *L, DependenceInfo &DI,
                                 TargetLibraryInfo &TLI) {
  LoopDependence Bail = LoopDependence::getWorstPossible();

  if (L->isAnnotatedParallel())
    return LoopDependence::getBestPossible();

  SmallVector<LoadInst *, 16> Loads;
  SmallVector<StoreInst *, 16> Stores;

  for (BasicBlock *BB : L->blocks()) {
    for (Instruction &I : *BB) {
      if (auto *Call = dyn_cast<CallBase>(&I)) {
        if (Call->isConvergent())
          return Bail;
      }

      // If this instruction may read from memory and it is not
      // a simple load or a known call, we can't vectorize it.
      if (I.mayReadFromMemory()) {
        // Many math library functions read the rounding mode. We will only
        // vectorize a loop if it contains known function calls that don't set
        // the flag. Therefore, it is safe to ignore this read from memory.
        auto *Call = dyn_cast<CallInst>(&I);
        if (Call && getVectorIntrinsicIDForCall(Call, &TLI))
          continue;

        // If the function has an explicit vectorized counterpart, we can safely
        // assume that it can be vectorized.
        if (Call && !Call->isNoBuiltin() && Call->getCalledFunction() &&
            !VFDatabase::getMappings(*Call).empty())
          continue;

        auto *Ld = dyn_cast<LoadInst>(&I);
        if (!Ld || !Ld->isSimple())
          return Bail;

        Loads.push_back(Ld);

        // If this instruction may write to memory and it is not a simple store,
        // then we can't vectorize it.
      } else if (I.mayWriteToMemory()) {
        auto *St = dyn_cast<StoreInst>(&I);
        if (!St || !St->isSimple())
          return Bail;

        Stores.push_back(St);
      } // else -> We don't care about any other instruction.
    }
  }

  LoopDependence Res = LoopDependence::getBestPossible();
  for (auto It1 = Stores.begin(); It1 != Stores.end(); ++It1) {
    StoreInst *St1 = *It1;
    for (auto It2 = It1 + 1; It2 < Stores.end(); ++It2) {
      StoreInst *St2 = *It2;

      std::unique_ptr<Dependence> Dep =
          DI.depends(St1, St2,
                     /* PossiblyLoopIndependent */ true);
      if (Dep != nullptr) {
        assert(Dep->isOutput());
        ConstVF MaxAllowedVectorizationFactor = getMaxAllowedVecFact(Dep);
        if (MaxAllowedVectorizationFactor < Res.VectorizationFactor)
          Res.VectorizationFactor = MaxAllowedVectorizationFactor;
        if (Res.isWorstPossible())
          return Bail;
      }
    }

    for (LoadInst *Ld : Loads) {
      std::unique_ptr<Dependence> Dep =
          DI.depends(St1, Ld,
                     /* PossiblyLoopIndependent */ true);
      if (Dep != nullptr) {
        assert(Dep->isFlow());
        ConstVF MaxAllowedVectorizationFactor = getMaxAllowedVecFact(Dep);
        if (MaxAllowedVectorizationFactor < Res.VectorizationFactor)
          Res.VectorizationFactor = MaxAllowedVectorizationFactor;
        if (Res.isWorstPossible())
          return Bail;
      }
    }
  }

  return Res;
}

llvm::PreservedAnalyses LoopHotness::run(Function &F,
                                         FunctionAnalysisManager &FAM) {
  LoopInfo &LI = FAM.getResult<LoopAnalysis>(F);
  LoopDependenceInfo &LDI = FAM.getResult<LoopDependenceAnalysis>(F);
  TargetLibraryInfo &TLI = FAM.getResult<TargetLibraryAnalysis>(F);
  DependenceInfo &DI = FAM.getResult<DependenceAnalysis>(F);

  // TODO: Maybe order them by line.
  for (const Loop *L : LI.getLoopsInPreorder()) {

    // TripCount is the same as the true weight, although we don't account
    // for the fact that the loop may have been reached multiple times.
    int64_t TripCount = -1;
    if (getLoopBranchWeight(L, &TripCount) != BRANCH_WEIGHT_RESULT::CORRECT) {
      continue;
    }
    assert(TripCount != -1);
    DebugLoc LoopLoc = L->getStartLoc();
    // NOTE: Remember that Subscript tests have been disabled!
    const LoopDependence LD = LDI.getDependenceInfo(*L);
    ConstVF DA_ConstVF = handleLoop(L, DI, TLI).VectorizationFactor;

    os << "{\n";
    // Print path
    os << "  \"Path\": ";
    os << LoopHotnessPath;
    os << ",\n";
    // Print Location
    os << "  \"Location\": "
           << "\"";
    LoopLoc.print(os);
    os << "\"";
    
    // Print Trip Count
    os << ",\n";
    os << "  \"Trip Count\": " << TripCount;
    // Print Max VF
    os << ",\n";
    size_t LDA_VF = (LD.VectorizationFactor.hasValue())
                       ? LD.VectorizationFactor.getValue()
                       : std::numeric_limits<size_t>::max();
    size_t DA_VF = (DA_ConstVF.hasValue()) ? DA_ConstVF.getValue()
                                           : std::numeric_limits<size_t>::max();
    os << "  \"LDA VF\": " << LDA_VF << ",\n";
    os << "  \"DA VF\": " << DA_VF << "\n";

    os << "},\n";
  }
  return llvm::PreservedAnalyses::all();
}