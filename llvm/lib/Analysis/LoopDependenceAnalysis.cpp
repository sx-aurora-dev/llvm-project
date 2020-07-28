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

/*
-- Terminology --

First of all, we assume that all accesses are in the form
of array accesses (this is a rule that the code does
not follow strictly, but the exceptions are few and simple).

Index:  It is used to mean the index variable (induction variable) for
    some loop surrounding an array access. For example, in:
        A[i][j+1][k-2]
    `i`, `j` and `k` are indexes.

Subscript: It is used to refer to one of the subscripted
    positions in an array reference. For example, in:
      A[i][j+1][k-2]
    the expressions `i`, `j+1` and `k-2` are subscripts
    (which use indices). Note that it is also useful
    to number subscripts. `i` is subscript no. 0,
    `j+1` is no. 1 and `k-2` is no. 2.

Loop Vectorization Factor: It refers to the number of iterations
    that can be run in parallel for a specific loop. For
    example, in:
      int A[n][m];
      for (i = 0; i < n; ++i)
        for (j = 0; j < m; ++j)
          A[i+2][j] = A[i][j];

    The loop vectorization factor for the `i-loop` is 2, since
    we can run the loops in groups of 2. This _looks like_ the
    the following:
      int A[n][m];
      for (i = 0; i < n; i+=2)
        for (j = 0; j < m; ++j) {
          A[i+2][j] = A[i][j];
          A[i+3][j] = A[i+1][j];
        }

    This is like an unroll-and-jam but UAJ is not an accurate
    description since here the two statements are run sequentially
    (although both at the same `j-iteration`) while in vectorization
    they will be run in parallel. As far as DA is concerned,
    in this example both UAJ and vectorization by a factor of 2
    are valid but this is not always the case.

    Finally, the `j-loop` has a VF of infinity, since all iterations can
    be run in parallel.

*/

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
  LoopDependence Res = LDI->getDependenceInfo(*L);
  dbgs() << "\nLoop: " << L->getName() << ": ";
  if (!Res.VectorizationFactor.hasValue()) {
    dbgs() << "Is vectorizable for any factor\n";
  } else {
    uint64_t VF = Res.VectorizationFactor.getValue();
    if (VF > 1)
      dbgs() << "Is vectorizable with VF: " << VF << "\n";
    else
      dbgs() << "Is NOT vectorizable\n";
  }
  dbgs() << "\n";
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

bool subscriptsAreWithinBounds(ScalarEvolution &SE,
                               const SmallVectorImpl<const SCEV *> &Subscripts,
                               const SmallVectorImpl<const SCEV *> &Sizes) {
  // TODO: We are checking whether the subscripts are less than the sizes.
  // But maybe, we should also check if they're greater than 0.
  assert(Subscripts.size() > 1);
  // Remember that Sizes has one less entry than Subscripts because we never
  // know the first dimension.
  for (size_t SubIt = 1; SubIt < Subscripts.size(); ++SubIt) {
    const SCEV *Sub = Subscripts[SubIt];
    const SCEV *Sz = Sizes[SubIt - 1];
    // We have already checked the following before calling
    // this function.
    assert(Sub->getSCEVType() == scConstant ||
           Sub->getSCEVType() == scAddRecExpr);
    const SCEV *MinusOne =
        SE.getMinusSCEV(Sz, SE.getConstant(Sz->getType(), 1));
    if (Sub->getSCEVType() == scConstant) {
      if (SE.getSMaxExpr(Sub, MinusOne) != MinusOne)
        return false;
    } else {
      const SCEVAddRecExpr *SubAR = dyn_cast<SCEVAddRecExpr>(Sub);
      const SCEV *Max = SE.getSMaxExpr(SubAR->getStart(), MinusOne);
      dbgs() << "Max (" << Max->getSCEVType() << "): " << *Max << "\n";
      if (SE.getSMaxExpr(SubAR->getStart(), MinusOne) != MinusOne)
        return false;
      const Loop *SurroundingLoop = SubAR->getLoop();
      const SCEV *NumIterations = SE.getBackedgeTakenCount(SurroundingLoop);
      const SCEV *ExitValue = SubAR->evaluateAtIteration(NumIterations, SE);
      if (SE.getSMaxExpr(ExitValue, MinusOne) != MinusOne)
        return false;
    }
  }
  return true;
}

