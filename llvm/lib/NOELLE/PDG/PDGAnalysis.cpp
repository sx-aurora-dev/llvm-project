#include "llvm/ADT/SCCIterator.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/CallGraph.h"
#include "llvm/Analysis/DependenceAnalysis.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/PostDominators.h"

#include "llvm/NOELLE/PDG/PDGAnalysis.h"
#include "llvm/NOELLE/PDG/PDGPrinter.h"

using namespace llvm;
using namespace noelle;

#define DEBUG_TYPE "pdg"

AnalysisKey PDGAnalysis::Key;

static
void constructEdgesFromUseDefs(PDG *pdg) {
  /*
   * Add the dependences due to registers.
   */
  for (DGNode<Value> *Node : make_range(pdg->begin_nodes(), pdg->end_nodes())) {

    /*
     * Check if the current definition has uses.
     * If no, then there is no register dependence.
     */
    const Value *Val = Node->getT();
    if (Val->getNumUses() == 0) {
      continue;
    }

    // Otherwise, add the uses.
    for (auto &U : Val->uses()) {
      const User *User_ = U.getUser();

      if (isa<Instruction>(User_) || isa<Argument>(User_)) {
        DGEdge<Value> *Edge = pdg->addEdge(Val, (const Value *)User_);
        Edge->setMemMustType(/* mem = */ false, /* must = */ true, DataDepType::RAW);
      }
    }
  }

  return;
}

static void addEdgeFromDepAnalysis(PDG *pdg, DependenceInfo &DI, StoreInst *I,
                                   Instruction *J) {

  // TODO: Look at how AbstractDependenceGraphBuilder handles confused dependences.

  enum Kind {NONE, FLOW, OUTPUT};
  Kind kind;
  if (isa<LoadInst>(J)) {
    kind = FLOW;
  } else if (isa<StoreInst>(J)) {
    kind = OUTPUT;
  } else {
    assert(0);
  }
  
  std::unique_ptr<Dependence> Dep = DI.depends(I, J, true);
  if (Dep == nullptr) {  // No Dep
    return;
  }

  bool Must = false;
  // TODO: It seems that isConsistent() is the equivalent of must/may
  // but I may be missing something.
  if (Dep->isConsistent()) {
    Must = true;
  }

  DGEdge<Value> *Edge1, *Edge2;
  if (kind == FLOW) {
    assert(Dep->isFlow());
    Edge1 = pdg->addEdge(I, J);
    Edge1->setMemMustType(/* mem = */ true, /* must = */ Must,
                          DataDepType::RAW);
    Edge2 = pdg->addEdge(J, I);
    Edge2->setMemMustType(/* mem = */ true, /* must = */ Must,
                          DataDepType::WAR); 
  } else {
    assert(Dep->isOutput());
    Edge1 = pdg->addEdge(I, J);
    Edge1->setMemMustType(/* mem = */ true, /* must = */ Must,
                          DataDepType::WAW);
    Edge2 = pdg->addEdge(J, I);
    Edge2->setMemMustType(/* mem = */ true, /* must = */ Must,
                          DataDepType::WAW); 
  }

  // TODO - IMPORTANT:
  /////////////// This should absolute be changed but I couldn't pass Dep
  ////////////// as a member in DGEdge. I std::move() the unique_ptr yet
  ////////////// on the other side in loop distribution I get a null pointer.
  /**** Used for loop distribution to decide if a store (in the SCC) happens before or after a load (outside) */
  //Edge->safeToDistribute = false;
  //if (Dep->isLoopIndependent() && Dep->isFlow())
  //  Edge->safeToDistribute = true;
  //else {
  //  unsigned Dir = Dep->getDirection(1);
  //  // NOTE!: Although we want the distance to be < 0, the direction
  //  // should be '>'
  //  bool Valid = Dir == Dependence::DVEntry::GT;
  //  if (Valid)
  //    Edge->safeToDistribute = true;
  //}
  //dbgs() << "  safeToDistribute: ";
  //if (Edge->safeToDistribute)
  //  dbgs() << "True\n";
  //else
  //  dbgs() << "False\n";

  //dbgs() << "\n";
}

// IMPORTANT: You have to be very careful on how you interpret ModRefInfo results.
// Because they have ended individual results, it can be very tricky.
// As an example, Ref = NoModRef | MustRef and ModRef = Ref | Mod.
// How do you check if the result is "it only reads" ? You can't
// do Res & Ref because that doesn't mean it won't have the mod
// bit on. You can't do Res == Ref because it might be MustRef.
// So, you have to do: !(Res & Mod)

