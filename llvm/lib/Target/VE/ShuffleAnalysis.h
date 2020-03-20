//===---- ShuffleAnalysis.h - Analysis & Codegen for shuffles ----*- C++-*-===//
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

#ifndef LLVM_LIB_TARGET_VE_SHUFFLEANALYSIS_H
#define LLVM_LIB_TARGET_VE_SHUFFLEANALYSIS_H

#include "VE.h"
#include "llvm/CodeGen/SelectionDAGNodes.h"
#include "llvm/CodeGen/TargetLowering.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Format.h"
#include "CustomDAG.h"
#include "MaskView.h"

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
    int ShiftAmount; // shift amount (offset from dest bit index)
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
  MaskShuffleAnalysis(MaskView *Mask, unsigned NumEls) {
    const unsigned SXRegSize = 64;

    // loop over all sub-registers (sx parts of v256)
    for (unsigned PartIdx = 0; PartIdx * SXRegSize < NumEls; ++PartIdx) {
      const unsigned DestPartBase = PartIdx * SXRegSize;
      std::vector<bool> DefinedBits(SXRegSize, false);
      const unsigned NumPartBits =
          std::min(SXRegSize, NumEls - DestPartBase);

      unsigned NumMissingBits = NumPartBits; // keeps track of matcher rouds

      // described all
      ResPart Part(PartIdx);

      while (NumMissingBits > 0) {
        BitSelect Sel;
        for (unsigned i = 0; i < NumPartBits; ++i) {
          if (DefinedBits[i])
            continue;
          ElemSelect ES = Mask->getSourceElem(i + DestPartBase);
          // skip both kinds of undef (no value transfered or source is undef)
          if (!ES.isDefined()) {
            DefinedBits[i] = true;
            NumMissingBits--;
            continue;
          }

          assert(ES.isElemTransfer() && "TODO implement shuffle-in of scalars");

          // map a new source (and a shift amount)
          unsigned SrcPartIdx =
              (ES.ExtractIdx / SXRegSize); // sx sub-register to chose from
          // required shift amount of the elements of the sub register
          int64_t ShiftAmount = (ES.ExtractIdx % SXRegSize) - i;
          if (!Sel.SrcVal) {
            Sel.SrcVal = ES.V;
            Sel.SrcValPart = SrcPartIdx;
            Sel.ShiftAmount = ShiftAmount;
            Sel.SrcSelMask |= 1 << ES.ExtractIdx;
            DefinedBits[i] = true;
            NumMissingBits--;
            continue;
          }

          // Copy all bits with similar alignment
          if ((Sel.SrcVal == ES.V && Sel.SrcValPart == SrcPartIdx) &&
              Sel.ShiftAmount == ShiftAmount) {
            Sel.SrcSelMask |= 1 << ES.ExtractIdx;
            DefinedBits[i] = true;
            NumMissingBits--;
            continue;
          }

          // misaligned bit // TODO start from here next round
        }
        if (Sel.SrcVal) {
          Part.Selects.push_back(Sel);
        }
      }

      LLVM_DEBUG( Part.print(dbgs()); );
      Segments.push_back(Part);
    }
  }

  SDValue synthesize(SDValue Passthru, BitSelect &BSel, SDValue SXV,
                     CustomDAG &CDAG) const {
    const uint64_t AllSetMask = (uint64_t)-1;

    // match full register copies
    if ((BSel.SrcSelMask == AllSetMask) && (BSel.ShiftAmount == 0)) {
      return SXV;
    }

    // AND active lanes
    SDValue MaskedV = SXV;
    if (BSel.SrcSelMask != AllSetMask) {
      MaskedV = CDAG.DAG.getNode(
          ISD::AND, CDAG.DL, SXV.getValueType(),
          {MaskedV, CDAG.getConstant(BSel.SrcSelMask, MVT::i64)});
    }

    // shift (trivial 0 case handled internally)
    SDValue ShiftV =
        CDAG.createElementShift(MaskedV.getValueType(), MaskedV, BSel.ShiftAmount, SDValue());

    // OR-in passthru
    SDValue ResV = ShiftV;
    if (Passthru) {
      ResV = CDAG.DAG.getNode(ISD::OR, CDAG.DL, SXV.getValueType(),
                              {ShiftV, Passthru});
    }

    return ResV;
  }

  // materialize the code to synthesize this operation
  SDValue synthesize(CustomDAG& CDAG) {
    std::map<std::pair<SDValue, unsigned>, SDValue> SourceParts;

    // Extract all source parts
    for (auto & ResPart : Segments) {
      for (auto & BitSel : ResPart.Selects) {
        auto Key = std::pair<SDValue, unsigned>(BitSel.SrcVal, BitSel.SrcValPart);
        if (SourceParts.find(Key) != SourceParts.end()) continue;

        SDValue PartIdxC = CDAG.getConstant(Key.second, MVT::i64);
        auto SXPart = CDAG.createMaskExtract(Key.first, PartIdxC);
        SourceParts[Key] = SXPart;
      }
    }

    // Work through selects, blending and shifting the parts together
    SDValue VMAccu = CDAG.DAG.getUNDEF(MVT::v256i1);

    for (auto & ResPart : Segments) {
      SDValue SXAccu = CDAG.DAG.getUNDEF(MVT::i64);
      // synthesize all operations that feed into this destionation sx part
      for (auto & BitSel : ResPart.Selects) {
        auto ItExtractedSrc = SourceParts.find(
            std::pair<SDValue, unsigned>(BitSel.SrcVal, BitSel.SrcValPart));
        assert(ItExtractedSrc != SourceParts.end());
        SXAccu = synthesize(SXAccu, BitSel, ItExtractedSrc->second, CDAG);
      }

      // finally, insert the SX part into the the actual VM
      VMAccu = CDAG.createMaskInsert(
          VMAccu, CDAG.getConstant(ResPart.ResPartIdx, MVT::i64), SXAccu);
    }

    return VMAccu;
  }
};

