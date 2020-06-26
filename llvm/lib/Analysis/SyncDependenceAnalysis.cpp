//===--- SyncDependenceAnalysis.cpp - Compute Control Divergence Effects --===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements an algorithm that returns for a divergent branch
// the set of basic blocks whose phi nodes become divergent due to divergent
// control. These are the blocks that are reachable by two disjoint paths from
// the branch or loop exits that have a reaching path that is disjoint from a
// path to the loop latch.
//
// The SyncDependenceAnalysis is used in the DivergenceAnalysis to model
// control-induced divergence in phi nodes.
//
// -- Summary --
// The SyncDependenceAnalysis lazily computes sync dependences [3].
// The analysis evaluates the disjoint path criterion [2] by a reduction
// to SSA construction. The SSA construction algorithm is implemented as
// a simple data-flow analysis [1].
//
// [1] "A Simple, Fast Dominance Algorithm", SPI '01, Cooper, Harvey and Kennedy
// [2] "Efficiently Computing Static Single Assignment Form
//     and the Control Dependence Graph", TOPLAS '91,
//           Cytron, Ferrante, Rosen, Wegman and Zadeck
// [3] "Improving Performance of OpenCL on CPUs", CC '12, Karrenberg and Hack
// [4] "Divergence Analysis", TOPLAS '13, Sampaio, Souza, Collange and Pereira
//
// -- Sync dependence --
// Sync dependence [4] characterizes the control flow aspect of the
// propagation of branch divergence. For example,
//
//   %cond = icmp slt i32 %tid, 10
//   br i1 %cond, label %then, label %else
// then:
//   br label %merge
// else:
//   br label %merge
// merge:
//   %a = phi i32 [ 0, %then ], [ 1, %else ]
//
// Suppose %tid holds the thread ID. Although %a is not data dependent on %tid
// because %tid is not on its use-def chains, %a is sync dependent on %tid
// because the branch "br i1 %cond" depends on %tid and affects which value %a
// is assigned to.
//
// -- Reduction to SSA construction --
// There are two disjoint paths from A to X, if a certain variant of SSA
// construction places a phi node in X under the following set-up scheme [2].
//
// This variant of SSA construction ignores incoming undef values.
// That is paths from the entry without a definition do not result in
// phi nodes.
//
//       entry
//     /      \
//    A        \
//  /   \       Y
// B     C     /
//  \   /  \  /
//    D     E
//     \   /
//       F
// Assume that A contains a divergent branch. We are interested
// in the set of all blocks where each block is reachable from A
// via two disjoint paths. This would be the set {D, F} in this
// case.
// To generally reduce this query to SSA construction we introduce
// a virtual variable x and assign to x different values in each
// successor block of A.
//           entry
//         /      \
//        A        \
//      /   \       Y
// x = 0   x = 1   /
//      \  /   \  /
//        D     E
//         \   /
//           F
// Our flavor of SSA construction for x will construct the following
//            entry
//          /      \
//         A        \
//       /   \       Y
// x0 = 0   x1 = 1  /
//       \   /   \ /
//      x2=phi    E
//         \     /
//          x3=phi
// The blocks D and F contain phi nodes and are thus each reachable
// by two disjoins paths from A.
//
// -- Remarks --
// In case of loop exits we need to check the disjoint path criterion for loops
// [2]. To this end, we check whether the definition of x differs between the
// loop exit and the loop header (_after_ SSA construction).
//
//===----------------------------------------------------------------------===//
#include "llvm/Analysis/SyncDependenceAnalysis.h"
#include "llvm/ADT/PostOrderIterator.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/Analysis/PostDominators.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Function.h"

#include <functional>
#include <stack>
#include <unordered_set>

#define DEBUG_TYPE "sync-dependence"

