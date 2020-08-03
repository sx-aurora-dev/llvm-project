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
  int NumDimensions;
  const Loop *InnermostLoop;
};

static bool isAccessingInstruction(const Instruction &I) {
  return I.mayReadOrWriteMemory();
}

// This function gathers information about a loop nest
// as long as it is perfect. If it's not, it returns false.
static bool getNestInfo(const Loop &TheLoop, LoopNestInfo &NestInfo) {
  NestInfo = { 1, &TheLoop};

  // `const` ref makes our life hard so we have to
  // skip the type-system.
  const Loop *L = &TheLoop;

  // If it has no enclosed loops.
  if (L->empty()) {
    return true;
  }

  while (true) {
    const auto &SubLoops = L->getSubLoops();
    if (SubLoops.size() != 1)
      return false;
    L = SubLoops[0];
    NestInfo.NumDimensions += 1;
    if (L->empty()) {
      NestInfo.InnermostLoop = L;
      break;
    }
  }

  return true;
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
                               LoopNestInfo NestInfo) {
  // We want to check a couple of things:
  // a) That any SCEV is either constant or AddRec.
  // b) That the any AddRec has positive step.
  // c) That any loop of the nest is used in at most one recurrence.
  // Note in that way, we can have a subscript recurrence that is based
  // on an outer loop - that is not included in the loop nest.
  SmallDenseMap<const Loop *, bool> UsedLoops;
  for (const SCEV *S : Subscripts) {
    switch (S->getSCEVType()) {
    case scConstant:
      break;
    case scAddRecExpr: {
      const SCEVAddRecExpr *AddRec = dyn_cast<SCEVAddRecExpr>(S);
      const Loop *L = AddRec->getLoop();
      if (UsedLoops[L])
        return false;
      UsedLoops[L] = true;
      // Check that it has a positive step.
      const SCEV *Step = AddRec->getStepRecurrence(SE);
      if (Step->getSCEVType() != scConstant)
        return false;
      const SCEVConstant *Const = dyn_cast<SCEVConstant>(Step);
      if (Const->getAPInt().getSExtValue() <= 0)
        return false;
    } break;
    default:
      return false;
    }
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

  LLVM_DEBUG(dbgs() << "\n\nAccessExpr (" << *AccessExpr->getType() << "): " << *AccessExpr << "\n";);

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
    LLVM_DEBUG(dbgs() << "Failed to delinearize. Using a single subscript - "
                         "the original SCEV\n";);
    if (AccessExpr->getSCEVType() != scAddRecExpr) {
      Subscripts.push_back(AccessExpr);
      return true;
    }
    // If we have an AddRecExpr, we have to normalize it.
    SCEVAddRecExpr *AddRec = (SCEVAddRecExpr *) cast<SCEVAddRecExpr>(AccessExpr);
    // Add wrapping flags. We have to do this otherwise unsigned div later
    // may not work.
    // TODO: It's important to add run-time checks to verify that
    AddRec->setNoWrapFlags(SCEV::NoWrapFlags::FlagNUW);
    Type *Ty = AddRec->getType();
    auto &DL = L->getHeader()->getModule()->getDataLayout();
    uint64_t TypeByteSize = DL.getTypeAllocSize(Ty);
    const SCEV *Normalized = SE.getUDivExpr(AddRec, SE.getConstant(Ty, TypeByteSize));
    dbgs() << "Normalized: " << *Normalized << "\n";
    Subscripts.push_back(Normalized);
    // Push an invalid size just because the sizes of the two vectors
    // have to be equal.
    Subscripts.push_back(SE.getConstant(Ty, ~0));
    return true;
  }

  LLVM_DEBUG(
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

  );

  return true;
}

static bool
delinearizeInstAndVerifySubscripts(ScalarEvolution &SE, Instruction *Inst,
                                   SmallVectorImpl<const SCEV *> &Subscripts,
                                   SmallVectorImpl<const SCEV *> &Sizes,
                                   LoopNestInfo NestInfo) {

  return delinearizeAccessInst(SE, Inst, Subscripts, Sizes, NestInfo.InnermostLoop) &&
         subscriptsAreLegal(SE, Subscripts, Sizes, NestInfo);
}

struct DepVectorComponent {
  char Dir;
  // TODO: Probably change to SCEV
  int Dist;
  const Loop *Loop = nullptr;