inline constexpr bool operator&(ModRefInfo x, ModRefInfo y) {
  typedef std::underlying_type<ModRefInfo>::type UnderlyingType;
  UnderlyingType X = static_cast<UnderlyingType>(x);
  UnderlyingType Y = static_cast<UnderlyingType>(y);
  return static_cast<bool>((X & Y) != 0);
}

struct PDGInstructionsBundle {
  PDG *pdg;
  Instruction *I, *J;
};

static
void addMemMayEdge(PDGInstructionsBundle Bundle,
                          DataDepType dataDepType) {
  PDG *pdg = Bundle.pdg;
  Instruction *I = Bundle.I;
  Instruction *J = Bundle.J;
  pdg->addEdge(I, J)->setMemMustType(/* mem = */ true, /* must = */ false,
                                     dataDepType);
}

static
void addEdgeFromFunctionModRef(PDG *pdg, Function &F, AAResults &AA,
                               CallInst *Call, LoadInst *Load) {

  PDGInstructionsBundle Call_Load = {pdg, Call, Load};
  PDGInstructionsBundle Load_Call = {pdg, Load, Call};
  
  ModRefInfo Res = AA.getModRefInfo(Call, MemoryLocation::get(Load));
  if (!(Res & ModRefInfo::Mod))
    return;

   /* If we're here, there's a dependence */
  addMemMayEdge(Call_Load, DataDepType::RAW);
  addMemMayEdge(Load_Call, DataDepType::WAR);

  return;
}

static
void addEdgeFromFunctionModRef(PDG *pdg, Function &F, AAResults &AA,
                              CallInst *Call, StoreInst *Store) {

  PDGInstructionsBundle Call_Store = {pdg, Call, Store};
  PDGInstructionsBundle Store_Call = {pdg, Store, Call};

  auto AddRefEdge = [&]() -> void {
    addMemMayEdge(Call_Store, DataDepType::WAR);
    addMemMayEdge(Store_Call, DataDepType::RAW);
  };

  auto AddModEdge = [&]() -> void {
    addMemMayEdge(Call_Store, DataDepType::WAW);
    addMemMayEdge(Store_Call, DataDepType::WAW);
  };
  ModRefInfo Res = AA.getModRefInfo(Call, MemoryLocation::get(Store));
  if (Res & ModRefInfo::Ref)
    AddRefEdge();
  if (Res & ModRefInfo::Mod)
    AddModEdge();

  return;
}


// TODO - IMPORTANT: This has to be rewritten!!!!!!

static
void addEdgeFromFunctionModRef(PDG *pdg, Function &F,
                               AAResults &AA, CallInst *Call,
                               CallInst *OtherCall) {
  PDGInstructionsBundle Bundle = {pdg, Call, OtherCall};
  PDGInstructionsBundle Rev_Bundle = {pdg, OtherCall, Call};

  /* 
   * Important: getModRedInfo(CallInst, CallInst) is NOT commutative.
   *            Read more about what it does here:
   *            https://llvm.org/docs/AliasAnalysis.html#the-getmodrefinfo-methods
   */

  // Take into consideration the note on the top on why intepreting
  // ModRefInfo results is tricky.

  //ModRefInfo Fwd = AA.getModRefInfo(Call, OtherCall);

  //if (Fwd == ModRefInfo::NoModRef)
  //  return;

  //if (Fwd & ModRefInfo::Ref) {
  //  addMemMayEdge(Bundle, DataDepType::WAR);
  //}

  //if (Fwd & ModRefInfo::Mod)
  //  addMemMayEdge(Bundle, DataDepType::WAW);


  //ModRefInfo Rev = AA.getModRefInfo(OtherCall, Call);

  //if (Rev == ModRefInfo::NoModRef)
  //  return;

  //// Only Ref
  //if (!(Rev & ModRefInfo::Mod)) {
  //  addMemMayEdge(Bundle, DataDepType::RAW);
  //  return;
  //}

  //if (Rev == ModRefInfo::Mod) {
  //  addMemMayEdge(Bundle, DataDepType::WAW);
  //  return;
  //}

  //if (Rev == ModRefInfo::ModRef) {
  //  addMemMayEdge(Bundle, DataDepType::RAW);
  //  addMemMayEdge(Bundle, DataDepType::WAW);
  //}

  return;
}