using LaneBits = std::bitset<256>;

enum IterControl {
  IterContinue = 0,
  IterBreak = 1,
};

void where_true(const LaneBits Bits, std::function<IterControl(unsigned Idx)> LoopBody) {
  auto Len = Bits.size();
  for (size_t i = 0; i < Len; ++i) {
    if (!Bits[i])
      continue;
    if (LoopBody(i) == IterBreak)
      break;
  }
}

// lower a shuffle mask to actual operations
struct ShuffleAnalysis {

  // represents a partially shuffled up state
  struct PartialShuffleState {
    LaneBits MissingLanes;
    
    PartialShuffleState() {
      MissingLanes.reset();
    }
    
    void setMissing(unsigned i) {
      MissingLanes[i] = true;
    }

    static PartialShuffleState fromInitialMask(MaskView &MV) {
      PartialShuffleState PSS;

      for (unsigned i = 0; i < MV.getNumElements(); ++i) {
        auto ES = MV.getSourceElem(i);
        if (ES.isDefined())
          PSS.setMissing(i);
      }

      return PSS;
    }

    bool isComplete() const {
      return !MissingLanes.any();
    }

    void for_missing(std::function<IterControl(unsigned Idx)> LoopBody) {
      where_true(MissingLanes, LoopBody);
    }
  };

  // an abstract shuffle operation produced bu a shuffle strategy
  struct AbstractShuffleOp {
    virtual SDValue synthesize(MaskView &MV, CustomDAG &CDAG,
                               SDValue PartialV) = 0;
    virtual void print(raw_ostream &out) const = 0;
  };

  // An shuffle heuristics that reports back partial progress through a callback
  using PartialShuffleCB = std::function<void(AbstractShuffleOp *, PartialShuffleState)>;
  struct ShuffleStrategy {
    // apply the shuffle strategy, reporting all partial shuffles that were
    // found
    virtual void planPartialShuffle(MaskView& MV, PartialShuffleState FromState, PartialShuffleCB CB) = 0;
  };

  // Scalar transfer strategy
  // extract all vector elements and insert them back at the right positions
  struct ScalarTransferOp final : public AbstractShuffleOp {
    LaneBits InsertPositions;

    ScalarTransferOp(LaneBits DefinedLanes) : InsertPositions(DefinedLanes) {}
    virtual ~ScalarTransferOp() {}

    // transfer all insert positions to their destination
    virtual SDValue synthesize(MaskView &MV, CustomDAG &CDAG,
                               SDValue PartialV) {
      SDValue AccuV = PartialV;

      // TODO caching of extracted element..
      where_true(InsertPositions, [&](unsigned Idx) {
          auto ES = MV.getSourceElem(Idx);
          if (!ES.isDefined())
            return IterContinue;

          // isolate the scalar element
          SDValue SrcElemV;
          if (ES.isElemTransfer()) {
            SrcElemV = CDAG.getVectorExtract(ES.V, CDAG.getConstant(ES.getElemIdx(), MVT::i64));
          } else {
            assert(ES.isElemInsert());
            SrcElemV = ES.V;
          }

          // insert it
          AccuV = CDAG.getVectorInsert(AccuV, SrcElemV, CDAG.getConstant(Idx, MVT::i64));
          
          return IterContinue;
      });
      return AccuV;
    }

    virtual void print(raw_ostream &out) const { out << "Scalar Transfer"; }
  };

  struct ScalarTransferStrategy final : public ShuffleStrategy {
    void planPartialShuffle(MaskView &MV, PartialShuffleState FromState, PartialShuffleCB CB) override {
      PartialShuffleState FinalState;
      FinalState.MissingLanes.reset();
      CB(new ScalarTransferOp(FromState.MissingLanes), FinalState);
    }
  };

  // TODO VMV chaining...
  // TODO Expand,Compress

  // Analysis result -> the final shuffle sequence
  std::vector<std::unique_ptr<AbstractShuffleOp>> ShuffleSeq;

  // match a 64 bit segment, mapping out all source bits
  // FIXME this implies knowledge about the underlying object structure
  ShuffleAnalysis(MaskView &Mask) {
    PartialShuffleState InitialPSS =
        PartialShuffleState::fromInitialMask(Mask);

    // FIXME generalize this
    ScalarTransferStrategy STS;
    STS.planPartialShuffle(Mask, InitialPSS, [&](AbstractShuffleOp * PartialOp, PartialShuffleState NextPSS){
        assert(NextPSS.isComplete() && "scalar transfer is always complete..");
        ShuffleSeq.push_back(std::unique_ptr<AbstractShuffleOp>(PartialOp));
        return IterBreak;
    });
  }

  SDValue synthesize(MaskView &Mask, CustomDAG &CDAG, EVT LegalResultVT) {
    assert(ShuffleSeq.size() == 1);
    AbstractShuffleOp &SO = ref_to(*ShuffleSeq.begin());
    SDValue StartV = CDAG.getUndef(LegalResultVT);
    return SO.synthesize(Mask, CDAG, StartV);
  }
};


} // namespace llvm

#endif // LLVM_LIB_TARGET_VE_SHUFFLEANALYSIS_H
