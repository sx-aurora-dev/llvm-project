//===----------- LoopDependenceAnalysis.cpp - Iter Dependences -------------==//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// The implementation of outer-loop vectorization legality analysis for
// for the Region Vectorizer.
//
//===----------------------------------------------------------------------===//

#include "llvm/Analysis/LoopDependenceAnalysis.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/AliasSetTracker.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/VectorUtils.h"
#include "llvm/IR/Instructions.h"

using namespace llvm;

#define DEBUG_TYPE "loop-dependence"

AnalysisKey LoopDependenceAnalysis::Key;

LoopDependenceInfo LoopDependenceAnalysis::run(Function &F,
                                               FunctionAnalysisManager &FAM) {
  ScalarEvolution &SE = FAM.getResult<ScalarEvolutionAnalysis>(F);
  TargetLibraryInfo &TLI = FAM.getResult<TargetLibraryAnalysis>(F);
  AAResults &AA = FAM.getResult<AAManager>(F);
  DominatorTree &DT = FAM.getResult<DominatorTreeAnalysis>(F);
  LoopInfo &LI = FAM.getResult<LoopAnalysis>(F);
  return LoopDependenceInfo(F, SE, TLI, AA, DT, LI);
}

// Iterate all loops in DFS.
static void iterateAllLoops(LoopDependenceInfo *LDI, const Loop *L) {
  LDI->getDependenceInfo(*L);
  for (const Loop *L : L->getSubLoops()) {
    iterateAllLoops(LDI, L);
  }
}

LoopDependenceInfo::LoopDependenceInfo(Function &F, ScalarEvolution &SE,
                                       TargetLibraryInfo &TLI, AAResults &AA,
                                       DominatorTree &DT, LoopInfo &LI)
    : SE(SE), TLI(TLI), AA(AA), DT(DT), LI(LI) {

  // For now, iterate over all loops, and print dependence distance.
  // Note: LoopInfo gives us only the top-level loops, hence we have to
  // use recursion to actually get all loops.
  for (const Loop *L : LI) {
    iterateAllLoops(this, L);
  }
}

struct LoopNestInfo {
  bool isPerfectWithAccessOnlyInInnermost;

  // The values below are valid only if \p
  // isPerfectWithAccessOnlyInInnermost is true.

  // NumEnclosedLoops is the number of loops that this loop
  // contains "horizontally".
  int NumEnclosedLoops;
  const Loop *InnermostLoop;

  // Examples:
  // -- 1 --
  // for (i...)
  //   for (j...)
  //     for (k...)
  //       A[i][j] = ...
  //
  // LNI for the k-loop: {isPerfect: true, NumEnclosedLoops: = 0, Innermost: k-loop}
  // LNI for the j-loop: {isPerfect: true, NumEnclosedLoops: = 1, Innermost: k-loop}
  // LNI for the k-loop: {isPerfect: true, NumEnclosedLoops: = 2, Innermost: k-loop}

  // -- 2 --
  // for (i...)
  //   for (j...)
  //     A[i][j] = ...
  //     for (k...)
  //
  // LNI for the k-loop: {isPerfect: true, NumEnclosedLoops: = 0, Innermost: k-loop}
  // LNI for the j-loop: {isPerfect: false, NumEnclosedLoops: = N/A, Innermost: N/A}
  // LNI for the k-loop: {isPerfect: false, NumEnclosedLoops: = N/A, Innermost: N/A}

  // -- 3 --
  // for (i...) {
  //   for (j...)
  //   ...
  //   for (k...)
  // }
  //
  // LNI for the k-loop: {isPerfect: true, NumEnclosedLoops: = 0, Innermost: k-loop}
  // LNI for the j-loop: {isPerfect: true, NumEnclosedLoops: = 0, Innermost: j-loop}
  // LNI for the k-loop: {isPerfect: false, NumEnclosedLoops: = N/A, Innermost: N/A}
};

static bool isAccessingInstruction(const Instruction &I) {
  return I.mayReadOrWriteMemory();
}

// This function gathers information about a loop nest
// as long as this is perfect with accesses only in the
// innermost level. That is:
// - Recursively, each sub-loop has at most one sub-loop.
// - Every sub-loop that is not the innermost must not contain
//   any accesses (instructions that read or write memory).
// As long as these continue to hold, computes the number
// of enclosed loops in the loop nest and finds the innermost loop.

