#include <vector>

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"

#include "llvm/NOELLE/PDG/PDG.h"
#include "llvm/NOELLE/PDG/PDGPrinter.h"
#include "llvm/NOELLE/Transformer/LoopDistribution.h"

using namespace llvm;
using namespace noelle;

#define DEBUG_TYPE "loop-dist"

enum class CollectDepsToOrFrom {
  TO,
  FROM
};

static void recursivelyCollectDataDeps(
    const Instruction *Inst, const Loop *L, const PDG *LoopPDG,
    std::set<const Instruction *> &ToPopulate, bool IncludeControlDependences,
    bool IncludeMemoryDependences, bool IncludeRegisterDependences,
    bool OnlyInLoop, CollectDepsToOrFrom ToOrFrom) {
  std::vector<const Instruction *> Queue = {Inst};
  auto FunctionToInvokePerDependence =
      [&L, &OnlyInLoop, &Queue, &ToPopulate](const Value *EdgeEndV,
                                DGEdge<Value> *DepEdge) -> bool {
    if (!isa<Instruction>(EdgeEndV)) {
      return false;
    }
    const Instruction *EdgeEnd = cast<Instruction>(EdgeEndV);

    // Ignore dependences that are outside of the loop
    if (OnlyInLoop && !L->contains(EdgeEnd))
      return false;

    // Ignore duplicates
    if (ToPopulate.count(EdgeEnd)) {
      return false;
    }
    ToPopulate.insert(EdgeEnd);
    Queue.push_back(EdgeEnd);
    return false;
  };
  while (Queue.size() != 0) {
    const Instruction *I = Queue.back();
    Queue.pop_back();
    if (ToOrFrom == CollectDepsToOrFrom::FROM) {
      LoopPDG->iterateOverDependencesFrom(I,
                                          IncludeControlDependences, 
                                          IncludeMemoryDependences,
                                          IncludeRegisterDependences,
                                          FunctionToInvokePerDependence);
    } else {
      assert(ToOrFrom == CollectDepsToOrFrom::TO);
      LoopPDG->iterateOverDependencesTo(I,
                                        IncludeControlDependences,
                                        IncludeMemoryDependences,
                                        IncludeRegisterDependences,
                                        FunctionToInvokePerDependence);
    }
  }
  return;
}

// Add every instruction `J` that depends on `Inst` (i.e. edges Inst -> J) to
// `ToPopulate`
static void
recursivelyCollectDataDepsAnywhereFrom(Instruction *Inst, const Loop *L,
                                       const PDG *LoopPDG,
                                       std::set<const Instruction *> &ToPopulate) {
  return recursivelyCollectDataDeps(Inst, L, LoopPDG, ToPopulate, 
                                    false, // IncludeControlDependences
                                    true,  // IncludeMemoryDependences
                                    true,  // IncludeRegisterDependences
                                    false, // OnlyInLoop
                                    CollectDepsToOrFrom::FROM);
}

// Add every instruction `J` that `Inst` depends on (i.e. edges J -> Inst) to
// `ToPopulate` only if `J` is in the loop.
static void
recursivelyCollectDataDepsInLoopTo(Instruction *Inst, const Loop *L, const PDG *LoopPDG,
                                   std::set<const Instruction *> &ToPopulate) {
  return recursivelyCollectDataDeps(Inst, L, LoopPDG, ToPopulate, 
                                    false, // IncludeControlDependences
                                    true,  // IncludeMemoryDependences
                                    true,  // IncludeRegisterDependences
                                    true, // OnlyInLoop
                                    CollectDepsToOrFrom::TO);
}

