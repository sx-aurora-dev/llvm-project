#include "ShuffleSynthesis.h"

namespace llvm {

/// MaskShuffleAnalysis {

// match a 64 bit segment, mapping out all source bits
// FIXME this implies knowledge about the underlying object structure
MaskShuffleAnalysis::MaskShuffleAnalysis(MaskView *Mask, unsigned NumEls) {
  const unsigned SXRegSize = 64;

  // loop over all sub-registers (sx parts of v256)
  for (unsigned PartIdx = 0; PartIdx * SXRegSize < NumEls; ++PartIdx) {
    const unsigned DestPartBase = PartIdx * SXRegSize;
    std::vector<bool> DefinedBits(SXRegSize, false);
    const unsigned NumPartBits = std::min(SXRegSize, NumEls - DestPartBase);

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

    LLVM_DEBUG(Part.print(dbgs()););
    Segments.push_back(Part);
  }
}

SDValue MaskShuffleAnalysis::synthesize(SDValue Passthru, BitSelect &BSel,
                                        SDValue SXV, CustomDAG &CDAG) const {
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
  SDValue ShiftV = CDAG.createElementShift(MaskedV.getValueType(), MaskedV,
                                           BSel.ShiftAmount, SDValue());

  // OR-in passthru
  SDValue ResV = ShiftV;
  if (Passthru) {
    ResV = CDAG.DAG.getNode(ISD::OR, CDAG.DL, SXV.getValueType(),
                            {ShiftV, Passthru});
  }

  return ResV;
}

// materialize the code to synthesize this operation
SDValue MaskShuffleAnalysis::synthesize(CustomDAG &CDAG) {
  std::map<std::pair<SDValue, unsigned>, SDValue> SourceParts;

  // Extract all source parts
  for (auto &ResPart : Segments) {
    for (auto &BitSel : ResPart.Selects) {
      auto Key = std::pair<SDValue, unsigned>(BitSel.SrcVal, BitSel.SrcValPart);
      if (SourceParts.find(Key) != SourceParts.end())
        continue;

      SDValue PartIdxC = CDAG.getConstant(Key.second, MVT::i64);
      auto SXPart = CDAG.createMaskExtract(Key.first, PartIdxC);
      SourceParts[Key] = SXPart;
    }
  }

  // Work through selects, blending and shifting the parts together
  SDValue VMAccu = CDAG.DAG.getUNDEF(MVT::v256i1);

  for (auto &ResPart : Segments) {
    SDValue SXAccu = CDAG.DAG.getUNDEF(MVT::i64);
    // synthesize all operations that feed into this destionation sx part
    for (auto &BitSel : ResPart.Selects) {
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

/// } MaskShuffleAnalysis

/// ShuffleAnalysis {

/// Scalar Shuffle Strategy {
// This shuffle strategy extracts all source lanes and inserts them into the
// result vector

// extract all vector elements and insert them back at the right positions
struct ScalarTransferOp final : public AbstractShuffleOp {
  LaneBits InsertPositions;

  ScalarTransferOp(LaneBits DefinedLanes) : InsertPositions(DefinedLanes) {}
  virtual ~ScalarTransferOp() {}

  // transfer all insert positions to their destination
  virtual SDValue synthesize(MaskView &MV, CustomDAG &CDAG, SDValue PartialV) {
    SDValue AccuV = PartialV;

    // TODO caching of extracted element..
    where_true(InsertPositions, [&](unsigned Idx) {
      auto ES = MV.getSourceElem(Idx);
      if (!ES.isDefined())
        return IterContinue;

      // isolate the scalar element
      SDValue SrcElemV;
      if (ES.isElemTransfer()) {
        SrcElemV = CDAG.getVectorExtract(
            ES.V, CDAG.getConstant(ES.getElemIdx(), MVT::i64));
      } else {
        assert(ES.isElemInsert());
        SrcElemV = ES.V;
      }

      // insert it
      AccuV = CDAG.getVectorInsert(AccuV, SrcElemV,
                                   CDAG.getConstant(Idx, MVT::i64));

      return IterContinue;
    });
    return AccuV;
  }

  virtual void print(raw_ostream &out) const { out << "Scalar Transfer"; }
};

struct ScalarTransferStrategy final : public ShuffleStrategy {
  void planPartialShuffle(MaskView &MV, PartialShuffleState FromState,
                          PartialShuffleCB CB) override {
    PartialShuffleState FinalState;

    // provides all missing lanes
    FinalState.MissingLanes.reset();
    CB(new ScalarTransferOp(FromState.MissingLanes), FinalState);
  }
};

/// } Scalar Shuffle Strategy

/// VMV Shuffle Strategy {
// This strategy emits one VMV Op that transfers an entire subvector
// either of the accumulator or the incoming vector.

struct VMVShuffleOp final : public AbstractShuffleOp {
  unsigned DestStartPos;
  unsigned SubVectorLength;
  int32_t ShiftAmount;
  SDValue SrcVector;

  VMVShuffleOp(unsigned DestStartPos, unsigned SubVectorLength, int32_t ShiftAmount, SDValue SrcVector)
  : DestStartPos(DestStartPos)
  , SubVectorLength(SubVectorLength)
  , ShiftAmount(ShiftAmount)
  , SrcVector(SrcVector)
  {}

  ~VMVShuffleOp() override {
  }

  void print(raw_ostream &out) const override {
    out << "VMV { SubVL: " << SubVectorLength
        << ", DestStartPos: " << DestStartPos
        << ", ShuftAmount: " << ShiftAmount << ", Src: ";
    SrcVector->print(out);
    out << " }\n";
  }

  unsigned getAVL() const {
    return DestStartPos + SubVectorLength;
  }

  // transfer all insert positions to their destination
  SDValue synthesize(MaskView &MV, CustomDAG &CDAG, SDValue PartialV) override {
    LaneBits VMVMask;
    // Synthesize the mask
    VMVMask.reset();
    for (size_t i = 0; i < getAVL(); ++i) {
      VMVMask[i] = (i >= (size_t) DestStartPos) && ((i - DestStartPos) < SubVectorLength);
    }
    SDValue MaskV = CDAG.createConstMask(getAVL(), VMVMask);
    SDValue VL = CDAG.getConstEVL(getAVL());
    SDValue ShiftV = CDAG.getConstant(ShiftAmount, MVT::i32);

    return CDAG.createPassthruVMV(PartialV.getValueType(), SrcVector, ShiftV,
                                  MaskV, PartialV, VL);
  }
};

struct VMVShuffleStrategy final : public ShuffleStrategy {
  void planPartialShuffle(MaskView &MV, PartialShuffleState FromState,
                          PartialShuffleCB CB) override {
    // Seek the largest, lowest shift amount subvector
    abort(); // TODO warping path...

    // TODO Generate partially planned state
    // CB(new VMVShuffleOp(FromState.MissingLanes), FinalState);
  }
};

/// } VMV Shuffle Strategy


ShuffleAnalysis::ShuffleAnalysis(MaskView &Mask) {
  PartialShuffleState InitialPSS = PartialShuffleState::fromInitialMask(Mask);

  // FIXME generalize this
  ScalarTransferStrategy STS;
  STS.planPartialShuffle(
      Mask, InitialPSS,
      [&](AbstractShuffleOp *PartialOp, PartialShuffleState NextPSS) {
        assert(NextPSS.isComplete() && "scalar transfer is always complete..");
        ShuffleSeq.push_back(std::unique_ptr<AbstractShuffleOp>(PartialOp));
        return IterBreak;
      });
}

SDValue ShuffleAnalysis::synthesize(MaskView &Mask, CustomDAG &CDAG,
                                    EVT LegalResultVT) {
  assert(ShuffleSeq.size() == 1);
  AbstractShuffleOp &SO = ref_to(*ShuffleSeq.begin());
  SDValue StartV = CDAG.getUndef(LegalResultVT);
  return SO.synthesize(Mask, CDAG, StartV);
}
/// } ShuffleAnalysis

} // namespace llvm