static 
void iterateInstForLoad(PDG *pdg, Function &F, DependenceInfo &DI,
                        AAResults &AA, LoadInst *Load) {

  // For every other instruction
  for (BasicBlock &BB : F) {
    for (Instruction &I : BB) {

      // Check stores.
      if (auto Store = dyn_cast<StoreInst>(&I)) {
        addEdgeFromDepAnalysis(pdg, DI, Store, Load);
        continue;
      }

      // Check calls.
      if (auto Call = dyn_cast<CallInst>(&I)) {
        addEdgeFromFunctionModRef(pdg, F, AA, Call, Load);
        continue;
      }
    }
  }

  return;
}

static
void iterateInstForStore(PDG *pdg, Function &F, DependenceInfo &DI,
                         AAResults &AA, StoreInst *Store) {

  // For every other instruction
  for (BasicBlock &BB : F) {
    for (Instruction &I : BB) {

      // We don't check {load, store} combinations because those were
      // checked when we iterated stores.

      // Check other stores
      if (auto OtherStore = dyn_cast<StoreInst>(&I)) {
        if (Store != OtherStore) {
          addEdgeFromDepAnalysis(pdg, DI, Store, OtherStore);
        }
        continue;
      }

      // Check calls.
      if (auto Call = dyn_cast<CallInst>(&I)) {
        addEdgeFromFunctionModRef(pdg, F, AA, Call, Store);
        continue;
      }
    }
  }

  return;
}

static
void iterateInstForCall(PDG *pdg, Function &F, AAResults &AA,
                        CallInst *Call) {

  // For every other instruction
  for (BasicBlock &BB : F) {
    for (Instruction &I : BB) {

      // We don't iterate loads and stores because {load, call} combinations
      // were considered when we iterated the loads and {store, call}
      // combinations were considered when we iterated the stores.

      // TODO: We should probably do the same for {load, store} combinations
      // to avoid calling DA twice.

      // Check other calls.
      if (auto OtherCall = dyn_cast<CallInst>(&I)) {
        if (Call != OtherCall) {
          addEdgeFromFunctionModRef(pdg, F, AA, Call, OtherCall);
        }
      }
    }
  }

  return;
}

static 
void constructEdgesFromDepAnalysisForFunction(PDG *pdg, Function &F,
                                              DependenceInfo &DI,
                                              AAResults &AA) {

  // TODO: It may be interesting to use reachability analysis as NOELLE does.

  for (auto &B : F) {
    for (auto &I : B) {
      if (auto Store = dyn_cast<StoreInst>(&I)) {
        iterateInstForStore(pdg, F, DI, AA, Store);
      } else if (auto Load = dyn_cast<LoadInst>(&I)) {
        iterateInstForLoad(pdg, F, DI, AA, Load);
      } else if (auto Call = dyn_cast<CallInst>(&I)) {
        iterateInstForCall(pdg, F, AA, Call);
      }
    }
  }
}

static
void constructEdgesFromDepAnalysis(PDG *pdg, Module &M,
                                   FunctionAnalysisManager &FAM) {

  // Use dependence analysis on stores and loads to construct PDG edges.
  for (auto &F : M) {
    if (F.empty())
      continue;
    DependenceInfo &DI = FAM.getResult<DependenceAnalysis>(F);
    AAResults &AA = FAM.getResult<AAManager>(F);
    constructEdgesFromDepAnalysisForFunction(pdg, F, DI, AA);
  }
}