static bool subscriptsAreLegal(ScalarEvolution &SE,
                               const SmallVectorImpl<const SCEV *> &Subscripts,
                               const SmallVectorImpl<const SCEV *> &Sizes,
                               const Loop *Innermost, size_t NumEnclosedLoops) {

  // For now, the number of subscripts should match the
  // outer loop vectorization level (i.e. NumEnclosedLoops + 1) that
  // we chose in this loop nest. For example,
  // if we're vectorizing the outer-most loop of a 3-level deep loop nest,
  // then we should have exactly 3 subscripts in each access.
  if (!(Subscripts.size() >= NumEnclosedLoops + 1)) {
    LLVM_DEBUG(dbgs() << "Few dimensions in access\n";);
    return false;
  }

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
  ssize_t End = Subscripts.size() - (NumEnclosedLoops + 1);
  for (ssize_t i = Subscripts.size() - 1; i >= End; --i) {
    const SCEV *S = Subscripts[i];
    switch (S->getSCEVType()) {
    // Those are loop-invariant
    case scConstant:
      break;
    case scAddRecExpr: {
      const SCEVAddRecExpr *AddRec = dyn_cast<SCEVAddRecExpr>(S);
      if (AddRec->getLoop() == Runner) {
        break; // For the switch
      } else {
        LLVM_DEBUG(dbgs() << "Subscript no. " << i
                          << " AddRecExpr is in invalid dimension.\n");
        return false;
      }
    } break;
    default:
      return false;
    }
    Runner = Runner->getParentLoop();
  }

  // if (!subscriptsAreWithinBounds(SE, Subscripts, Sizes))
  //  return false;

  return true;
}

static bool delinearizeAccessInst(ScalarEvolution &SE, Instruction *Inst,
                                  SmallVectorImpl<const SCEV *> &Subscripts,
                                  SmallVectorImpl<const SCEV *> &Sizes,
                                  const Loop *L) {
  assert(isa<StoreInst>(Inst) || isa<LoadInst>(Inst));
  const SCEV *AccessExpr = SE.getSCEVAtScope(getPointerOperand(Inst), L);

  LLVM_DEBUG(dbgs() << "\n\nAccessExpr: " << *AccessExpr << "\n";);

  const SCEVUnknown *BasePointer =
      dyn_cast<SCEVUnknown>(SE.getPointerBase(AccessExpr));
  // Do not delinearize if we cannot find the base pointer.
  if (!BasePointer)
    return false;
  LLVM_DEBUG(dbgs() << "Base Pointer: " << *BasePointer << "\n";);
  // Remove the base pointer from the expr.
  AccessExpr = SE.getMinusSCEV(AccessExpr, BasePointer);

  SE.delinearize(AccessExpr, Subscripts, Sizes, SE.getElementSize(Inst));

  if (Subscripts.size() == 0 || Sizes.size() == 0 ||
      Subscripts.size() != Sizes.size()) {
    LLVM_DEBUG(dbgs() << "Failed to delinearize\n";);
    return false;
  }

  LLVM_DEBUG(

      dbgs() << "Base offset: " << *BasePointer << "\n";
      dbgs() << "ArrayDecl[UnknownSize]"; int Size = Subscripts.size();
      for (int i = 0; i < Size - 1; i++) dbgs() << "[" << *Sizes[i] << "]";
      dbgs() << " with elements of " << *Sizes[Size - 1] << " bytes.\n";

      dbgs() << "ArrayRef";
      for (int i = 0; i < Size; i++) dbgs() << "[" << *Subscripts[i] << "]";
      dbgs() << "\n";

  );

  return true;
}

static bool
delinearizeInstAndVerifySubscripts(ScalarEvolution &SE, Instruction *Inst,
                                   SmallVectorImpl<const SCEV *> &Subscripts,
                                   SmallVectorImpl<const SCEV *> &Sizes,
                                   const Loop *Innermost,
                                   size_t NumEnclosedLoops) {

  return delinearizeAccessInst(SE, Inst, Subscripts, Sizes, Innermost) &&
         subscriptsAreLegal(SE, Subscripts, Sizes, Innermost, NumEnclosedLoops);
}

struct DepVectorComponent {
  char dir;
  // TODO: Probably change to SCEV
  int dist;

  void print() const { dbgs() << "{" << dir << ", " << dist << "}"; }
  void reflect() {
    if (dir == '=')
      return;
    dist = -dist;
    dir = (dir == '<') ? '>' : '<';
  }
};

struct DepVector {
  bool valid;
  SmallVector<DepVectorComponent, 4> Comps;