// Custom RPO framework
namespace {
using namespace llvm;

using RPOCB = std::function<void(const BasicBlock &)>;
using VisitedSet = std::set<const BasicBlock *>;
using BlockStack = std::vector<const BasicBlock *>;

// forward
static void ComputeLoopPO(const LoopInfo &LI, Loop &Loop, RPOCB CallBack,
                          VisitedSet &Finalized);

// for a nested region (top-level loop or nested loop)
static void ComputeStackPO(BlockStack &Stack, const LoopInfo &LI,
                           const BasicBlock *LoopHead, Loop *Loop,
                           RPOCB CallBack, VisitedSet &Finalized) {
  while (!Stack.empty()) {
    const auto *NextBB = Stack.back();

    auto *NestedLoop = LI.getLoopFor(NextBB);
    bool IsNestedLoop = NestedLoop != Loop;

    // Treat the loop as a node
    if (IsNestedLoop) {
      SmallVector<BasicBlock *, 3> NestedExits;
      NestedLoop->getUniqueExitBlocks(NestedExits);
      bool PushedNodes = false;
      for (const auto *NestedExitBB : NestedExits) {
        if (NestedExitBB == LoopHead)
          continue;
        if (Loop && !Loop->contains(NestedExitBB))
          continue;
        if (Finalized.count(NestedExitBB))
          continue;
        PushedNodes = true;
        Stack.push_back(NestedExitBB);
      }
      if (!PushedNodes) {
        // All loop exits finalized -> finish this node
        Stack.pop_back();
        ComputeLoopPO(LI, *NestedLoop, CallBack, Finalized);
      }
      continue;
    }

    // DAG-style
    bool PushedNodes = false;
    for (const auto *SuccBB : successors(NextBB)) {
      if (SuccBB == LoopHead)
        continue;
      if (Loop && !Loop->contains(SuccBB))
        continue;
      if (Finalized.count(SuccBB))
        continue;
      PushedNodes = true;
      Stack.push_back(SuccBB);
    }
    if (!PushedNodes) {
      // Never push nodes twice
      Stack.pop_back();
      if (!Finalized.insert(NextBB).second)
        continue;
      CallBack(*NextBB);
    }
  }
}

static void ComputeTopLevelPO(Function &F, const LoopInfo &LI, RPOCB CallBack) {
  VisitedSet Finalized;
  BlockStack Stack;
  Stack.reserve(24); // FIXME magic number
  Stack.push_back(&F.getEntryBlock());
  ComputeStackPO(Stack, LI, nullptr, nullptr, CallBack, Finalized);
}

static void ComputeLoopPO(const LoopInfo &LI, Loop &Loop, RPOCB CallBack,
                          VisitedSet &Finalized) {
  /// \brief Call CallBack on all loop blocks in the modified CFG
  std::vector<const BasicBlock *> Stack;
  const auto *LoopHead = Loop.getHeader();

  // Visit the header last
  Finalized.insert(LoopHead);
  CallBack(*LoopHead);

  // Initialize with immediate successors
  for (const auto *BB : successors(LoopHead)) {
    if (!Loop.contains(BB))
      continue;
    if (BB == LoopHead)
      continue;
    Stack.push_back(BB);
  }

  // Compute PO inside region
  ComputeStackPO(Stack, LI, LoopHead, &Loop, CallBack, Finalized);
}

} // namespace

namespace llvm {

ControlDivergenceDesc SyncDependenceAnalysis::EmptyDivergenceDesc;

SyncDependenceAnalysis::SyncDependenceAnalysis(const DominatorTree &DT,
                                               const PostDominatorTree &PDT,
                                               const LoopInfo &LI)
    : LoopRPO(), DT(DT), PDT(PDT), LI(LI) {
  ComputeTopLevelPO(*DT.getRoot()->getParent(), LI, [&](const BasicBlock &BB) {
    // errs() << BB.getName() << "\n";
    LoopRPO.appendBlock(BB);
  });
}

SyncDependenceAnalysis::~SyncDependenceAnalysis() {}

using FunctionRPOT = ReversePostOrderTraversal<const Function *>;

// divergence propagator for reducible CFGs
struct DivergencePropagator {
  const ModifiedRPO &LoopRPOT;
  const DominatorTree &DT;
  const PostDominatorTree &PDT;
  const LoopInfo &LI;
  const BasicBlock &DivTermBlock;