static
void constructEdgesFromControlForFunction(PDG *pdg, Function &F, PostDominatorTree &PostDomTree) {
  assert(pdg != nullptr);

  /*
   * ----------- Control Dependences -----------
   *
   *                  0
   *                  |
   *                  1
   *                  |
   *                  2
   *                 / \
   *                3   4
   *                 \ /
   *                  5
   *
   * Notes:
   * 1) Dominance does not give us enough info for control dependence. For example,
   *    in the CFG above, 2 dominates 3, 4, 5 but only 3, 4 are control-dependent
   *    on it. The reason is that no matter 2's decision, we're going to visit 5.
   * 2) If Y post-dominates X, Y cannot be control-dependent on X. That is because
   *    by definition, if we reach X, we're going to visit Y no matter what.
   * 3) Maybe then, control dependence can be defined as: if Y does NOT post-dominate
   *    X, then Y is control-dependent on X. That's not necessarily true. In the CFG
   *    above, 4 does not post-dominate 0, but 4 is not control-dependent on 0. 0 can't
   *    decide whether we're going (or not) to visit 4; it is 2 that decides that.
   * 4) In general, Y is control dependent on X, if there is a path from X to Y which
   *    Y can decide if it will be taken or not. Looking again at note 3), a path in
   *    question could be 0-1-2-4. The problem arises because part of the path, let's say
   *    case 0-1, will always happen. In other words, the fact that we're always
   *    going to visit 1 from 0, means that definitely 0 does not decide if we're
   *    going to visit 4. That may mean that 1 is the one which decides but it may not.
   *    In this case, 1 doesn't decide either because applying the same reasoning, the path
   *    1-2 will always happen. Finally, 2 decides for 4 because 2 completely controls
   *    the path 2-4.
   *
   * Applying the knowledge above, Y is control-dependent on X iff there is a path from
   * X to Y and this path does NOT contain a part which "always happens". In more formal
   * terms, the path does not contain the immediate post-dominator of X.
   *
   *                  0-----              ----0
   *                  |    |             |    |
   *                  1    |             |    1
   *                  |    |             |    |
   *                  2    |             |    2            
   *                 / \   |             |   / \   
   *                3   4---             |  3   4
   *                 \ /                 |   \ /
   *                  5                  |    5
   *                                     -----|
   *
   * A couple more things to note. In the left CFG above, 4 is control-dependent on 0. 0
   * can't decide if 4 will NOT be executed but it can decide if it WILL be executed. In
   * right CFG, 4 is control-dependent on 0. In this case, 0 can't decide if 4 WILL be executed,
   * but it can decide if it will NOT be executed.
   *
   * ----------- Computing Control Dependences -----------
   *
   * Apparently, we could just apply the definition but that would be too slow. Instead, we're
   * thinking in terms of post-dominance frontiers (at this point, you might want to think of
   * dominance frontiers and how they help us place SSA PHIs):
   *
   * The post-dominance frontier of a node B is the set of nodes N such that B
   * post-dominates a successor of N but it does not strictly post-dominate N.
   * A node B is control-dependent to the nodes in its post-dominance frontier.
   *
   * In other words, the post-dominance frontier of B, similarly to a dominance frontier,
   * is the set of nodes for which B's post-dominance stops. It makes sense that B is dependent
   * on exactly these nodes because these nodes decide if they're going to take a successor
   * that B ultimately post-dominates (i.e., they indirectly decide if they're going to visit or not B).
   * Note that B is not control-dependent on any _other_ nodes, because those can't take a successor
   * that B post-dominates (otherwise, they'd be in the frontier).
   */

  for (auto &B : F) {

    SmallVector<BasicBlock *, 10> PostDominatedBBs;
    PostDomTree.getDescendants(&B, PostDominatedBBs);

    /*
     * For each basic block that B post-dominates, check if B doesn't stricly
     * post-dominate its predecessor. If it does not, then this predecessor is
     * in the post-dominance frontier of B and thus B is control-dependent on it.
     */
    for (auto PostDominatedBB : PostDominatedBBs) {
      for (auto PredBB : predecessors(PostDominatedBB)) {
        // Fetch the terminator of the predecessor.
        auto ControlTerminator = PredBB->getTerminator();

        /*
         * Check if the predecessor terminator is a conditional branch.
         * This is necessary to avoid adding incorrect control dependences
         * between basic blocks of a loop that has no exit blocks. For example:
         *
         * predBB:
         *  branch B
         *
         * B:
         *  i
         *  branch %B
         *
         * In this case, if we don't check that the terminator of predBB is a
         * conditional branch, we would add a control dependence from branch %B
         * to i
         */
        if (ControlTerminator->getNumSuccessors() == 1) {
          continue;
        }

        // Check if B strictly post-dominates predBB.
        if (PostDomTree.properlyDominates(&B, PredBB)) {
          continue;
        }

        // Add the control dependences.
        for (auto &I : B) {
          auto edge = pdg->addEdge((Value *)ControlTerminator, (Value *)&I);
          edge->setControl(true);
        }
      }
    }
  }

  auto getControlProducers = [&](Value *V) -> std::unordered_set<const Value *> {
    std::unordered_set<const Value *> controlProducers;
    auto node = pdg->fetchNode(V);
    for (auto edge : node->getIncomingEdges()) {
      if (!edge->isControlDependence())
        continue;
      auto controlProducer = edge->getOutgoingT();
      controlProducers.insert(controlProducer);
    }
    return controlProducers;
  };

  /*
   * For PHI nodes with incoming values that do not reside in their respective
   * incoming block, add control edges on the incoming block's terminator to the
   * PHI
   */

  /* 
   * PHI nodes are special in that the value that they'll produce depends on the
   * path taken
  */
  for (auto &B : F) {
    for (auto &phi : B.phis()) {

      /*
       * Locate control producers of incoming blocks to PHIs
       * where the incoming value doesn't reside in incoming block
       */
      std::unordered_set<const Value *> controlProducers;
      for (size_t Idx = 0; Idx < phi.getNumIncomingValues(); ++Idx) {
        auto incomingValue = phi.getIncomingValue(Idx);
        if (!incomingValue)
          continue;

        auto incomingInst = dyn_cast<Instruction>(incomingValue);
        auto incomingBlock = phi.getIncomingBlock(Idx);
        if (incomingInst && incomingInst->getParent() == incomingBlock)
          continue;

        auto terminator = incomingBlock->getTerminator();
        auto terminatorControlProducers = getControlProducers(terminator);
        controlProducers.insert(terminatorControlProducers.begin(),
                                terminatorControlProducers.end());
      }
      if (controlProducers.size() == 0)
        continue;

      /*
       * Determine which of these control producers do NOT have a control edge
       * to the PHI already. Add a control edge from those producers to the PHI
       */
      std::unordered_set<const Value *> currentControlProducersOnPHI =
          getControlProducers(&phi);
      for (auto producer : controlProducers) {
        if (currentControlProducersOnPHI.find(producer) !=
            currentControlProducersOnPHI.end())
          continue;

        auto edge = pdg->addEdge(producer, &phi);
        edge->setControl(true);
      }
    }
  }

  return;
}