static void preservePDG(PDG *ModulePDG, const Loop *OrigLoop, const Loop *NewLoop,
                        const std::set<Instruction *> &SCC,
                        const std::set<const Instruction *> &InstsToClone,
                        ValueToValueMapTy &MapOrigToNew) {

  auto IsInNewLoop = [&SCC, &InstsToClone](const Value *V) -> bool {
    Instruction *I = (Instruction *)dyn_cast<Instruction>(V);
    if (!I)
      return false;
    // You don't want to use NewLoop->contains() because NewLoop currently
    // contains more instructions than are going to be left in the end.
    // SCC U InstsToClone are those that will be left.
    return SCC.count(I) || InstsToClone.count(I);
  };

  /*
   * First create the NewLoop's PDG (only the nodes and only for those instructions
   * that will be left after removals)
   *
   * Note: You have to start from the instructions of the OrigLoop to test for instructions
   * in the new loop. Those instructions are not going to _actually_ be in the new loop,
   * rather copies of them. But you can't sort out somehow only their respective copies
   * because SCC, InstsToClone were created with the old instructions. So, you just
   * use the old and then you VMap to the new.
   *
   * This is a them across the rest of the function
   */
  for (BasicBlock *BB : OrigLoop->getBlocks()) {
    for (Instruction &OrigInst : *BB) {
      if (IsInNewLoop(&OrigInst)) {
        assert(MapOrigToNew.count(&OrigInst));
        Instruction *NewInst = dyn_cast<Instruction>(MapOrigToNew[&OrigInst]);
        assert(NewInst);
        assert(ModulePDG->fetchNode(NewInst) == nullptr);
        ModulePDG->addNode(NewInst, /* isInternal = */ true);
      }
    }
  }
  
  /*
   * Start from the old instructions and move to the new. See comment in the
   * population of the new loop's PDG above.
   */
  for (BasicBlock *BB : OrigLoop->getBlocks()) {
    for (Instruction &OrigInst : *BB) {
      if (!IsInNewLoop(&OrigInst))
        continue;
      assert(MapOrigToNew.count(&OrigInst));
      Instruction *NewInst = dyn_cast<Instruction>(MapOrigToNew[&OrigInst]);
      /*
       * Add the new node
       */
      DGNode<Value> *OrigNode = ModulePDG->fetchNode(&OrigInst);
      assert(OrigNode);
      /*
       * Add incoming edges to the node
       */
      for (DGEdge<Value> *Edge : OrigNode->getIncomingEdges()) {
        const Value *OrigFromValue = Edge->getOutgoingT();
        const Value *NewFromValue;
        if (!MapOrigToNew.count(OrigFromValue)) {
          // If the old value is _not_ in the VMap, it's supposed to be outside
          // the loop and the NewFromValue is the same as the OrigFromValue.
          const Instruction *OrigFromInst = dyn_cast<Instruction>(OrigFromValue);
          if (OrigFromInst)
            assert(!OrigLoop->contains(OrigFromInst));
          NewFromValue = OrigFromValue;
        } else {
          // We don't want to add an edge from a value that won't be there.
          if (!IsInNewLoop(OrigFromValue))
            continue;
          NewFromValue = MapOrigToNew[OrigFromValue];
        }
        DGEdge<Value> *NewEdge =
            ModulePDG->createUncharacterizedEdge(NewFromValue, NewInst);
        NewEdge->copyEdgeCharacteristics(*Edge);
        ModulePDG->addEdge(NewEdge);
      }

      /*
       * Add incoming edges to the node
       */
      for (DGEdge<Value> *Edge : OrigNode->getOutgoingEdges()) {
        const Value *OrigToValue = Edge->getIncomingT();
        const Value *NewToValue;
        if (!MapOrigToNew.count(OrigToValue)) {
          // If the old value is _not_ in the VMap, it's supposed to be outside
          // the loop and the NewToValue is the same as the OrigToValue.
          // For "to" edges though, the situation becomes more complicated very
          // fast. Consider this:

          //   %dummy = ...;
          //   %part_of_SCC = uses %dummy
          // ...
          // ret %dummy
          //
          // The SCC is dependent to %dummy, so it'll bring it along as
          // %dummy.ldist %dummy has an edge %dummy -> ret. We don't want to
          // create another edge %dummy.ldist -> ret, because since the new loop
          // is copied _exactly above_ the old one, for register deps, the
          // outside users can use the old value.
          //
          // Note for this reasoning to work, the original loop should
          // post-dominate the new loop which is true because we assume that the
          // original loop (and thus the new one also) has a single exit block.
          // In the new loop, this is mapped as the PH of the new loop, so the
          // post-dominance guarantee is preserved (i.e., you can't skip the
          // original loop).
          //
          // TODO: I have to re-think this
          // TODO: Can we eliminate memory deps somehow? (quick answer: probably
          // not)
          // TODO: What happens with control deps ? (thought: we probably don't
          // care because all the control-flow is copied to the new loop. Also,
          // since the original loop post-dominates the new loop (see above),
          // nothing outside the new loop should be control-dependent on it).
          const Instruction *OrigToInst = dyn_cast<Instruction>(OrigToValue);
          if (OrigToInst)
            assert(!OrigLoop->contains(OrigToInst));
          if (Edge->isRegisterDependence())
            continue;
          NewToValue = OrigToValue;
        } else {
          // We don't want to add an edge to a value that won't be there.
          if (!IsInNewLoop(OrigToValue))
            continue;
          NewToValue = MapOrigToNew[OrigToValue];
        }
        DGEdge<Value> *NewEdge =
            ModulePDG->createUncharacterizedEdge(NewInst, NewToValue);
        NewEdge->copyEdgeCharacteristics(*Edge);
        ModulePDG->addEdge(NewEdge);
      }
    }
  }

  for (Instruction *RemovedFromOriginal : SCC) {
    DGNode<Value> *Node = ModulePDG->fetchNode(RemovedFromOriginal);
    assert(Node);
    ModulePDG->removeNode(Node);
  }
}