  // if BlockLabels[IndexOf(B)] == C then C is the dominating definition at
  // block B if BlockLabels[IndexOf(B)] ~ undef then we haven't seen B yet if
  // BlockLabels[IndexOf(B)] == B then B is a join point of disjoint paths from
  // X or B is an immediate successor of X (initial value).
  using BlockLabelVec = std::vector<const BasicBlock *>;
  BlockLabelVec BlockLabels;
  // divergent join and loop exit descriptor.
  std::unique_ptr<ControlDivergenceDesc> DivDesc;

  // reached loop exits (by a path disjoint to a path to the loop header)
  // SmallPtrSet<const BasicBlock *, 4> ReachedLoopExits;

  // all blocks with pending visits
  // std::unordered_set<const BasicBlock *> PendingUpdates;

  DivergencePropagator(const ModifiedRPO &LoopRPOT, const DominatorTree &DT,
                       const PostDominatorTree &PDT, const LoopInfo &LI,
                       const BasicBlock &DivTermBlock)
      : LoopRPOT(LoopRPOT), DT(DT), PDT(PDT), LI(LI),
        DivTermBlock(DivTermBlock), BlockLabels(LoopRPOT.size(), nullptr),
        DivDesc(new ControlDivergenceDesc) {}

  void printDefs(raw_ostream &Out) {
    Out << "Propagator::BlockLabels {\n";
    for (int i = (int)BlockLabels.size() - 1; i > 0; --i) {
      const auto *Label = BlockLabels[i];
      Out << LoopRPOT.getBlockAt(i)->getName().str() << "(" <<  i << ") : ";
      if (!Label) {
        Out << "<null>\n";
      } else {
        Out << Label->getName() << "\n";
      }
    }
    Out << "}\n";
  }

  // Push a definition (\p DefBlock) to \p SuccBlock and return whether this
  // raises the definition to '\top'
  // Updates MaxNextBlock to the highest block index that needs to be visited
  // (assuming MaxNextBlock already points to an interesting block)
  bool computeJoin(const BasicBlock &SuccBlock, const BasicBlock &PushedLabel) {
    auto SuccIdx = LoopRPOT.getIndexOf(SuccBlock);

    // unset or same reaching label
    const auto *OldLabel = BlockLabels[SuccIdx];
    if (!OldLabel || (OldLabel == &PushedLabel)) {
      BlockLabels[SuccIdx] = &PushedLabel;
      return false;
    }

    // Update the definition
    BlockLabels[SuccIdx] = &SuccBlock;
    return true;
  }

  // visiting a virtual loop exit edge from the loop header --> temporal
  // divergence on join
  void visitLoopExitEdge(const BasicBlock &ExitBlock,
                         const BasicBlock &DefBlock, bool FromParentLoop) {
    // Pushing from a non-parent loop cannot cause temporal divergence.
    if (!FromParentLoop)
      return visitEdge(ExitBlock, DefBlock);

    if (!computeJoin(ExitBlock, DefBlock))
      return;

    // Identified a divergent loop exit
    DivDesc->LoopDivBlocks.insert(&ExitBlock);
    LLVM_DEBUG(dbgs() << "\tDivergent loop exit: " << ExitBlock.getName() << "\n");
    return;
  }

  // process \p succBlock with reaching definition @defBlock
  // the original divergent branch was in @parentLoop (if any)
  void visitEdge(const BasicBlock &SuccBlock, const BasicBlock &DefBlock) {
    if (!computeJoin(SuccBlock, DefBlock))
      return;

    // Divergent, disjoint paths join.
    DivDesc->JoinDivBlocks.insert(&SuccBlock);
    LLVM_DEBUG(dbgs() << "\tDivergent join: " << SuccBlock.getName());
  }