  const DepVectorComponent operator[](size_t I) const { return Comps[I]; }
  DepVectorComponent &operator[](size_t I) { return Comps[I]; }

  void print() const {
    if (!valid) {
      dbgs() << "Invalid DepVector\n";
      return;
    }
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
  }

  size_t size() const { return Comps.size(); }

  bool verify() const {
    for (DepVectorComponent DVC : Comps) {
      if (DVC.dir != '<' && DVC.dir != '>' && DVC.dir != '=')
        return false;
      if (DVC.dir == '<' && DVC.dist <= 0)
        return false;
      else if (DVC.dir == '>' && DVC.dist >= 0)
        return false;
      else if (DVC.dir == '=' && DVC.dist != 0)
        return false;
    }
    return true;
  }
};

DepVectorComponent getDVComponentFromSCEVConstant(const SCEVConstant *C) {
  ConstantInt *V = C->getValue();
  int64_t Dist = V->getSExtValue();
  DepVectorComponent Res = {'<', Dist};
  if (!Dist)
    Res.dir = '=';
  else if (Dist < 0)
    Res.dir = '>';
  return Res;
}

DepVectorComponent getDVComponent(ScalarEvolution *SE, const SCEV *S1,
                                  const SCEV *S2, bool &valid) {
  // TODO: What about the order here?
  const SCEV *Diff = SE->getMinusSCEV(S2, S1);
  // TODO: Handle other things
  const SCEVConstant *C = dyn_cast<const SCEVConstant>(Diff);

  // Note: Constant here means "loop invariant" and also "value known at
  // compile-time". We're happy with less strict cases, like `-2 + n` too,
  // because they're loop-invariant (assuming that n is loop-invariant) and we
  // can find out the distance with a single runtime check.

  if (C) {
    return getDVComponentFromSCEVConstant(C);
  } else {
    LLVM_DEBUG(dbgs() << "Non-constant SCEV distance: " << *Diff << "\n");
    valid = false;
    return {'*', 0};
  }
}

DepVector getDirVector(ScalarEvolution *SE,
                       SmallVectorImpl<const SCEV *> &Subscripts1,
                       SmallVectorImpl<const SCEV *> &Subscripts2,
                       size_t NumEnclosedLoops) {

  assert(Subscripts1.size() == Subscripts2.size());
  assert(Subscripts1.size() >= (NumEnclosedLoops + 1));

  DepVector Res = {true};

  size_t Index = Subscripts1.size() - (NumEnclosedLoops + 1);
  for (; Index < Subscripts1.size(); ++Index) {
    Res.Comps.push_back(
        getDVComponent(SE, Subscripts1[Index], Subscripts2[Index], Res.valid));
  }

  return Res;
}

static bool verifyIterationDepVector(DepVector &DV, int NumEnclosedLoops) {
  if (!DV.verify())
    return false;
  if (DV.size() == 2) {
    // We can't have an iteration dependence vector that looks
    // downwards or directly to the left, because
    // that would mean that a later iteration
    // has to happen first!
    bool isDownwards = DV[0].dir == '>';
    bool isLeft = (DV[0].dist == 0 && DV[1].dist == '>');
    if (isDownwards || isLeft)
      return false;
    return true;
  } else {
    return true;
  }
  return false;
}

static DepVector &convertToIterationVector(DepVector& RefDV) {
  assert(RefDV.size() == 2);
  bool looksDownwards = RefDV[0].dir == '>';
  bool looksLeft = (RefDV[0].dist == 0 && RefDV[1].dist == '>');
  // If it looks downwards or to the left, then we have an anti-dependence.
  // (there's s a read from a location that in iteration space is after the
  // (current).
  // To convert it to an iteration vector, we have to reflect it about
  // the origin because still the iteration in which the read happens
  // has to execute before the iteration in which the write happens.
  if (looksDownwards || looksLeft) {
    for (DepVectorComponent &DVC : RefDV.Comps) {
      DVC.reflect();
    }
  }
  return RefDV;
}

static ConstVF getMaxAllowedVecFact(DepVector &IterDV, int NumEnclosedLoops) {
  assert(verifyIterationDepVector(IterDV, NumEnclosedLoops));
  ConstVF Res = LoopDependence::getBestPossible().VectorizationFactor;
  // Handle outermost loop vectorization in 2-level loop nest.
  if (NumEnclosedLoops == 1) {
    if (IterDV[0].dir == '<' && (IterDV[1].dir == '>' || IterDV[1].dir == '='))
      Res = (size_t)IterDV[0].dist;
  } else {
    // Handle outermost loop vectorization in 3-level loop nest.
  }
  return Res;
}

