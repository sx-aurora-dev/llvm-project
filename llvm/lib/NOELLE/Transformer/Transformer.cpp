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

using namespace llvm;
//using namespace noelle;

#define DEBUG_TYPE "noelle-transformer"

static cl::opt<int> LoopDistributionAPIGranularity(
    "loop-dist-api-granularity", cl::init(0), cl::Hidden,
    cl::desc("Determines the granularity of calling the LoopDistribution API"));

static llvm::cl::opt<std::string>
    TransformToApply("noelle-transformer-apply",
                     llvm::cl::desc("The name of the transformation to apply"),
                     llvm::cl::init(""));


/*-------------------------------------------------------------------------*/
/*                            ANALYSIS PART                                */
/*-------------------------------------------------------------------------*/

// static void pruneSCC(Loop *L, PDG *LoopPDG, std::set<Instruction *> &SCC) {
//  std::set<Instruction *> ToBeErased;
//  for (Instruction *I : SCC) {
//    LoadInst *Load = dyn_cast<LoadInst>(I);
//    if (!Load)
//      continue;
//    std::set<Instruction *> DepDsts;
//    recursivelyCollectDependencesFrom(Load, DepDsts, L, LoopPDG,
//                                      /* IncludeControlDeps = */ true,
//                                      /* IncludeMemoryDeps = */ false,
//                                      /* IncludeRegisterDeps = */ true);
//    bool Abort = false;
//    for (Instruction *D : DepDsts) {
//      if (SCC.count(D)) {
//        Abort = true;
//        break;
//      }
//    }
//    if (Abort)
//      continue;
//
//    std::set<DGEdge<Value> *> EdgesToRemove;
//
//    auto Fn = [&SCC, &EdgesToRemove](Value *ToV,
//                                     DGEdge<Value> *DepEdge) -> bool {
//      if (!isa<Instruction>(ToV)) {
//        return false;
//      }
//      Instruction *To = cast<Instruction>(ToV);
//
//      if (!SCC.count(To))
//        return false;
//
//      if (DepEdge->safeToDistribute) {
//        EdgesToRemove.insert(DepEdge);
//        return false;
//      }
//      return true;
//    };
//    Abort = LoopPDG->iterateOverDependencesFrom(
//        Load,
//        /* IncludeControlDeps = */ false,
//        /* IncludeMemoryDeps = */ true,
//        /* IncludeRegisterDeps = */ false, Fn);
//    if (Abort)
//      return;
//
//    for (DGEdge<Value> *Edge : EdgesToRemove) {
//      dbgs() << "Remove: ";
//      dbgs() << *Edge << "\n";
//      LoopPDG->removeEdge(Edge);
//    }
//    ToBeErased.insert(Load);
//  }
//  for (Instruction *I : ToBeErased) {
//    SCC.erase(I);
//    DGNode<Value> *Node = LoopPDG->fetchNode(I);
//    std::set<DGEdge<Value> *> Remove;
//    for (auto Edge : Node->getOutgoingEdges()) {
//      Remove.insert(Edge);
//    }
//    for (auto Edge : Node->getIncomingEdges()) {
//      Remove.insert(Edge);
//    }
//    for (auto Edge : Remove) {
//      LoopPDG->removeEdge(Edge);
//    }
//  }
//}

static void printSCCsInLoopPDG(PDG *LoopPDG) {
  DGGraphWrapper<PDG, Value> pdgWrapper(LoopPDG);

  // The PDG must have an entry node for SCCIterator to work
  assert(LoopPDG->getEntryNode() != nullptr);
  for (auto pdg_scc = scc_begin(&pdgWrapper); pdg_scc != scc_end(&pdgWrapper);
       ++pdg_scc) {

    const std::vector<DGNodeWrapper<Value> *> &sccWrappedNodes = *pdg_scc;

    if (sccWrappedNodes.size() < 2)
      continue;

    LLVM_DEBUG(dbgs() << "\n---- SCC ----\n");

    for (auto sccWrappedNode : sccWrappedNodes) {
      DGNode<Value> *sccNode = sccWrappedNode->wrappedNode;
      LLVM_DEBUG(dbgs() << *sccNode << "\n");
    }
  }
  LLVM_DEBUG(dbgs() << "\n\n--------End of SCCs\n\n");
}