// As a side-effect, it computes the depth of the loop nest.
static LoopNestInfo
isPerfectLoopNestWithAccessesInTheInnermost(const Loop &TheLoop) {
  LoopNestInfo Res = {true, 0, &TheLoop};
  LoopNestInfo Invalid;
  Invalid.isPerfectWithAccessOnlyInInnermost = false;

  // `const` ref makes our life hard so we have to
  // skip the type-system.
  const Loop *L = &TheLoop;

  if (L->empty()) {
    return Res;
  }

  while (true) {
    const auto &SubLoops = L->getSubLoops();
    if (SubLoops.size() != 1)
      return Invalid;
    const Loop *Inner = SubLoops[0];
    for (const BasicBlock *BB : L->getBlocks()) {
      if (!Inner->contains(BB)) {
        for (const Instruction &I : *BB) {
          if (isAccessingInstruction(I))
            return Invalid;
        }
      }
    }
    Res.NumEnclosedLoops += 1;

    L = Inner;
    if (L->empty()) {
      Res.InnermostLoop = L;
      break;
    }
  }

  return Res;
}

bool breakSCEV(ScalarEvolution *SE, const SCEV *Expr,
               SmallVectorImpl<const SCEV *> &Subscripts) {
  const SCEV *AccessFn = Expr;

  dbgs() << "\n\nAccessFn: " << *AccessFn << "\n";

  const SCEVUnknown *BasePointer =
      dyn_cast<SCEVUnknown>(SE->getPointerBase(AccessFn));
  // Do not delinearize if we cannot find the base pointer.
  if (!BasePointer)
    return false;
  dbgs() << "Base Pointer: " << *BasePointer << "\n";
  AccessFn = SE->getMinusSCEV(AccessFn, BasePointer);

  SmallVector<const SCEV *, 3> Sizes;
  // TODO: Replace the element size.
  SE->delinearize(AccessFn, Subscripts, Sizes, SE->getConstant(APInt(64, 8)));

  if (Subscripts.size() == 0 || Sizes.size() == 0 ||
      Subscripts.size() != Sizes.size()) {
    dbgs() << "failed to delinearize\n";
    return false;
  }

  dbgs() << "Base offset: " << *BasePointer << "\n";
  dbgs() << "ArrayDecl[UnknownSize]";
  int Size = Subscripts.size();
  for (int i = 0; i < Size - 1; i++)
    dbgs() << "[" << *Sizes[i] << "]";
  dbgs() << " with elements of " << *Sizes[Size - 1] << " bytes.\n";

  dbgs() << "ArrayRef";
  for (int i = 0; i < Size; i++)
    dbgs() << "[" << *Subscripts[i] << "]";
  dbgs() << "\n";

  return true;
}

static bool isSimpleAddRec(ScalarEvolution &SE, const SCEVAddRecExpr *E) {
  // TODO: Do we want to make sure that the step is 1?
  if (E->getStepRecurrence(SE)->getSCEVType() != scConstant)
    return false;
  if (E->getStart()->getSCEVType() != scConstant)
    return false;
  return true;
}