const LoopDependence
LoopDependenceInfo::getDependenceInfo(const Loop &L) const {
  LoopDependence Bail = LoopDependence::getWorstPossible();

  if (L.isAnnotatedParallel())
    return Bail;

  // TODO: Is innermost? Use LAA
  if (L.empty())
    return Bail;

  // For now, we can only handle a perfect loop nest that has
  // accesses only in the innermost loop.
  LoopNestInfo NestInfo = isPerfectLoopNestWithAccessesInTheInnermost(L);
  if (!NestInfo.isPerfectWithAccessOnlyInInnermost) {
    LLVM_DEBUG(
        dbgs()
            << "Imperfect loop nest and/or accesses not in the innermost loop: "
            << L << "\n";);
    return Bail;
  }
  LLVM_DEBUG(dbgs() << "Loop: " << L << "\n";
             dbgs() << "    NumEnclosedLoops : " << NestInfo.NumEnclosedLoops
                    << "\n";
             dbgs() << "    InnerLoop: " << *NestInfo.InnermostLoop << "\n";
             dbgs() << "    Induction Variable: "
                    << L.getCanonicalInductionVariable()->getName() << "\n";);

  // For now, we can only handle 2-dimensional outer-loop vectorization.
  if (NestInfo.NumEnclosedLoops != 1) {
    LLVM_DEBUG(
        dbgs() << "We can only handle 2-dimensional loop nests for now.\n");
    return Bail;
  }

  assert(NestInfo.InnermostLoop);
  const Loop &Inner = *NestInfo.InnermostLoop;

  SmallVector<LoadInst *, 16> Loads;
  SmallVector<StoreInst *, 16> Stores;

  // The AST tracks _maximal_ sets of pointers
  // that may alias with each other.
  AliasSetTracker AST(AA);

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

  // Starting from the best possible dependence (optimistically),
  // either bail out early for some reason, or try to meet
  // the best acceptable value (with monotone pessimistic movements).
  LoopDependence Res = LoopDependence::getBestPossible();

  LLVM_DEBUG(dbgs() << "\n\n-------------\n\n";
             dbgs() << "Analyze access pairs\n\n";);
  for (LoadInst *LD : Loads) {
    Value *LPtr = LD->getPointerOperand();

    for (StoreInst *ST : Stores) {
      Value *SPtr = ST->getPointerOperand();
      // TODO: Do we care about the order?

      LLVM_DEBUG(dbgs() << "Load pointer: " << *LPtr << "\n";
                 dbgs() << *SE.getSCEVAtScope(LPtr, &Inner) << "\n\n";
                 dbgs() << "Store pointer: " << *SPtr << "\n";
                 dbgs() << *SE.getSCEVAtScope(SPtr, &Inner) << "\n";);

      LLVM_DEBUG(dbgs() << "\n"; dbgs() << "\n\n------\n\n";
                 dbgs() << "Delinearize SCEVs\n";);

      SmallVector<const SCEV *, 3> Subscripts1, Subscripts2;
      SmallVector<const SCEV *, 3> Sizes1, Sizes2;

      if (!delinearizeInstAndVerifySubscripts(SE, LD, Subscripts1, Sizes1,
                                              NestInfo.InnermostLoop,
                                              NestInfo.NumEnclosedLoops))
        return Bail;
      if (!delinearizeInstAndVerifySubscripts(SE, ST, Subscripts2, Sizes2,
                                              NestInfo.InnermostLoop,
                                              NestInfo.NumEnclosedLoops))
        return Bail;

      LLVM_DEBUG(dbgs() << "\n");
      DepVector RefDV = getDirVector(&SE, Subscripts1, Subscripts2,
                                     NestInfo.NumEnclosedLoops);
      if (!RefDV.valid) {
        continue;
      } else {
        DepVector &IterDV = convertToIterationVector(RefDV);
        LLVM_DEBUG(IterDV.print(););
        ConstVF MaxAllowedVectorizationFactor =
            getMaxAllowedVecFact(IterDV, NestInfo.NumEnclosedLoops);
        if (Res.VectorizationFactor < MaxAllowedVectorizationFactor)
          Res.VectorizationFactor = MaxAllowedVectorizationFactor;
        if (Res.isWorstPossible())
          return Bail;
      }
    }
  }

  return Res;
}