static void printSCCsInLoops(PDG *pdg, LoopInfo &LI) {
  for (Loop *TopLevelLoop : LI) {
    PDG *LoopPDG = pdg->createLoopSubgraph(TopLevelLoop);
    printSCCsInLoopPDG(LoopPDG);
  }
}

static void findSCCUsingMetadata(Function &F, std::set<Instruction *> &SCC) {
  for (BasicBlock &BB : F) {
    for (Instruction &I : BB) {
      if (I.hasMetadata("scc"))
        SCC.insert(&I);
    }
  }
}

static PreservedAnalyses loopDistribute(Module &M, ModuleAnalysisManager &MAM) {
  PDG *pdg = MAM.getResult<PDGAnalysis>(M).get();

  FunctionAnalysisManager &FAM =
      MAM.getResult<FunctionAnalysisManagerModuleProxy>(M).getManager();

  PreservedAnalyses PA = PreservedAnalyses::none();
  PA.preserve<DominatorTreeAnalysis>();
  PA.preserve<LoopAnalysis>();
  PA.preserve<PDGAnalysis>();

  for (Function &F : M) {
    if (!F.hasExactDefinition())
      continue;
    LoopInfo &LI = FAM.getResult<LoopAnalysis>(F);
    DominatorTree &DT = FAM.getResult<DominatorTreeAnalysis>(F);

    // printSCCsInLoops(pdg, LI);

    std::set<Instruction *> SCC;
    findSCCUsingMetadata(F, SCC);
    if (!SCC.empty()) {
      switch (LoopDistributionAPIGranularity) {
      case 0: {
        splitSCC(SCC, pdg, LI, DT);
      } break;
      case 1: {
        Loop *SCCLoop = SCCSpansOneLoop(SCC, LI);
        if (!SCCLoop)
          continue;
        if (!isLoopDistributable(SCCLoop))
          continue;
        PDG *LoopPDG = pdg->createLoopSubgraph(SCCLoop);
        if (!isLegalToRemoveSCCFromLoop(SCC, SCCLoop, LoopPDG))
          continue;
        std::set<const Instruction *> InstsToClone;
        findInstsToClone(SCC, LoopPDG, SCCLoop, InstsToClone);

        // Now, we don't care if it's trivial, we split and preserve
        splitSCCUnchecked(SCC, LoopPDG, InstsToClone, pdg, LI, DT, SCCLoop);
      } break;
      case 2: {
        Loop *SCCLoop = SCCSpansOneLoop(SCC, LI);
        if (!SCCLoop)
          continue;
        if (!isLoopDistributable(SCCLoop))
          continue;
        PDG *LoopPDG = pdg->createLoopSubgraph(SCCLoop);
        if (!isLegalToRemoveSCCFromLoop(SCC, SCCLoop, LoopPDG))
          continue;
        std::set<const Instruction *> InstsToClone;
        findInstsToClone(SCC, LoopPDG, SCCLoop, InstsToClone);

        // Now we'll just clone the loop, and we'll remove the instructions
        // ourselves. But we don't preserve analyses and we don't care.
        ValueToValueMapTy MapOrigToNew;
        cloneLoop(SCCLoop, MapOrigToNew, LI, DT);
        // We even go one granuarlity level up and we don't call removeInstructions()
        removeInstructionsFromNewLoop(SCCLoop, SCC, InstsToClone, MapOrigToNew);
        removeSCCFromOriginal(SCC);

        PA.abandon<DominatorTreeAnalysis>();
        PA.abandon<LoopAnalysis>();
        PA.abandon<PDGAnalysis>();
      } break;
      }
    }
  }
  return PA;
}