namespace llvm {
namespace noelle {

Loop *SCCSpansOneLoop(const std::set<Instruction *> &SCC, const LoopInfo &LI) {
  Instruction *FirstI = *SCC.begin();
  Loop *CommonLoop = LI.getLoopFor(FirstI->getParent());
  for (Instruction *I : SCC) {
    Loop *L = LI.getLoopFor(I->getParent());
    if (L != CommonLoop)
      return nullptr;
  }
  return CommonLoop;
}

// TODO: Maybe add granularity by returning why it failed. We can take
// the hit of coupling here, like if we're only interested in the third
// condition breaking because the first two are really cheap.
bool isLoopDistributable(const Loop *L) {
  // For now, support only simplified loops
  if (!L->isLoopSimplifyForm()) {
    LLVM_DEBUG(dbgs() << "LoopDistribution::isLoopDistributable -> Loop is not "
                         "in simplify form.\n");
    return false;
  }

  // For now, we need that when we're mapping control-flow from the new loop to
  // the old.
  BasicBlock *OrigExitBlock = L->getExitBlock();
  if (!OrigExitBlock) {
    LLVM_DEBUG(
        dbgs() << "LoopDistribution::isLoopDistributable -> Loop has more than "
                  "one exit blocks.\n");
    return false;
  }

  // Check that all terminators are branches
  for (BasicBlock *BB : L->getBlocks()) {
    if (!isa<BranchInst>(BB->getTerminator())) {
      LLVM_DEBUG(
          errs()
          << "LoopDistribution::isLoopDistributable -> Abort: Non-branch "
             "terminator: "
          << *BB->getTerminator() << "\n");
      return false;
    }
  }

  return true;
}

void findInstsToClone(const std::set<Instruction *> &SCC, const PDG *LoopPDG,
                      const Loop *OrigLoop,
                      std::set<const Instruction *> &InstsToClone) {
  // Collect all the branches and any instructions they depend on.
  for (BasicBlock *BB : OrigLoop->getBlocks()) {
    if (auto Branch = dyn_cast<BranchInst>(BB->getTerminator())) {
      InstsToClone.insert(Branch);
      recursivelyCollectDataDepsInLoopTo(Branch, OrigLoop, LoopPDG,
                                         InstsToClone);
    }
  }

  // Gather instructions that SCC depend on to clone them along.
  for (Instruction *InstToPullOut : SCC) {
    recursivelyCollectDataDepsInLoopTo(InstToPullOut, OrigLoop, LoopPDG,
                                       InstsToClone);
  }
}

bool isLegalToRemoveSCCFromLoop(const std::set<Instruction *> &SCC,
                                const Loop *OrigLoop, const PDG *LoopPDG) {
  /*
   * Check that no instruction outside SCC depends on any instruction
   * inside. If at least one instruction depends on at least one from SCC,
   * we have to keep all of them because they're an SCC! (i.e. every instruction
   * transitively depends on every other instruction).
   * Another way to phrase this is: The SCC must be a sink!
   */

  for (Instruction *I : SCC) {
    std::set<const Instruction *> DependOnInstWePulledOut;
    recursivelyCollectDataDepsAnywhereFrom(I, OrigLoop, LoopPDG,
                                           DependOnInstWePulledOut);
    for (const Instruction *D : DependOnInstWePulledOut) {
      if (!SCC.count((Instruction *)D)) {
        dbgs() << "Source: " << *I << "\n";
        dbgs() << "Dest: " << *D << "\n";
        LLVM_DEBUG(
            errs()
            << "LoopDistribution::isLegalToRemoveSCCFromLoop -> We can't "
               "remove "
               "the SCC from "
               "the loop because instructions outside of it depend on it.\n");
        return false;
      }
    }
  }
  return true;
}

bool newLoopAsBigAsTheOriginal(
    std::set<Instruction *> const &SCC,
    std::set<const Instruction *> const &InstsToClone, const Loop *L) {

  /*
   * Checks if the union of SCC and InstsToClone covers every
   * instruction in the loop that is not a branch (since we will replicate those
   * anyway).
   */
  for (BasicBlock *BB : L->getBlocks()) {
    for (Instruction &I : *BB) {
      if (!SCC.count(&I) && !InstsToClone.count(&I) && !isa<BranchInst>(&I)) {
        return false;
      }
    }
  }
  return true;
}

bool isSCCDistributionTrivial(
    const std::set<Instruction *> &SCC, const LoopInfo &LI,
    const Loop *OrigLoop, const PDG *LoopPDG,
    const std::set<const Instruction *> &InstsToClone) {

  if (!isLegalToRemoveSCCFromLoop(SCC, OrigLoop, LoopPDG))
    return true;

  if (newLoopAsBigAsTheOriginal(SCC, InstsToClone, OrigLoop)) {
    LLVM_DEBUG(errs() << "LoopDistribution: Abort: Request is meaningless; the "
                         "new loop will be as big as the original\n");
    return true;
  }

  return false;
}

void removeSCCFromOriginal(const std::set<Instruction *> &SCC) {
  for (Instruction *I : SCC) {
    if (!I->use_empty())
      I->replaceAllUsesWith(UndefValue::get(I->getType()));
    I->eraseFromParent();
  }
}

void removeInstructionsFromNewLoop(
    const Loop *OrigLoop, const std::set<Instruction *> &SCC,
    const std::set<const Instruction *> &InstsToClone,
    ValueToValueMapTy &MapOrigToNew) {
  /*
   * Remove instructions from the _new_ loop that are neither in SCC
   * nor in InstsToClone (we have to gather them all first then erase them
   * because if we iterate over them and erase at the same time, there are
   * problems with the iterators).
   */
  std::set<Instruction *> ToBeRemovedFromNew;
  for (BasicBlock *OrigBB : OrigLoop->getBlocks()) {
    for (Instruction &OrigInst : *OrigBB) {
      if (!SCC.count(&OrigInst) && !InstsToClone.count(&OrigInst)) {
        Instruction *NewInst = cast<Instruction>(MapOrigToNew[&OrigInst]);
        ToBeRemovedFromNew.insert(NewInst);
      }
    }
  }

  LLVM_DEBUG(dbgs() << "\n--- ToBeRemovedFromNew ---\n\n");
  for (Instruction *I : ToBeRemovedFromNew) {
    LLVM_DEBUG(dbgs() << *I << "\n");
    if (!I->use_empty())
      I->replaceAllUsesWith(UndefValue::get(I->getType()));
    I->eraseFromParent();
  }
  LLVM_DEBUG(dbgs() << "\n\n");
}

void
removeInstructions(Loop *OrigLoop, Loop *NewLoop,
                   const std::set<Instruction *> &SCC,
                   const std::set<const Instruction *> &InstsToClone,
                        ValueToValueMapTy &MapOrigToNew) {
  removeSCCFromOriginal(SCC);
  removeInstructionsFromNewLoop(OrigLoop, SCC, InstsToClone, MapOrigToNew);
}


// TODO: The preservation is coupled with the removal of instructions. Removal does
// not assume preservation but preservation assumes that later some instructions
// will be removed.
void preservePDGAndRemoveInstructions(
    DominatorTree &DT, LoopInfo &LI, PDG *ModulePDG, Loop *OrigLoop,
    Loop *NewLoop, const std::set<Instruction *> &SCC,
    const std::set<const Instruction *> &InstsToClone,
    ValueToValueMapTy &MapOrigToNew) {

  preservePDG(ModulePDG, OrigLoop, NewLoop, SCC, InstsToClone, MapOrigToNew);
  removeInstructions(OrigLoop, NewLoop, SCC, InstsToClone, MapOrigToNew);

}

Loop *cloneLoop(Loop *OrigLoop, ValueToValueMapTy &VMap, LoopInfo &LI,
                DominatorTree &DT) {
  assert(isLoopDistributable(OrigLoop));
  BasicBlock *OrigExitBlock = OrigLoop->getExitBlock();
  // Should have a single exit block because reaching here, we should have
  // checked if we can distribute the loop.
  assert(OrigExitBlock);
  // Should have a preheader because we checked if it is in simplify form.
  BasicBlock *OrigPH = OrigLoop->getLoopPreheader();
  assert(OrigPH);

  // To keep things simple have an empty preheader before clone
  // the loop.  (Also split if this has no predecessor, i.e. entry, because we
  // rely on PH having a predecessor.). That simplifies the update of dominance
  // tree.
  if (!OrigPH->getSinglePredecessor() ||
      &*OrigPH->begin() != OrigPH->getTerminator())
    SplitBlock(OrigPH, OrigPH->getTerminator(), &DT, &LI);

  // The new block is added "below", so OrigPH is still what it was (e.g, it has
  // no predecessors) and is no longer the loop PH. The _new_ block is the new
  // PH. SplitBlock has done the job of updating LI and DT, we just have to get
  // the new PH.
  OrigPH = OrigLoop->getLoopPreheader();

  BasicBlock *Pred = OrigPH->getSinglePredecessor();
  assert(Pred);
  SmallVector<BasicBlock *, 4> NewBlocks;
  Loop *NewLoop = cloneLoopWithPreheader(OrigPH, Pred, OrigLoop, VMap,
                                         Twine(".ldist"), &LI, &DT, NewBlocks);
  VMap[OrigExitBlock] = OrigPH;
  remapInstructionsInBlocks(NewBlocks, VMap);
  assert(!OrigLoop->isInvalid());
  Pred->getTerminator()->replaceUsesOfWith(OrigPH, NewLoop->getLoopPreheader());

  /*
   * Update the IDom for the OrigPH with the exiting block of the new loop.
   * Remember, the new loop is created _above_ the original loop. Dominance
   * _within_ the loop is updated in cloneLoopWithPreheader.
   */
  BasicBlock *NewLoopExitingBlock = NewLoop->getExitingBlock();
  DT.changeImmediateDominator(OrigLoop->getLoopPreheader(),
                              NewLoopExitingBlock);

  /*
   * For some reason, just running verify<domtree>, verify<loops> didn't do the
   * trick.
   */
  assert(DT.verify());
  LI.verify(DT);

  return NewLoop;
}


void splitSCCUnchecked(const std::set<Instruction *> &SCC, const PDG *LoopPDG,
                       const std::set<const Instruction *> &InstsToClone,
                       PDG *ModulePDG, LoopInfo &LI, DominatorTree &DT,
                       Loop *OrigLoop) {
  /*
   * SCC are the instructions that we want to pull in a separate loop.
   * We assume that these instructions form an SCC in LoopPDG which implies
   * a couple of things e.g., that each such instruction in SCC depends
   * on each other instruction (transitively).
   */

  // TODO: assert(SCC is actually a strongly-connected component)
  assert(LoopPDG);
  assert(ModulePDG);
  assert(OrigLoop);
  assert(SCCSpansOneLoop(SCC, LI) == OrigLoop);
  assert(isLoopDistributable(OrigLoop));
  assert(isLegalToRemoveSCCFromLoop(SCC, OrigLoop, LoopPDG));

  LLVM_DEBUG(dbgs() << "\n\n--- SCC ---\n\n");
  for (auto I : SCC) {
    LLVM_DEBUG(dbgs() << *I << "\n");
  }

  LLVM_DEBUG(dbgs() << "\n\n\n--- Insts To Clone ---\n\n");
  for (auto I : InstsToClone) {
    LLVM_DEBUG(dbgs() << *I << "\n");
  }

  LLVM_DEBUG(dbgs() << "\n\n");

  //  Clone the loop!
  ValueToValueMapTy MapOrigToNew;
  Loop *NewLoop = cloneLoop(OrigLoop, MapOrigToNew, LI, DT);

  preservePDGAndRemoveInstructions(DT, LI, ModulePDG, OrigLoop, NewLoop,
                                        SCC, InstsToClone, MapOrigToNew);
}

bool splitSCC(const std::set<Instruction*>& SCC,
  PDG* ModulePDG, LoopInfo& LI, DominatorTree& DT) {
  assert(!SCC.empty());
  Loop *OrigLoop = SCCSpansOneLoop(SCC, LI);
  if (!OrigLoop) {
    LLVM_DEBUG(dbgs() << "LoopDistribution::splitSCC -> The SCC "
                          "spans multiple loops\n");
    return false;
  }

  if (!isLoopDistributable(OrigLoop)) {
    LLVM_DEBUG(dbgs() << "LoopDistribution::splitSCC -> The loop that the SCC "
                         "lives in is not distributable\n");
    return false;
  }

  PDG *LoopPDG = ModulePDG->createLoopSubgraph(OrigLoop);
  std::set<const Instruction *> InstsToClone;
  findInstsToClone(SCC, LoopPDG, OrigLoop, InstsToClone);
  if (isSCCDistributionTrivial(SCC, LI, OrigLoop, LoopPDG, InstsToClone)) {
    LLVM_DEBUG(
        dbgs()
        << "LoopDistribution::splitSCC -> The distribution is trivial\n");
    return false;
  }
  splitSCCUnchecked(SCC, LoopPDG, InstsToClone, ModulePDG, LI, DT, OrigLoop);
  return true;
}

} // namespace noelle
} // namespace llvm