static bool subscriptsAreLegal(ScalarEvolution &SE,
                               const SmallVectorImpl<const SCEV *> &Subscripts,
                               const Loop *Innermost, size_t NumEnclosedLoops) {

  // For now, the number of subscripts should match the
  // outer loop vectorization factor (i.e. NumEnclosedLoops + 1) that
  // we chose for this loop nest we're dealing with. For example,
  // if we're vectorizing the outer-most loop of a 3-level deep loop nest,
  // then we should have exactly 3 subscripts in each access.
  if (Subscripts.size() != NumEnclosedLoops + 1)
    return false;

  // Make sure that each subscript is either loop-invariant or
  // it depends on the loop that is in the depth that matches
  // the subscript's number. For example:
  // for (i...)
  //   for (j...)
  //     for (k...)
  //       A[x][y][z]
  //
  // We have 3 subscripts, with values `x`, `y`, `z`. `x` is no. 0, `y` is no. 1
  // and `z` is no. 2. `x` should either be loop-invariant or be dependent on
  // the `i-loop` same for `y` and the `j-loop` and for `z` and the `k-loop`. We
  // can know on what loop is a subscript dependent - from its SCEV. Note: We're
  // given the innermost loop, so in the example above, that would be the
  // `k-loop`. So, we have to start from the end. Note: Determining if something
  // is loop-invariant is not easy. For example, an AddExpr can be an addition
  // between a constant and an AddRecExpr in which the latter is not
  // loop-invariant. And theoretically that can happen in any depth. For now, we
  // only consider constants as loop-invariants and only handle simple
  // AddRecExprs.
  const Loop *Runner = Innermost;
  for (ssize_t i = Subscripts.size() - 1; i >= 0; --i) {
    switch (Subscripts[i]->getSCEVType()) {
    // Those are loop-invariant
    case scConstant:
      break;
    case scAddRecExpr: {
      const SCEVAddRecExpr *AddRec = dyn_cast<SCEVAddRecExpr>(Subscripts[i]);
      dbgs() << "AddRec: " << *AddRec << "\n";
      if (AddRec->getLoop() == Runner && isSimpleAddRec(SE, AddRec)) {
        break; // For the switch
      } else {
        return false;
      }
    } break;
    default:
      return false;
    }
    Runner = Runner->getParentLoop();
  }
  return true;
}

static bool
delinearizeAndVerifySubscripts(ScalarEvolution &SE, const SCEV *InitialSCEV,
                               SmallVectorImpl<const SCEV *> &Subscripts,
                               const Loop *Innermost, size_t NumEnclosedLoops) {
  return breakSCEV(&SE, InitialSCEV, Subscripts) &&
         subscriptsAreLegal(SE, Subscripts, Innermost, NumEnclosedLoops);
}

struct Direction {
  char dir;
  // TODO: Probably change to SCEV
  int dist;
};

// Assuming only 2-d dir vectors
// for now.
struct DirVector {
  bool valid;
  Direction outer;
  Direction inner;
};

Direction getDirectionFromSCEVConstant(const SCEVConstant *C) {
  ConstantInt *V = C->getValue();
  int64_t Dist = V->getSExtValue();
  Direction Res = {'<', Dist};
  if (!Dist)
    Res.dir = '=';
  else if (Dist < 0)
    Res.dir = '>';
  return Res;
}

Direction getDirection(ScalarEvolution *SE, const SCEV *S1, const SCEV *S2,
                       bool &valid) {
  // TODO: What about the order here?
  const SCEV *Diff = SE->getMinusSCEV(S2, S1);
  // TODO: Handle other things
  const SCEVConstant *C = dyn_cast<const SCEVConstant>(Diff);

  // Note: Constant here means "loop invariant" but "value known at
  // compile-time". We're happy with less strict cases, like `-2 + n` too,
  // because they're loop-invariant (assuming that n is loop-invariant) and we
  // can find out the distance with a single runtime check.

  if (C) {
    return getDirectionFromSCEVConstant(C);
  } else {
    dbgs() << "Non-constant SCEV distance: " << *Diff << "\n";
    valid = false;
    return {'*', 0};
  }
}

DirVector getDirVector(ScalarEvolution *SE,
                       SmallVectorImpl<const SCEV *> &Subscripts1,
                       SmallVectorImpl<const SCEV *> &Subscripts2) {

  assert(Subscripts1.size() == 2);
  assert(Subscripts1.size() == Subscripts2.size());

  DirVector res = {true};

  res.outer = getDirection(SE, Subscripts1[0], Subscripts2[0], res.valid);
  res.inner = getDirection(SE, Subscripts1[1], Subscripts2[1], res.valid);

  return res;
}