// TODO: We may want to decouple the checking of prerequisites (e.g., the nest
// should be perfect) with the discovery of MD. That is, first discover MD
// wherever they are, then check the conditions.
static bool findLoopsToInterchangeFromMeatadata(LoopsToInterchange &Res,
                                                const LoopInfo &LI) {
  Res.Outer = nullptr;
  Res.Inner = nullptr;

  for (Loop *TopLevelLoop : LI.getTopLevelLoops()) {
    Loop *CurrentLoop = TopLevelLoop;
    while (true) {
      if (!CurrentLoop->isLoopSimplifyForm())
        return false;

      // TODO: We should introduce an interchange #pragma. Also, I don't
      // understand why the MD is put in the latch. The header would make more
      // sense as it is unique to every loop.
      if (findStringMetadataForLoop(CurrentLoop, "llvm.loop.distribute.enable")
              .hasValue()) {
        // That's the second one we found, we're finished.
        if (Res.Outer) {
          Res.Inner = CurrentLoop;
          return true;
        } else {
          // Just mark the first one we found
          Res.Outer = CurrentLoop;
        }
      }

      // NOTE: Leave the `const`! Otherwise, if you start changing the
      // SubLoops underlying vector as a reference, suddenly your outer
      // loop might have 0 sub-loops because you changed its SubLoops vector.
      const std::vector<Loop *> &SubLoops = CurrentLoop->getSubLoops();
      // If we don't have exactly one sub-loop, then it is imperfect (and so we
      // can't interchange loops in it) and there's nothing more to see in it.
      if (SubLoops.size() != 1) {
        // If we have already found one loop loop in this nest, then we can't
        // possibly found its match either here or in any other nest (because we
        // can't interchange across nests)
        if (Res.Outer) {
          return false;
        }
        // Else just continue to the next nest.
        break;
      }

      CurrentLoop = SubLoops.front();
    }
  }
  if (Res.Outer && Res.Inner)
    return true;
  return false;
}


static PreservedAnalyses loopInterchange(Module &M, ModuleAnalysisManager &MAM) {
  FunctionAnalysisManager &FAM =
      MAM.getResult<FunctionAnalysisManagerModuleProxy>(M).getManager();

  for (Function &F : M) {
    if (!F.hasExactDefinition())
      continue;

    DominatorTree &DT = FAM.getResult<DominatorTreeAnalysis>(F);
    LoopInfo &LI = FAM.getResult<LoopAnalysis>(F);
    ScalarEvolution &SE = FAM.getResult<ScalarEvolutionAnalysis>(F);

    LoopsToInterchange loopsToInterchange;
    if (!findLoopsToInterchangeFromMeatadata(loopsToInterchange, LI))
      continue;
    if (interchangeLoops(loopsToInterchange, DT, LI, SE, F)) {
      DebugLoc OuterLoc = loopsToInterchange.Outer->getStartLoc();
      DebugLoc InnerLoc = loopsToInterchange.Inner->getStartLoc();
      errs() << "Interchanged loop at: ";
      OuterLoc.print(errs());
      errs() << " with loop at: ";
      InnerLoc.print(errs());
      errs() << "\n";
    }
  }
  PreservedAnalyses PA = PreservedAnalyses::none();
  PA.preserve<DominatorTreeAnalysis>();
  PA.preserve<LoopAnalysis>();
  PA.preserve<ScalarEvolutionAnalysis>();
  return PA;
}

PreservedAnalyses NOELLETransformer::run(Module &M,
                                         ModuleAnalysisManager &MAM) {

  if (TransformToApply == "loop-distribution")
    return loopDistribute(M, MAM);
  else if (TransformToApply == "loop-interchange")
    return loopInterchange(M, MAM);
  else
    assert(false && "Expected valid -noelle-transformer-apply option");

  return PreservedAnalyses::all();
}