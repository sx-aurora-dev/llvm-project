#include "llvm/ADT/SCCIterator.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/Utils/LoopUtils.h"

#include "llvm/NOELLE/PDG/PDG.h"
#include "llvm/NOELLE/PDG/PDGAnalysis.h"
#include "llvm/NOELLE/PDG/PDGPrinter.h"
#include "llvm/NOELLE/Transformer/LoopDistribution.h"
#include "llvm/NOELLE/Transformer/LoopInterchange.h"
#include "llvm/NOELLE/Transformer/Transformer.h"

#include "llvm/NOELLE/Transformer/LoopInterchange.h"

using namespace llvm;
using namespace noelle;

#define DEBUG_TYPE "noelle-loop-interchange"

static bool hasSuccessor(const BasicBlock *BB, const BasicBlock *Succ) {
  for (const BasicBlock *ActualSucc : successors(BB)) {
    if (ActualSucc == Succ)
      return true;
  }
  return false;
}

static ICmpInst *getHeaderICmp(const BasicBlock *Header) {
  if (const BranchInst *BI =
          dyn_cast_or_null<BranchInst>(Header->getTerminator()))
    if (BI->isConditional())
      return dyn_cast<ICmpInst>(BI->getCondition());

  return nullptr;
}

static PHINode *getInductionVariable(const Loop *L, ScalarEvolution &SE) {
  // We should have checked those already
  assert(L->getExitingBlock() == L->getHeader());
  BasicBlock *Header = L->getHeader();
  const BranchInst *BI = dyn_cast<BranchInst>(Header->getTerminator());
  // We have check that all terminators are branches
  assert(BI);
  // We have checked that the header is (the) exiting block
  assert(BI->isConditional());
  const ICmpInst *CmpInst = dyn_cast<ICmpInst>(BI->getCondition());
  if (!CmpInst)
    return nullptr;

  Instruction *CmpOp0 = dyn_cast<Instruction>(CmpInst->getOperand(0));
  Instruction *CmpOp1 = dyn_cast<Instruction>(CmpInst->getOperand(1));

  for (PHINode &IndVar : Header->phis()) {
    InductionDescriptor IndDesc;
    if (!InductionDescriptor::isInductionPHI(&IndVar, L, &SE, IndDesc))
      continue;

    Instruction *StepInst = IndDesc.getInductionBinOp();

    // case 1:
    // IndVar = phi[{InitialValue, preheader}, {StepInst, latch}]
    // StepInst = IndVar + step
    // cmp = StepInst < FinalValue
    if (StepInst == CmpOp0 || StepInst == CmpOp1)
      return &IndVar;

    // case 2:
    // IndVar = phi[{InitialValue, preheader}, {StepInst, latch}]
    // StepInst = IndVar + step
    // cmp = IndVar < FinalValue
    if (&IndVar == CmpOp0 || &IndVar == CmpOp1)
      return &IndVar;
  }

  return nullptr;
}

static bool isBBEmpty(BasicBlock *BB) {
  Instruction *FirstInst = &*(BB->getInstList().begin());
  if (FirstInst != BB->getTerminator()) {
    return false;
  }
  return true;
}

static bool latchEndsWithIV(const Loop *L, ScalarEvolution &SE) {
  // TODO - IMPORTANT: WE SHOULD DEFINITELY USE THE STANDARD
  // ONE BUT IT SEEMS TO ONLY HANDLE ROTATED LOOPS
  // Note, however, that llvm::LoopInterchange does the same.
  PHINode *IV = getInductionVariable(L, SE);
  if (!IV)
    return false;

  Instruction *StepInst =
      dyn_cast<Instruction>(IV->getIncomingValueForBlock(L->getLoopLatch()));
  // It should be true because it is an induction variable.
  assert(StepInst);

  // Check that there's no instruction with side-effects between the step and
  // the latch backedge
  // TODO: mayHaveSideEffects() is not enough here because it doesn't check for
  // division by 0.
  Instruction *I = StepInst;
  while (!isa<BranchInst>(I)) {
    if (I->mayHaveSideEffects())
      return false;
    I = I->getNextNode();
  }
  return true;
}