static 
void constructEdgesFromControl(PDG *pdg, Module &M,
                               FunctionAnalysisManager &FAM) {
  assert(pdg != nullptr);

  for (auto &F : M) {
    if (F.empty()) {
      continue;
    }

    PostDominatorTree &PostDomTree =
        FAM.getResult<PostDominatorTreeAnalysis>(F);

    /*
     * Compute the control dependences of the function based on its
     * post-dominator tree.
     */
    constructEdgesFromControlForFunction(pdg, F, PostDomTree);
  }

  return;
}

/*
 * Construct PDG from IR. TODO: We need to worry about caching functions at some point.
 * That is, if I change a function, this analysis will be invalidated and we have to run
 * it all over again, although we may not need to change anything.
 */

PDGAnalysisResult PDGAnalysis::run(Module &M, ModuleAnalysisManager &MAM) {
  PDG *pdg = new PDG(M);

  FunctionAnalysisManager &FAM =
      MAM.getResult<FunctionAnalysisManagerModuleProxy>(M).getManager();

  constructEdgesFromUseDefs(pdg);
  constructEdgesFromDepAnalysis(pdg, M, FAM);
  constructEdgesFromControl(pdg, M, FAM);

  return PDGAnalysisResult(pdg);
}

/*
 * Printer Passes
 */

PreservedAnalyses PDGDotPrinter::run(Module &M, ModuleAnalysisManager &MAM) {
  PDG *pdg = MAM.getResult<PDGAnalysis>(M).getPDG();

  PDGPrinter *pdgPrinter = new PDGPrinter();
  llvm::CallGraph &callGraph = MAM.getResult<CallGraphAnalysis>(M);
  FunctionAnalysisManager &FAM =
      MAM.getResult<FunctionAnalysisManagerModuleProxy>(M).getManager();
  auto getLoopInfo = [&FAM](Function *F) -> LoopInfo & {
    LoopInfo &LI = FAM.getResult<LoopAnalysis>(*F);
    return LI;
  };
  pdgPrinter->printPDG(M, callGraph, pdg, getLoopInfo);

  /*
  *
  * THIS IS AN IMPORTANT PROBLEM. WE CAN'T FREE pdg HERE BECAUSE
  * IF THE ANALYSIS RESULT (FROM PDGAnalysis) IS CACHED (WHICH e.g., HAPPENS
  * IF YOU RUN dot-pdg,print<pdg> BECAUSE THE FIRST RETURNS PreservedAnalysis.all()),
  * OTHER PLACES CALLING THE ANALYSIS WILL GET AN INVALID POINTER.
  *
  */

  //delete pdg;
  return PreservedAnalyses::all();
}

PreservedAnalyses PDGTextPrinter::run(Module &M, ModuleAnalysisManager &MAM) {
  PDG *pdg = MAM.getResult<PDGAnalysis>(M).getPDG();

  for (DGEdge<Value> *Edge : pdg->getEdges()) {
    os << *Edge << "\n";
  }
  
  ///delete pdg;
  return PreservedAnalyses::all();
}