const LoopDependence
LoopDependenceInfo::getDependenceInfo(const Loop &L) const {
  LoopDependence Bail = LoopDependence::getPessimisticLoopDependence();

  if (L.isAnnotatedParallel())
    return Bail;

  // TODO: Is innermost? Use LAA
  if (L.empty())
    return Bail;

  // For now, we can only handle a perfect loop nest that has
  // accesses only in the innermost loop.
  LoopNestInfo NestInfo = isPerfectLoopNestWithAccessesInTheInnermost(L);
  dbgs() << "HeyLoop: " << L << "\n";
  dbgs() << "    isPerfectWithAccessesInInnermost: "
         << NestInfo.isPerfectWithAccessOnlyInInnermost << "\n";
  dbgs() << "    NumEnclosedLoops : " << NestInfo.NumEnclosedLoops << "\n";
  dbgs() << "    InnerLoop: " << *NestInfo.InnermostLoop << "\n";
  dbgs() << "    Induction Variable: "
         << L.getCanonicalInductionVariable()->getName() << "\n";
  if (!NestInfo.isPerfectWithAccessOnlyInInnermost) {
    return Bail;
  }
  // For now, we can only handle 2-dimensional outer-loop vectorization.
  if (NestInfo.NumEnclosedLoops != 1)
    return Bail;

  assert(NestInfo.InnermostLoop);
  const Loop &Inner = *NestInfo.InnermostLoop;

  SmallVector<LoadInst *, 16> Loads;
  SmallVector<StoreInst *, 16> Stores;

  // The AST tracks _maximal_ sets of pointers
  // that may alias with each other.
  AliasSetTracker AST(AA);

  LoopDependence Res = {std::numeric_limits<ConstDepDist>::max()};
  // Find if there's any illegal instruction and gather
  // loads and stores. Also put the pointers in the AST.
  for (BasicBlock *BB : Inner.blocks()) {
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
        AST.add(Ld);

        // If this instruction may write to memory and it is not a simple store,
        // then we can't vectorize it.
      } else if (I.mayWriteToMemory()) {
        auto *St = dyn_cast<StoreInst>(&I);
        if (!St || !St->isSimple())
          return Bail;

        Stores.push_back(St);
        AST.add(St);
      } // else -> We don't care about any other instruction.
    }   // Next instr.
  }     // Next block.

  // dbgs() << "Dumping the Alias Set Tracker\n";
  // AST.dump();

  // TODO: For now, we do a simple quadratic check. For every load, we check
  // whether there is a dependence with any of the stores.
  // Eventually, we want to be smarter about it, like LAA.

  dbgs() << "\n\n-------------\n\n";
  dbgs() << "Analyze access pairs\n\n";
  for (LoadInst *LD : Loads) {
    Value *LPtr = LD->getPointerOperand();

    for (StoreInst *ST : Stores) {
      Value *SPtr = ST->getPointerOperand();
      dbgs() << "  "
             << "Store pointer: " << *SPtr << "\n";

      // TODO: Do we care about the order?

      const SCEV *LoadSE = SE.getSCEVAtScope(LPtr, &Inner);
      const SCEV *StoreSE = SE.getSCEVAtScope(SPtr, &Inner);

      dbgs() << "Load pointer: " << *LPtr << "\n";
      dbgs() << *LoadSE << "\n";
      dbgs() << "\n";
      dbgs() << "Store pointer: " << *SPtr << "\n";
      dbgs() << *StoreSE << "\n";
      dbgs() << "\n";

      dbgs() << "\n\n------\n\n";
      dbgs() << "Delinearize SCEVs\n";

      SmallVector<const SCEV *, 3> Subscripts1, Subscripts2;

      if (!delinearizeAndVerifySubscripts(SE, LoadSE, Subscripts1,
                                          NestInfo.InnermostLoop,
                                          NestInfo.NumEnclosedLoops))
        return Bail;
      if (!delinearizeAndVerifySubscripts(SE, StoreSE, Subscripts2,
                                          NestInfo.InnermostLoop,
                                          NestInfo.NumEnclosedLoops))
        return Bail;

      DirVector dv = getDirVector(&SE, Subscripts1, Subscripts2);
      if (!dv.valid) {
        dbgs() << "Invalid direction vector\n";
        continue;
      } else {
        ConstDepDist MaxAllowedVectorizationFactor = dv.outer.dist - 1;
        if (MaxAllowedVectorizationFactor < Res.DepDist)
          Res.DepDist = MaxAllowedVectorizationFactor;
        dbgs() << "(" << dv.outer.dir << ", " << dv.inner.dir << ")\n";
        dbgs() << "Outer loop distance: " << dv.outer.dist << "\n";
      }
    }
  }

  dbgs() << "\n\n----- THE LOOP IS VECTORIZABLE --------\n\n";

  return Res;
}