static bool checkCoreExpectedLoopStructure(const Loop *L, ScalarEvolution &SE) {
  // TODO: Handle rotated loops
  if (L->isRotatedForm())
    return false;
  if (!L->isLoopSimplifyForm())
    return false;
  BasicBlock *Header = L->getHeader();
  BasicBlock *PH = L->getLoopPreheader();
  BasicBlock *Latch = L->getLoopLatch();
  // We must have those from loop-simplify form
  assert(Header && PH && Latch);
  BasicBlock *ExitBlock = L->getExitBlock();
  if (!ExitBlock)
    return false;

  if (!latchEndsWithIV(L, SE))
    return false;

  return true;
}

static bool checkExpectedLoopStructure(const Loop *Outer, const Loop *Inner,
                                       ScalarEvolution &SE) {
  // Check inidividual core structure
  if (!checkCoreExpectedLoopStructure(Inner, SE))
    return false;
  if (!checkCoreExpectedLoopStructure(Outer, SE))
    return false;

  // The inner preheader must be empty.
  // TODO: Is this true/
  if (!isBBEmpty(Inner->getLoopPreheader()))
    return false;

  /*
   * Now, we want to study their relationship
   */

  // TODO: We probably need to check that the nest is perfect.

  // Basic blocks that we're going to need to do our tests
  BasicBlock *OuterHeader = Outer->getHeader();
  BasicBlock *InnerHeader = Inner->getHeader();

  // Check that only the headers branch out
  if (Inner->getExitingBlock() != InnerHeader ||
      Outer->getExitingBlock() != OuterHeader)
    return false;

  return true;
}

// Update BB's terminator to jump to NewBB instead of OldBB. Records updates to
// the dominator tree in DTUpdates.
static void updateSuccessor(BasicBlock *BB, BasicBlock *OldSucc,
                            BasicBlock *NewSucc,
                            std::vector<DominatorTree::UpdateType> &DTUpdates) {
  BranchInst *BI = dyn_cast<BranchInst>(BB->getTerminator());
  assert(BI);
  bool Changed = false;
  for (Use &Op : BI->operands()) {
    if (Op == OldSucc) {
      Op.set(NewSucc);
      Changed = true;
    }
  }

  if (Changed) {
    DTUpdates.push_back({DominatorTree::UpdateKind::Insert, BB, NewSucc});
    DTUpdates.push_back({DominatorTree::UpdateKind::Delete, BB, OldSucc});
  }
  assert(Changed && "Expected a successor to be updated");
}

static int spaces = 0;

static void printHelper(Loop *L) {
  for (int i = 0; i < spaces; ++i) {
    dbgs() << " ";
  }
  dbgs() << L->getHeader()->getName() << "\n";
  for (Loop *SubLoop : L->getSubLoops()) {
    spaces += 2;
    printHelper(SubLoop);
    spaces -= 2;
  }
}

void printLoopTree(Loop *L) {
  printHelper(L);
  dbgs() << "---------------------\n";
}

static void updateLoopTree(Loop *Outer, Loop *Inner, Loop *OuterParent,
                           Loop *InnerParent, Loop *OuterChild,
                           Loop *InnerChild, LoopInfo &LI) {
  // Outermost is used for debug printing.
  Loop *Outermost = (OuterParent) ? OuterParent : Outer;
  LLVM_DEBUG(printLoopTree(Outermost));

  /*
    The tree that we have is a chain (because the nest is perfect):

    OuterParent -> Outer -> OuterChild -> ... -> InnerParent -> Inner ->
    InnerChild

    We want to interchange Outer with Inner. But, we have to account that
    OuterParent, InnerChild or the range [OuterChild, InnerParent] might not
    exist. Or that OuterChild == InnerParent.
  */

  // We have to free inner before we possibly make it top-level
  InnerParent->removeChildLoop(Inner);

  // First, remove Outer from its parent and put Inner in its place.
  if (OuterParent) {
    OuterParent->removeChildLoop(Outer);
    OuterParent->addChildLoop(Inner);
  } else { // Outer is (or was...) a top-level loop
    LI.changeTopLevelLoop(Outer, Inner);

    Outermost = Inner;
  }

  // Then, remove InnerChild from Inner and make Outer its parent.
  if (InnerChild) {
    Inner->removeChildLoop(InnerChild);
    Outer->addChildLoop(InnerChild);
  }

  // Effectively now we have handled the two ends. Now we need to handle
  // the middle-part.

  if (InnerParent == Outer) {
    // Inner has already been placed in its place (i.e., child of OuterParent)
    // but we need to now put Outer in its place (note that we couldn't do that
    // before possibly making Inner top-level (above). That's because
    // changeTopLevelLoop() requires that both loops are top-level (i.e., have
    // no parent).
    Inner->addChildLoop(Outer);
  } else {
    // Handle the right end of the middle part
    InnerParent->addChildLoop(Outer);
    // Handle the left end of the middle part.
    Outer->removeChildLoop(OuterChild);
    Inner->addChildLoop(OuterChild);
  }

  LLVM_DEBUG(printLoopTree(Outermost));
}