  void print() const {
    dbgs() << "{" << Dir << ", " << Dist << ", " << ((Loop) ? Loop->getName() : "") << "}";
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

struct DirDistPair {
  char Dir;
  int Dist;
};

DirDistPair getDirDistPairFromSCEVConstant(const SCEVConstant *C) {
  ConstantInt *V = C->getValue();
  int64_t Dist = V->getSExtValue();
  DirDistPair Res = {'<', Dist};
  if (!Dist)
    Res.Dir = '=';
  else if (Dist < 0)
    Res.Dir = '>';
  return Res;
}

bool getDVComponent(ScalarEvolution *SE, const SCEV *S1, const SCEV *S2,
                    DepVectorComponent &DVC, LoopNestInfo NestInfo) {
  if (S1->getType() != S2->getType())
    return false;
  if (S1->getSCEVType() == scConstant && S2->getSCEVType() == scConstant) {
    // If they're both constants and equal, then we have dimension squashing.
    // Otherwise, the two references never alias.
    if (dyn_cast<SCEVConstant>(S1)->getValue()->getSExtValue() ==
        dyn_cast<SCEVConstant>(S2)->getValue()->getSExtValue()) {
      DVC.Dir = 'S';
      return true;
    } else {
      DVC.Dir = 'N';
      return true;
    }
  }
  if (S1->getSCEVType() != scAddRecExpr || S2->getSCEVType() != scAddRecExpr) {
    // Can't handle other cases - either both constants or both AddRecs.
    return false;
  }

  const SCEVAddRecExpr *AddRec1 = dyn_cast<SCEVAddRecExpr>(S1);
  const SCEVAddRecExpr *AddRec2 = dyn_cast<SCEVAddRecExpr>(S2);

  if (AddRec1->getLoop() != AddRec2->getLoop())
    return false;

  // Search for the loop that this subscript uses.
  // If it uses an outer loop (outer than the loop nest
  // we care about), then squash it.
  const Loop *Runner = NestInfo.InnermostLoop;
  const Loop *Used = AddRec1->getLoop();
  bool isOuter = true;
  for (int I = 0; I < NestInfo.NumDimensions; ++I) {
    if (Runner == Used) {
      isOuter = false;
      break;
    }
    Runner = Runner->getParentLoop();
  }

  if (isOuter) {
    DVC.Dir = 'S';
    return true;
  }

  const Loop *RecLoop = AddRec1->getLoop();

  // TODO: What about the order here?
  const SCEV *Diff = SE->getMinusSCEV(AddRec2, AddRec1);
  // TODO: Handle other things
  const SCEVConstant *C = dyn_cast<const SCEVConstant>(Diff);

  // Note: Constant here means "loop invariant" and also "value known at
  // compile-time". We're happy with less strict cases, like `-2 + n` too,
  // because they're loop-invariant (assuming that n is loop-invariant) and we
  // can find out the distance with a single runtime check.

  if (C) {
    auto DirDist = getDirDistPairFromSCEVConstant(C);
    DVC = {DirDist.Dir, DirDist.Dist, RecLoop};
    return true;
  } else {
    LLVM_DEBUG(dbgs() << "Non-constant SCEV distance: " << *Diff << "\n");
    return false;
  }
}

static int findPositionInDV(DepVectorComponent DVC, LoopNestInfo NestInfo) {
  const Loop *RecLoop = DVC.Loop;
  assert(RecLoop != nullptr);
  const Loop *Runner = NestInfo.InnermostLoop;
  // This is the position of the first dimension, which is the rightmost.
  // Because remember that vectors follow the convention of C when it comes
  // to multi-dimensional description. That is, every new dimension is added
  // to the left in an access.
  int Pos = NestInfo.NumDimensions - 1;
  while (Pos >= 0) {
    assert(Runner != nullptr);
    if (RecLoop == Runner)
      return Pos;
    Pos--;
    Runner = Runner->getParentLoop();
  }
  return -1;
}

enum DVValidity {
  DVV_INVALID,
  DVV_VALID,
  DVV_DEFINITELY_VECTORIZABLE
};

DVValidity getDirVector(ScalarEvolution *SE, DepVector &DV,
                  SmallVectorImpl<const SCEV *> &Subscripts1,
                  SmallVectorImpl<const SCEV *> &Subscripts2,
                  LoopNestInfo NestInfo) {

  assert(Subscripts1.size() == Subscripts2.size());

  for (size_t Index = 0; Index < Subscripts1.size(); ++Index) {
    DepVectorComponent DVC;
    if (!getDVComponent(SE, Subscripts1[Index], Subscripts2[Index], DVC, NestInfo))
      return DVV_INVALID;
    if (DVC.Dir == 'N')
      return DVV_DEFINITELY_VECTORIZABLE;
    if (DVC.Dir == 'S')
      // Ignore
      continue;
    int Pos = findPositionInDV(DVC, NestInfo);
    if (Pos == -1) {
      // The loop that the recurrence is based on does not
      // affect this (inner) loop nest.
      continue;
    }
    DV[Pos] = DVC;
  }

  return DVV_VALID;
}

static bool areDefinitelyNonAliasing(const DepVector &AccessDV) {
  for (DepVectorComponent DVC : AccessDV.Comps) {
    if (DVC.Dir == 'N')
      return true;
  }
  return false;
}

void canonicalizeIterationVector(DepVector &IterDV) {
  SmallVectorImpl<DepVectorComponent> &Comps = IterDV.Comps;
  // Squash unused dimensions. Maybe we should use a list instead of
  // a vector - it depends on how common this is.

  // Note that currently squshing works for something
  // like this:
  // for (k)
  //   for (i)
  //     for (j)
  //       A[k+2][i-1][0] = A[k][i][0]
  // i.e. we're squashing the first dimension (the j-loop).
  // The currently implemented squashing could do quite more
  // complicated squashing, like in the above loop: A[k+2][0][i-1] = ...
  // that is, squash the middle dimension, or the last. But
  // delinearization fails to deduce these subscripts.
  Comps.erase(
      std::remove_if(Comps.begin(), Comps.end(),
                     [](DepVectorComponent DVC) { return DVC.Dir == 'S'; }),
      Comps.end());

  assert(IterDV.size() > 0);
  if (IterDV.size() > 2)
    return;
  if (IterDV.size() == 1) {
    if (IterDV[0].Dist < 0)
      IterDV[0].negate();
    return;
  }
  bool looksDownwards = IterDV[0].Dir == '>';
  bool looksLeft = (IterDV[0].Dist == 0 && IterDV[1].Dist == '>');
  // If it looks downwards or to the left, then we have an anti-dependence.
  // (there's s a read from a location that in iteration space is after the
  // (current).
  // To convert it to an iteration vector, we have to reflect it about
  // the origin because still the iteration in which the read happens
  // has to execute before the iteration in which the write happens.
  if (looksDownwards || looksLeft) {
    IterDV.reflect();
  }
}

static ConstVF getMaxAllowedVecFact(DepVector &IterDV) {
  assert(IterDV.verify());
  ConstVF Best = LoopDependence::getBestPossible().VectorizationFactor;
  ConstVF Worst = LoopDependence::getWorstPossible().VectorizationFactor;
  assert(IterDV.size() > 0);
  if (IterDV.size() > 2)
    return Worst;
  if (IterDV.size() == 1) {
    int Dist = IterDV[0].Dist;
    if (Dist) {
      return Dist;
    }
    return Best;
  }
  // Handle outermost loop vectorization in 2-level loop nest.
  ConstVF Res = Best;
  if (IterDV[0].Dir == '<' && (IterDV[1].Dir == '>' || IterDV[1].Dir == '='))
    Res = (size_t)IterDV[0].Dist;
  return Res;
}

const LoopDependence
LoopDependenceInfo::getDependenceInfo(const Loop &L) const {
  LoopDependence Bail = LoopDependence::getWorstPossible();

  if (L.isAnnotatedParallel())
    return Bail;

  // TODO: Is innermost? Use LAA
  bool isInnermost = L.empty();
  if (isInnermost)
    return Bail;

  // For now, we can only handle a perfect loop nest that has
  // accesses only in the innermost loop.
  LoopNestInfo NestInfo;
  bool isPerfect = getNestInfo(L, NestInfo);
  if (!isPerfect) {
    LLVM_DEBUG(dbgs() << "Imperfect loop nest: " << L << "\n";);
    return Bail;
  }
  LLVM_DEBUG(dbgs() << "Loop: " << L << "\n";
             dbgs() << "    NumDimensions : " << NestInfo.NumDimensions
                    << "\n";
             dbgs() << "    InnerLoop: " << *NestInfo.InnermostLoop << "\n";
             dbgs() << "    Induction Variable: "
                    << L.getCanonicalInductionVariable()->getName() << "\n";);

  assert(NestInfo.InnermostLoop);
  const Loop &Inner = *NestInfo.InnermostLoop;

  SmallVector<LoadInst *, 16> Loads;
  SmallVector<StoreInst *, 16> Stores;

  // The AST tracks _maximal_ sets of pointers
  // that may alias with each other.
  AliasSetTracker AST(AA);

  // Find if there's any illegal instruction and gather
  // loads and stores. Also put the pointers in the AST.
  for (BasicBlock *BB : L.blocks()) {
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
                                              NestInfo))
        return Bail;
      if (!delinearizeInstAndVerifySubscripts(SE, ST, Subscripts2, Sizes2,
                                              NestInfo))
        return Bail;

      LLVM_DEBUG(dbgs() << "\n");
      //expandDimensions(&SE, Subscripts1, NestInfo);
      //expandDimensions(&SE, Subscripts2, NestInfo);
      DepVector IterDV(NestInfo.NumDimensions);
      DVValidity Valid =
          getDirVector(&SE, IterDV, Subscripts1, Subscripts2, NestInfo);
      if (Valid == DVV_INVALID)
        return Bail;
      if (Valid == DVV_DEFINITELY_VECTORIZABLE)
        continue;
      canonicalizeIterationVector(IterDV);
      LLVM_DEBUG(IterDV.print(););
      ConstVF MaxAllowedVectorizationFactor = getMaxAllowedVecFact(IterDV);
      if (Res.VectorizationFactor < MaxAllowedVectorizationFactor)
        Res.VectorizationFactor = MaxAllowedVectorizationFactor;
      if (Res.isWorstPossible())
        return Bail;
    }
  }

  return Res;
}