  std::unique_ptr<ControlDivergenceDesc> computeJoinPoints() {
    assert(DivDesc);

    LLVM_DEBUG(dbgs() << "SDA:computeJoinPoints: " << DivTermBlock.getName()
                      << "\n");

    const auto *DivBlockLoop = LI.getLoopFor(&DivTermBlock);

    // bootstrap with branch targets
    int BlockIdx = 0;
    for (const auto *SuccBlock : successors(&DivTermBlock)) {
      auto SuccIdx = LoopRPOT.getIndexOf(*SuccBlock);
      BlockLabels[SuccIdx] = SuccBlock;

      // Find the successor with the highest index to start with
      BlockIdx = std::max<int>(BlockIdx, LoopRPOT.getIndexOf(*SuccBlock));

      // Identify immediate divergent loop exits
      if (!DivBlockLoop)
        continue;

      const auto *BlockLoop = LI.getLoopFor(SuccBlock);
      if (BlockLoop && DivBlockLoop->contains(BlockLoop))
        continue;
      DivDesc->LoopDivBlocks.insert(SuccBlock);
      LLVM_DEBUG(dbgs() << "\tImmediate divergent loop exit: "
                        << SuccBlock->getName() << "\n");
    }

    // propagate definitions at the immediate successors of the node in RPO
    for (; BlockIdx >= 0; --BlockIdx) {
      LLVM_DEBUG(dbgs() << "Before next visit:\n"; printDefs(dbgs()));

      // Any label available here
      const auto *Label = BlockLabels[BlockIdx];
      if (!Label)
        continue;

      // Ok. Get the block
      const auto *Block = LoopRPOT.getBlockAt(BlockIdx);
      LLVM_DEBUG(dbgs() << "SDA::joins. visiting " << Block->getName() << "\n");

      auto *BlockLoop = LI.getLoopFor(Block);
      bool IsLoopHeader = BlockLoop && BlockLoop->getHeader() == Block;
      if (IsLoopHeader) {
        // Disconnect from immediate successors and propagate directly to loop
        // exits.
        SmallVector<BasicBlock *, 4> BlockLoopExits;
        BlockLoop->getExitBlocks(BlockLoopExits);

        bool IsParentLoop = BlockLoop->contains(&DivTermBlock);
        for (const auto *BlockLoopExit : BlockLoopExits) {
          visitLoopExitEdge(*BlockLoopExit, *Label, IsParentLoop);
        }
        continue;
      }

      // Acyclic successor case
      for (const auto *SuccBlock : successors(Block)) {
        visitEdge(*SuccBlock, *Label);
      }
    }

    LLVM_DEBUG(dbgs() << "SDA::joins. After propagation:\n"; printDefs(dbgs()));

    return std::move(DivDesc);
  }
};

static void PrintBlockSet(ConstBlockSet &Blocks, raw_ostream &Out) {
  Out << "[";
  bool First = true;
  for (const auto *BB : Blocks) {
    if (!First)
      Out << ", ";
    First = false;
    Out << BB->getName();
  }
  Out << "]";
}

const ControlDivergenceDesc &
SyncDependenceAnalysis::join_blocks(const Instruction &Term) {
  // trivial case
  if (Term.getNumSuccessors() <= 1) {
    return EmptyDivergenceDesc;
  }

  // already available in cache?
  auto ItCached = CachedControlDivDescs.find(&Term);
  if (ItCached != CachedControlDivDescs.end())
    return *ItCached->second;

  // compute all join points
  // Special handling of divergent loop exits is not needed for LCSSA
  const auto &TermBlock = *Term.getParent();
  DivergencePropagator Propagator(LoopRPO, DT, PDT, LI, TermBlock);
  auto DivDesc = Propagator.computeJoinPoints();

  LLVM_DEBUG(dbgs() << "Result (" << Term.getParent()->getName() << "):\n";
             dbgs() << "JoinDivBlocks: ";
             PrintBlockSet(DivDesc->JoinDivBlocks, dbgs());
             dbgs() << "\nLoopDivBlocks: ";
             PrintBlockSet(DivDesc->LoopDivBlocks, dbgs()); dbgs() << "\n";);

  auto ItInserted = CachedControlDivDescs.emplace(&Term, std::move(DivDesc));
  assert(ItInserted.second);
  return *ItInserted.first->second;
}

} // namespace llvm