static void updateLoopBlocks(Loop *Outer, Loop *Inner, BasicBlock *OuterPH,
                             BasicBlock *InnerPH, Loop *OuterParent,
                             Loop *InnerParent, Loop *OuterChild,
                             LoopInfo &LI) {
  BasicBlock *InnerHeader = Inner->getHeader();
  BasicBlock *InnerLatch = Inner->getLoopLatch();
  BasicBlock *OuterHeader = Outer->getHeader();
  BasicBlock *OuterLatch = Outer->getLoopLatch();

  // Initial loop tree:
  //   OuterParent -> Outer -> OuterChild -> ... -> InnerParent -> Inner ->
  //   InnerChild
  // We are thinking in terms of that, thinking of course that Inner has changed
  // places with Outer.

  /*
   * Handle the right end (i.e., Inner and to the right). Notice that we don't
   * have to do much for these blocks because those are (correctly) in both
   * Inner and Outer. We just have to change the parent a very few that are in
   * the boundary.
   */
  SmallVector<BasicBlock *, 8> InnerBlocks(Inner->blocks());
  for (BasicBlock *BB : InnerBlocks) {
    // Nothing will change for BBs in child loops of Inner.
    if (LI.getLoopFor(BB) != Inner)
      continue;
    // Change the parent loop for blocks that are inside Inner but still
    // not in any of its child loops. We should do that for all blocks
    // except for InnerHeader and InnerLatch because those still have Inner
    // as their parent (and were "moved" along with it).
    if (BB != InnerHeader && BB != InnerLatch) {
      LI.changeLoopFor(BB, Outer);
    }
  }

  /*
   * We don't want to do anything for the blocks in the left end (i.e.,
   * OuterParent and to the left. Now, we want to handle the middle part (i.e.,
   * [Outer, OuterChild, ..., Inner]). These are the most tricky. Here's what we
   * want to achieve and some notes:
   * ---------- Section 1 - Handled after the loop -----------
   * - Pre-headers are special because their parent is not "their" loop but its
   *   parent
   * ---------- Section 2 - Handled in the loop -----------
   * - Inner should get the blocks of loops in [OuterChild, ..., InnerParent]
   *   and get its blocks removed from this loops.
   * - Outer should get the blocks of the same range removed from it and
   *   get its blocks in these loops.
   * ---------- Section 3 - Handled before the loop -----------
   * - Outer's blocks should be added to Inner and Inner's blocks
   *   be removed from Outer.
   */

  // Interaction of Inner's blocks with Outer and Outer's
  // blocks with Inner.
  Outer->removeBlockFromLoop(InnerPH);
  Outer->removeBlockFromLoop(InnerHeader);
  Outer->removeBlockFromLoop(InnerLatch);
  Inner->addBlockEntry(OuterPH);
  Inner->addBlockEntry(OuterHeader);
  Inner->addBlockEntry(OuterLatch);

  // Handle make blocks for
  // Notice that CurrentLoop goes into the range [OuterChild, ..., InnerParent]
  // in the original tree. However, we have already changed the loop tree
  // so, we actually have to start from Inner and go inside till Outer.
  Loop *CurrentLoop = (OuterChild != Inner) ? OuterChild : Outer;
  LI.changeLoopFor(CurrentLoop->getLoopPreheader(), Inner);
  while (CurrentLoop != Outer) {
    // Interaction of Inner's blocks with loops in the range.
    CurrentLoop->removeBlockFromLoop(InnerPH);
    CurrentLoop->removeBlockFromLoop(InnerHeader);
    CurrentLoop->removeBlockFromLoop(InnerLatch);
    Inner->addBlockEntry(CurrentLoop->getLoopPreheader());
    Inner->addBlockEntry(CurrentLoop->getHeader());
    Inner->addBlockEntry(CurrentLoop->getLoopLatch());

    // Interaction of Outers's blocks with loops in the range.
    Outer->removeBlockFromLoop(CurrentLoop->getLoopPreheader());
    Outer->removeBlockFromLoop(CurrentLoop->getHeader());
    Outer->removeBlockFromLoop(CurrentLoop->getLoopLatch());
    CurrentLoop->addBlockEntry(OuterPH);
    CurrentLoop->addBlockEntry(OuterHeader);
    CurrentLoop->addBlockEntry(OuterLatch);
    CurrentLoop = *(CurrentLoop->getSubLoops().begin());
  }
  // Set parents for pre-headers.
  if (OuterParent)
    LI.changeLoopFor(InnerPH, OuterParent);
  else
    LI.changeLoopFor(InnerPH, nullptr);
  if (InnerParent != Outer)
    LI.changeLoopFor(OuterPH, InnerParent);
  else
    LI.changeLoopFor(OuterPH, Inner);
}

