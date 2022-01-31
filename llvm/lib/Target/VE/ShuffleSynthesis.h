//===----------- ShuffleSynthesis.h - Shuffle CodeGen --------*- C++-*-===//
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

#include "VECustomDAG.h"
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

/// Broadcast, Shuffle, Mask Analysis {

// matches mask elements
struct MaskShuffleAnalysis {
  // Extract bits form the source register part \p SrcPart of \p SrcMask, select
  // the bits \p SrcSelMask and shift them by \p ShiftAmount.
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

  // Bit-reverse the source part and insert it.
  struct BitReverse {
    SDValue SrcVal;
    unsigned SrcValPart;

    BitReverse() : SrcVal(), SrcValPart(0) {}

    bool isValid() const { return (bool) SrcVal; }

    raw_ostream &print(raw_ostream &Out) const {
      Out << "BitReverse (from:";
      if (SrcVal)
        SrcVal->print(Out);
      else
        Out << "<none>";
      Out << ", sxpart:" << SrcValPart << ")";
      return Out;
    }
  };

  struct ResPart {
    unsigned ResPartIdx;
    // If valid, this alone defines the result bits of this part by reversing a
    // source chunk.
    BitReverse BitReversal;
    // Otw, this is a list of blend-able mask & shift operations from source
    // chunks.
    std::vector<BitSelect> Selects;

    ResPart(unsigned PartIdx) : ResPartIdx(PartIdx), Selects() {}
    raw_ostream &print(raw_ostream &Out) const {
      Out << "ResPart:" << ResPartIdx;
      if (BitReversal.isValid()) {
        BitReversal.print(Out);
        return Out;
      }
      Out << ", Selects: {\n";
      for (auto &BitSel : Selects) {
        Out << "\t";
        BitSel.print(Out) << "\n";
      }
      Out << "}\n";
      return Out;
    }

    bool empty() const {
      return !BitReversal.isValid() && Selects.empty();
    }
  };

  // Constant inserts
  LaneBits IsConstantOne;
  LaneBits UndefBits;

  // Analysis result
  std::vector<ResPart> Segments;

  MaskView &MV;

  // match a 64 bit segment, mapping out all source bits
  // FIXME this implies knowledge about the underlying object structure
  MaskShuffleAnalysis(MaskView& MV, VECustomDAG &CDAG);

  // Synthesize \p BitSelect, merging the result into \p Passthru
  SDValue synthesize(SDValue Passthru, BitSelect &BSel, SDValue SXV,
                     VECustomDAG &CDAG) const;

  // Check whether the constant background of the result consists only of `1` bits (or undef)
  bool analyzeVectorSources(bool & AllTrue) const;

  // materialize the code to synthesize this operation
  SDValue synthesize(VECustomDAG &CDAG, EVT LegalMaskVT);
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
#if 0
  PartialShuffleState(const PartialShuffleState &O)
      : MissingLanes(O.MissingLanes) {}
#endif

  void setMissing(unsigned i) { MissingLanes[i] = true; }
  void unsetMissing(unsigned i) { MissingLanes[i] = false; }
  bool isMissing(unsigned i) const { return MissingLanes[i]; }

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

  virtual SDValue synthesize(MaskView &MV, VECustomDAG &CDAG,
                             SDValue PartialV) = 0;
  virtual void print(raw_ostream &out) const = 0;
};

// An shuffle heuristics that reports back partial progress through a callback
using PartialShuffleCB =
    std::function<void(AbstractShuffleOp *, PartialShuffleState)>;

struct ShuffleStrategy {
  // Whether this strategy is applicable to non-packed shuffles
  static bool supportsNormalMode() { return false; }
  // Whether this strategy is applicable to packed shuffles
  static bool supportsPackedMode() { return false; }

  virtual ~ShuffleStrategy() {}

  // apply the shuffle strategy, reporting all partial shuffles that were
  // found
  virtual void planPartialShuffle(MaskView &MV, PartialShuffleState FromState,
                                  PartialShuffleCB CB) = 0;
};

// lower a shuffle mask to actual operations
class ShuffleAnalysis {
  // TODO Expand,Compress

  // Analysis result -> the final shuffle sequence
  std::vector<std::unique_ptr<AbstractShuffleOp>> ShuffleSeq;

  // apply a fixed strategy for a given number of rounds
  IterControl runStrategy(ShuffleStrategy &Strat, unsigned NumRounds,
                          MaskView &MV, PartialShuffleState &PSS);

  template<typename Strategy>
  IterControl run(unsigned NumRounds, MaskView & MV, PartialShuffleState &PSS) {
    bool IsPackedMask = (MV.getNumElements() > StandardVectorWidth);
    bool StratSupportsMask = IsPackedMask ? Strategy::supportsPackedMode()
                                          : Strategy::supportsNormalMode();
    if (!StratSupportsMask)
      return IterControl::IterContinue;

    Strategy Strat;
    return runStrategy(Strat, NumRounds, MV, PSS);
  }

  MaskView &MV;

public:
  // Construct this in
  ShuffleAnalysis(MaskView &MV) : MV(MV) {}

  /// Tries to plan a code sequence that synthesizes the mask view passed into this instance
  enum AnalyzeResult {
    Failure = 0,
    CanSynthesize = 1,
  };
  AnalyzeResult analyze();

  // print the sketched synthesisi stages requires to build this mask view
  raw_ostream &print(raw_ostream &out) const;

  /// Synthesize the code planned in the analyze stage
  SDValue synthesize(VECustomDAG &CDAG, EVT LegalResultVT);
};

} // namespace llvm

#endif // LLVM_LIB_TARGET_VE_SHUFFLESYNTHESIS_H
