//===---- ShuffleSynthesis.h - Analysis & Codegen for shuffles ----*-
// C++-*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Analysis and code generation for shuffles masks in the VE target
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_VE_SHUFFLESYNTHESIS_H
#define LLVM_LIB_TARGET_VE_SHUFFLESYNTHESIS_H

#include "CustomDAG.h"
#include "MaskView.h"
#include "VE.h"
#include "llvm/CodeGen/SelectionDAGNodes.h"
#include "llvm/CodeGen/TargetLowering.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/Format.h"
#include "llvm/Support/raw_ostream.h"

#ifndef DEBUG_TYPE
#define DEBUG_TYPE "shuffleanalysis"
#endif

namespace llvm {

// matches mask elements
struct MaskShuffleAnalysis {
  // extract bits form the source register part \p SrcPart of \p SrcMask, select
  // the bits \p SrcSelMask and shift them by \p ShiftAmount
  struct BitSelect {
    SDValue SrcVal;
    unsigned SrcValPart; // sx sub-register index of \p SrcVal

    uint64_t SrcSelMask; // active bit mask to select from this source
    int ShiftAmount;     // shift amount (offset from dest bit index)
    BitSelect() : SrcVal(), SrcValPart(0), SrcSelMask(0), ShiftAmount(0) {}

    raw_ostream &print(raw_ostream &Out) const {
      Out << "BitSel (from:";
      if (SrcVal)
        SrcVal->print(Out);
      else
        Out << "<none>";
      Out << ", sxpart:" << SrcValPart
          << ", mask:" << format_hex(SrcSelMask, 16) << ",shift:" << ShiftAmount
          << ")";
      return Out;
    }
  };

  struct ResPart {
    unsigned ResPartIdx;
    std::vector<BitSelect> Selects;

    ResPart(unsigned PartIdx) : ResPartIdx(PartIdx), Selects() {}
    raw_ostream &print(raw_ostream &Out) const {
      Out << "ResPart:" << ResPartIdx << ", Selects: {\n";
      for (auto &BitSel : Selects) {
        Out << "\t";
        BitSel.print(Out) << "\n";
      }
      Out << "}\n";
      return Out;
    }
  };

  // Analysis result
  std::vector<ResPart> Segments;

  // match a 64 bit segment, mapping out all source bits
  // FIXME this implies knowledge about the underlying object structure
  MaskShuffleAnalysis(MaskView *Mask, unsigned NumEls);

  // Synthesize \p BitSelect, merging the result into \p Passthru
  SDValue synthesize(SDValue Passthru, BitSelect &BSel, SDValue SXV,
                     CustomDAG &CDAG) const;

  // materialize the code to synthesize this operation
  SDValue synthesize(CustomDAG &CDAG);
};

enum IterControl {
  IterContinue = 0,
  IterBreak = 1,
};

inline void where_true(const LaneBits Bits,
                       std::function<IterControl(unsigned Idx)> LoopBody) {
  auto Len = Bits.size();
  for (size_t i = 0; i < Len; ++i) {
    if (!Bits[i])
      continue;
    if (LoopBody(i) == IterBreak)
      break;
  }
}

///// ShuffleAnalysis & Shuffle Strategies

// represents a partially shuffled up state
struct PartialShuffleState {
  LaneBits MissingLanes;

  PartialShuffleState() { MissingLanes.reset(); }

  void setMissing(unsigned i) { MissingLanes[i] = true; }

  static PartialShuffleState fromInitialMask(MaskView &MV) {
    PartialShuffleState PSS;

    for (unsigned i = 0; i < MV.getNumElements(); ++i) {
      auto ES = MV.getSourceElem(i);
      if (ES.isDefined())
        PSS.setMissing(i);
    }

    return PSS;
  }

  bool isComplete() const { return !MissingLanes.any(); }

  void for_missing(std::function<IterControl(unsigned Idx)> LoopBody) {
    where_true(MissingLanes, LoopBody);
  }
};

// an abstract shuffle operation produced bu a shuffle strategy
struct AbstractShuffleOp {
  virtual ~AbstractShuffleOp() {}

  virtual SDValue synthesize(MaskView &MV, CustomDAG &CDAG,
                             SDValue PartialV) = 0;
  virtual void print(raw_ostream &out) const = 0;
};

// An shuffle heuristics that reports back partial progress through a callback
using PartialShuffleCB =
    std::function<void(AbstractShuffleOp *, PartialShuffleState)>;

struct ShuffleStrategy {
  virtual ~ShuffleStrategy() {}

  // apply the shuffle strategy, reporting all partial shuffles that were
  // found
  virtual void planPartialShuffle(MaskView &MV, PartialShuffleState FromState,
                                  PartialShuffleCB CB) = 0;
};

// lower a shuffle mask to actual operations
struct ShuffleAnalysis {
  // TODO VMV chaining...
  // TODO Expand,Compress

  // Analysis result -> the final shuffle sequence
  std::vector<std::unique_ptr<AbstractShuffleOp>> ShuffleSeq;

  // match a 64 bit segment, mapping out all source bits
  // FIXME this implies knowledge about the underlying object structure
  ShuffleAnalysis(MaskView &Mask);

  SDValue synthesize(MaskView &Mask, CustomDAG &CDAG, EVT LegalResultVT);
};

} // namespace llvm

#endif // LLVM_LIB_TARGET_VE_SHUFFLESYNTHESIS_H