static void updateLoopInfo(Loop *Outer, Loop *Inner, BasicBlock *OuterPH,
                           BasicBlock *InnerPH, LoopInfo &LI,
                           ScalarEvolution &SE) {
  /*
   * Gather needed nodes.
   */
  Loop *OuterParent = Outer->getParentLoop();
  Loop *InnerParent = Inner->getParentLoop();
  assert(InnerParent); // Inner can't be a top-level loop because it has
                       // to be inside Outer
  // assert(OuterParent); <-- No! Outer might be a top-level loop

  Loop *OuterChild = *(Outer->getSubLoops().begin());
  // Outer must have a child because it must at least have
  // Inner as a descendant.
  assert(OuterChild);

  Loop *InnerChild = nullptr;
  if (!Inner->isInnermost()) {
    InnerChild = *(Inner->getSubLoops().begin());
  }

  updateLoopTree(Outer, Inner, OuterParent, InnerParent, OuterChild, InnerChild,
                 LI);
  updateLoopBlocks(Outer, Inner, OuterPH, InnerPH, OuterParent, InnerParent,
                   OuterChild, LI);
}

// Interchange loops Outer, Inner in `loopsToInterchange`. LoopsToInterchange
// type comes with guarantees, see its definition.
//
// Return true if any code was changed, otherwise false.
bool llvm::noelle::interchangeLoops(LoopsToInterchange loopsToInterchange, DominatorTree &DT,
                      LoopInfo &LI, ScalarEvolution &SE, Function &F) {
  // TODO: LCSSA phis?

  Loop *Outer = loopsToInterchange.Outer;
  assert(Outer);
  Loop *Inner = loopsToInterchange.Inner;
  assert(Inner);

  LLVM_DEBUG(dbgs() << "Outer: " << Outer->getHeader()->getName() << "\n");
  LLVM_DEBUG(dbgs() << "Inner: " << Inner->getHeader()->getName() << "\n");

  if (!checkExpectedLoopStructure(Outer, Inner, SE))
    return false;

  BasicBlock *OuterHeader = Outer->getHeader();
  BasicBlock *OuterPH = Outer->getLoopPreheader();
  BasicBlock *OuterLatch = Outer->getLoopLatch();
  BasicBlock *OuterExitBlock = Outer->getExitBlock();

  BasicBlock *InnerHeader = Inner->getHeader();
  BasicBlock *InnerPH = Inner->getLoopPreheader();
  BasicBlock *InnerLatch = Inner->getLoopLatch();
  BasicBlock *InnerExitBlock = Inner->getExitBlock();

  PHINode *InnerIV = getInductionVariable(Inner, SE);
  PHINode *OuterIV = getInductionVariable(Outer, SE);
  // We know because of the checking
  assert(InnerIV && OuterIV);

  if (Inner->isInnermost()) {
    Instruction *InnerIVStep =
        cast<Instruction>(InnerIV->getIncomingValueForBlock(InnerLatch));
    // We know because of the checking
    assert(InnerIVStep);

    InnerLatch =
        SplitBlock(InnerLatch, InnerIVStep, &DT, &LI, nullptr, "inner.latch");
  }

  BasicBlock *InnerHeaderTrueSuccessor;
  BasicBlock *InnerHeaderFalseSuccessor = InnerExitBlock;
  if (InnerHeader->getTerminator()->getSuccessor(0) == InnerExitBlock)
    InnerHeaderTrueSuccessor = InnerHeader->getTerminator()->getSuccessor(1);
  else
    InnerHeaderTrueSuccessor = InnerHeader->getTerminator()->getSuccessor(0);

  BasicBlock *OuterHeaderTrueSuccessor;
  BasicBlock *OuterHeaderFalseSuccessor = OuterExitBlock;
  if (OuterHeader->getTerminator()->getSuccessor(0) == OuterExitBlock)
    OuterHeaderTrueSuccessor = OuterHeader->getTerminator()->getSuccessor(1);
  else
    OuterHeaderTrueSuccessor = OuterHeader->getTerminator()->getSuccessor(0);

  BasicBlock *InnerPHSinglePredecessor = InnerPH->getSinglePredecessor();
  BasicBlock *InnerLatchSinglePredecessor = InnerLatch->getSinglePredecessor();
  BasicBlock *OuterLatchSinglePredecessor = OuterLatch->getSinglePredecessor();
  assert(OuterLatchSinglePredecessor);
  assert(InnerLatchSinglePredecessor);
  assert(InnerPHSinglePredecessor);

  /*
   * Split the outer PH. It makes easy to re-target it and it also
   * allows us not to worry if it has any stuff in it.
   */
  SplitBlock(OuterPH, OuterPH->getTerminator(), &DT, &LI, nullptr, "outer.ph");
  BasicBlock *SplitAbove = OuterPH;
  // Get the new PH of Outer
  OuterPH = Outer->getLoopPreheader();

  // Start the updates
  std::vector<DominatorTree::UpdateType> DTUpdates;

  updateSuccessor(SplitAbove, OuterPH, InnerPH, DTUpdates);

  // First, the easy

  // Fix outer header true
  updateSuccessor(OuterHeader, OuterHeaderTrueSuccessor,
                  InnerHeaderTrueSuccessor, DTUpdates);
  // Fix inner header false
  updateSuccessor(InnerHeader, InnerHeaderFalseSuccessor,
                  OuterHeaderFalseSuccessor, DTUpdates);

  // Fix how we reach outer latch
  updateSuccessor(InnerLatchSinglePredecessor, InnerLatch, OuterLatch,
                  DTUpdates);

  // Fix inner header true
  if (OuterHeaderTrueSuccessor == InnerPH) {
    updateSuccessor(InnerHeader, InnerHeaderTrueSuccessor, OuterPH, DTUpdates);
  } else {
    updateSuccessor(InnerHeader, InnerHeaderTrueSuccessor,
                    OuterHeaderTrueSuccessor, DTUpdates);
    updateSuccessor(InnerPHSinglePredecessor, InnerPH, OuterPH, DTUpdates);
  }

  // Fix outer header false
  if (InnerHeaderFalseSuccessor == OuterLatch) {
    updateSuccessor(OuterHeader, OuterHeaderFalseSuccessor, InnerLatch,
                    DTUpdates);
  } else {
    updateSuccessor(OuterHeader, OuterHeaderFalseSuccessor,
                    InnerHeaderFalseSuccessor, DTUpdates);
    updateSuccessor(OuterLatchSinglePredecessor, OuterLatch, InnerLatch,
                    DTUpdates);
  }

  /*
   * Done with CFG changes, update and verify analyses.
   */
  DT.applyUpdates(DTUpdates);
  assert(DT.verify(DominatorTree::VerificationLevel::Full));
  updateLoopInfo(Outer, Inner, OuterPH, InnerPH, LI, SE);
  LI.verify(DT);
  // Update ScalarEvolution
  SE.forgetLoop(Outer);
  SE.forgetLoop(Inner);
  SE.verify();

  // TODO: Recurrences!!

  // SmallVector<PHINode *, 4> InnerPhis, OuterPhis;
  // for (PHINode &Phi : OuterHeader->phis()) {
  //  if (&Phi != OuterIV)
  //    OuterPhis.push_back(&Phi);
  //}
  // for (PHINode &Phi : InnerHeader->phis()) {
  //  if (&Phi != InnerIV)
  //    InnerPhis.push_back(&Phi);
  //}

  // for (PHINode *Phi : OuterPhis) {
  //  Phi->moveBefore(InnerHeader->getFirstNonPHI());
  //}

  // for (PHINode *Phi : InnerPhis) {
  //  Phi->moveBefore(OuterHeader->getFirstNonPHI());
  //}

  OuterHeader->replacePhiUsesWith(InnerPH, OuterPH);
  OuterHeader->replacePhiUsesWith(InnerLatch, OuterLatch);
  InnerHeader->replacePhiUsesWith(OuterPH, InnerPH);
  InnerHeader->replacePhiUsesWith(OuterLatch, InnerLatch);

  // dbgs() << F;

  return true;
}
