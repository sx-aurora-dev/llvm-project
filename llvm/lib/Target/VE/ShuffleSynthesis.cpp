#include "ShuffleSynthesis.h"

#include <unordered_map>

namespace llvm {

VecLenOpt InferLengthFromMask(SDValue MaskV) {
  std::unique_ptr<MaskView> MV(requestMaskView(MaskV.getNode()));
  if (!MV)
    return None;

  unsigned FirstDef, LastDef, NumElems;
  BVMaskKind BVK = AnalyzeBitMaskView(*MV.get(), FirstDef, LastDef, NumElems);
  if (BVK == BVMaskKind::Interval) {
    // FIXME \p FirstDef must be == 0
    return LastDef + 1;
  }

  return None;
}

SDValue ReduceVectorLength(SDValue Mask, SDValue DynamicVL, VecLenOpt VLHint,
                           SelectionDAG &DAG) {
  auto ActualConstVL = dyn_cast<ConstantSDNode>(DynamicVL);
  if (!ActualConstVL)
    return DynamicVL;

  int64_t EVLVal = ActualConstVL->getSExtValue();
  SDLoc DL(DynamicVL);

  // no hint available -> dynamic VL
  if (!VLHint)
    return DynamicVL;

  // in-effective DynamicVL -> return the hint
  if (EVLVal < 0) {
    return DAG.getConstant(VLHint.getValue(), DL, MVT::i32);
  }

  if (Mask) {
    VecLenOpt MaskVL = InferLengthFromMask(Mask);
    VLHint = MinVectorLength(MaskVL, VLHint);
  }

  // the minimum of dynamicVL and the VLHint
  VecLenOpt MinOfAllHints = MinVectorLength(VLHint, EVLVal);
  return DAG.getConstant(MinOfAllHints.getValue(), DL, MVT::i32);
}

BVMaskKind AnalyzeBitMaskView(MaskView &MV, unsigned &FirstOne,
                              unsigned &FirstZero, unsigned &NumElements) {
  bool HasFirstOne = false, HasFirstZero = false;
  FirstOne = 0;
  FirstZero = 0;
  NumElements = 0;

  // this matches a 0*1*0* pattern (BVMaskKind::Interval)
  for (unsigned i = 0; i < MV.getNumElements(); ++i) {
    auto ES = MV.getSourceElem(i);
    if (!ES.isDefined())
      continue;
    ++NumElements;
    if (!ES.isElemInsert())
      return BVMaskKind::Unknown;

    auto CE = dyn_cast<ConstantSDNode>(ES.V);
    if (!CE)
      return BVMaskKind::Unknown;
    bool TrueBit = CE->getZExtValue() != 0;

    if (TrueBit && !HasFirstOne) {
      FirstOne = i;
      HasFirstOne = true;
    } else if (!TrueBit && !HasFirstZero) {
      FirstZero = i;
      HasFirstZero = true;
    } else if (TrueBit) {
      // flipping bits on again ->abort
      return BVMaskKind::Unknown;
    }
  }

  return BVMaskKind::Interval;
}

enum class BVKind : int8_t {
  Unknown,   // could not infer pattern
  AllUndef,  // all lanes undef
  Broadcast, // broadcast
  Seq,       // (0, .., 255) Sequence
  SeqBlock,  // (0, .., 15) ^ 16
  BlockSeq,  // 0^16, 1^16, 2^16
};

BVKind AnalyzeMaskView(MaskView &MV, unsigned &FirstDef, unsigned &LastDef,
                       int64_t &Stride, unsigned &BlockLength,
                       unsigned &NumElements) {
  // Check UNDEF or FirstDef
  NumElements = 0;
  bool AllUndef = true;
  FirstDef = 0;
  LastDef = 0;
  SDValue FirstInsertedV;
  for (unsigned i = 0; i < MV.getNumElements(); ++i) {
    auto ES = MV.getSourceElem(i);
    if (!ES.isDefined())
      continue;
    if (!ES.isElemInsert())
      return BVKind::Unknown;
    ++NumElements;

    // mark first non-undef position
    if (AllUndef) {
      FirstInsertedV = ES.V;
      FirstDef = i;
      AllUndef = false;
    }
    LastDef = i;
  }
  if (AllUndef) {
    return BVKind::Unknown;
  }

  // We know at this point that all source elements are scalar insertions or
  // undef

  // Check broadcast
  bool IsBroadcast = true;
  for (unsigned i = FirstDef + 1; i < MV.getNumElements(); ++i) {
    auto ES = MV.getSourceElem(i);
    assert((!ES.isDefined() || ES.isElemInsert()) &&
           "should have quit during first pass");

    bool SameAsFirst = FirstInsertedV == ES.V;
    if (!SameAsFirst && ES.isDefined()) {
      IsBroadcast = false;
    }
  }
  if (IsBroadcast)
    return BVKind::Broadcast;

  ///// Stride pattern detection /////
  // FIXME clean up

  bool hasConstantStride = true;
  bool hasBlockStride = false;
  bool hasBlockStride2 = false;
  bool firstStride = true;
  int64_t lastElemValue;
  BlockLength = 16;

  // Optional<int64_t> InnerStrideOpt;
  // Optional<int64_t> OuterStrideOpt
  // Optional<unsigned> BlockSizeOpt;

  for (unsigned i = 0; i < MV.getNumElements(); ++i) {
    auto ES = MV.getSourceElem(i);
    if (hasBlockStride) {
      if (i % BlockLength == 0)
        Stride = 1;
      else
        Stride = 0;
    }

    if (!ES.isDefined()) {
      if (hasBlockStride2 && i % BlockLength == 0)
        lastElemValue = 0;
      else
        lastElemValue += Stride;
      continue;
    }

    // is this an immediate constant value?
    auto *constNumElem = dyn_cast<ConstantSDNode>(ES.V);
    if (!constNumElem) {
      hasConstantStride = false;
      hasBlockStride = false;
      hasBlockStride2 = false;
      break;
    }

    // read value
    int64_t elemValue = constNumElem->getSExtValue();

    if (i == FirstDef) {
      // FIXME: Currently, this code requies that first value of vseq
      // is zero.  This is possible to enhance like thses instructions:
      //        VSEQ $v0
      //        VBRD $v1, 2
      //        VADD $v0, $v0, $v1
      if (elemValue != 0) {
        hasConstantStride = false;
        hasBlockStride = false;
        hasBlockStride2 = false;
        break;
      }
    } else if (i > FirstDef && firstStride) {
      // first stride
      Stride = (elemValue - lastElemValue) / (i - FirstDef);
      firstStride = false;
    } else if (i > FirstDef) {
      // later stride
      if (hasBlockStride2 && elemValue == 0 && i % BlockLength == 0) {
        lastElemValue = 0;
        continue;
      }
      int64_t thisStride = elemValue - lastElemValue;
      if (thisStride != Stride) {
        hasConstantStride = false;
        if (!hasBlockStride && thisStride == 1 && Stride == 0 &&
            lastElemValue == 0) {
          hasBlockStride = true;
          BlockLength = i;
        } else if (!hasBlockStride2 && elemValue == 0 &&
                   lastElemValue + 1 == i) {
          hasBlockStride2 = true;
          BlockLength = i;
        } else {
          // not blockStride anymore.  e.g. { 0, 1, 2, 3, 0, 0, 0, 0 }
          hasBlockStride = false;
          hasBlockStride2 = false;
          break;
        }
      }
    }

    // track last elem value
    lastElemValue = elemValue;
  }

  if (hasConstantStride)
    return BVKind::Seq;
  if (hasBlockStride) {
    int64_t blockLengthLog = log2(BlockLength);
    if (pow(2, blockLengthLog) == BlockLength)
      return BVKind::BlockSeq;
    return BVKind::Unknown;
  }
  if (hasBlockStride2) {
    int64_t blockLengthLog = log2(BlockLength);
    if (pow(2, blockLengthLog) == BlockLength)
      return BVKind::SeqBlock;
  }
  return BVKind::Unknown;
}

/// MaskShuffleAnalysis {

// shows only those elements of a vNi1 vector that are sourced from SX-registers
// or vector registers
class VRegView final : public MaskView {
  MaskView &BitMV;
  SDValue ConstZeroV;

public:
  VRegView(CustomDAG &CDAG, MaskView &BitMV)
      : BitMV(BitMV), ConstZeroV(CDAG.getConstant(0, MVT::i32)) {}

  ~VRegView() {}

  // get the element selection at i
  ElemSelect getSourceElem(unsigned DestIdx) override {
    auto ZeroInsert = ElemSelect(ConstZeroV);

    auto ES = BitMV.getSourceElem(DestIdx);
    // Default
    if (!ES.isDefined())
      return ElemSelect::Undef();

    // insertion from scalar registers (not a constant)
    LLVM_DEBUG(dbgs() << "VRegView ES: " << DestIdx << " value: ";
               ES.V->print(dbgs());
               dbgs() << " with value type "
                      << ES.V.getValueType().getEVTString() << "\n";);

    if (ES.isElemInsert() && ES.V.getValueType() == MVT::i32) {
      return isa<ConstantSDNode>(ES.V) ? ZeroInsert : ES;
    }

    // FIXME peek through vector truncation (and other reductions) to i1

    // Otw, emit a zero
    return ZeroInsert;
  }

  // the abstracr type of this mask
  EVT getValueType() const override {
    return MVT::getVectorVT(MVT::i32,
                            BitMV.getValueType().getVectorNumElements());
  }

  unsigned getNumElements() const override {
    return getValueType().getVectorNumElements();
  }
};

class BitMaskView final : public MaskView {
  MaskView &BitMV;

public:
  BitMaskView(MaskView &BitMV) : BitMV(BitMV) {}
  ~BitMaskView() {}

  // get the element selection at i
  ElemSelect getSourceElem(unsigned DestIdx) override {
    auto ES = BitMV.getSourceElem(DestIdx);

    LLVM_DEBUG(dbgs() << "OriginalMV ES: " << DestIdx << " value: ";
               ES.V->print(dbgs());
               dbgs() << " with value type "
                      << ES.V.getValueType().getEVTString() << "\n";);

    if (!ES.isDefined())
      return ES;

    // insertion from scalar registers
    if (ES.isElemInsert() && ES.V.getValueType() == MVT::i32) {
      return isa<ConstantSDNode>(ES.V) ? ES : ElemSelect::Undef();
    }

    // Otw, this is a proper bit transfer
    return ES;
  }

  // the abstracr type of this mask
  EVT getValueType() const override { return BitMV.getValueType(); }

  unsigned getNumElements() const override {
    return getValueType().getVectorNumElements();
  }
};

static bool hasNonZeroEntry(MaskView &MV) {
  for (unsigned i = 0; i < MV.getNumElements(); ++i) {
    auto ES = MV.getSourceElem(i);
    if (!ES.isDefined())
      continue;
    if (!ES.isElemInsert())
      return true;

    auto ConstV = dyn_cast<ConstantSDNode>(ES.V);
    if (!ConstV || (0 != ConstV->getZExtValue()))
      return true;
  }
  return false;
}

// match a 64 bit segment, mapping out all source bits
// FIXME this implies knowledge about the underlying object structure
MaskShuffleAnalysis::MaskShuffleAnalysis(MaskView &MV) : MV(MV) {
  IsConstantOne.reset();
  UndefBits.reset();

  // First, check for any insertions from scalar registers

  // this view only reflects insertions of actual i1 bits (from other mask
  // registers, or MVT::i32 constants)
  BitMaskView BitMV(MV);

  const unsigned NumEls = BitMV.getNumElements();
  const unsigned SXRegSize = 64;
  // loop over all sub-registers (sx parts of v256)
  for (unsigned PartIdx = 0; PartIdx * SXRegSize < NumEls; ++PartIdx) {
    const unsigned DestPartBase = PartIdx * SXRegSize;
    const unsigned NumPartBits = std::min(SXRegSize, NumEls - DestPartBase);

    unsigned NumMissingBits = NumPartBits; // keeps track of matcher rouds

    // described all
    ResPart Part(PartIdx);

    while (NumMissingBits > 0) {
      BitSelect Sel;
      for (unsigned i = 0; i < NumPartBits; ++i) {
        ElemSelect ES = BitMV.getSourceElem(i + DestPartBase);
        // skip both kinds of undef (no value transfered or source is undef)
        if (!ES.isDefined()) {
          UndefBits[DestPartBase + i] = true;
          NumMissingBits--;
          continue;
        }

        // inserted bit constants
        if (!ES.isElemTransfer()) {
          NumMissingBits--;
          // This only works because we know that the BitMaskView will mask-out
          // any non-constant bit insertions
          auto ConstBit = cast<ConstantSDNode>(ES.V);
          bool IsTrueBit = 0 != ConstBit->getZExtValue();
          IsConstantOne[i] = IsTrueBit;
          continue;
        }

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
          NumMissingBits--;
          continue;
        }

        // Copy all bits with similar alignment
        if ((Sel.SrcVal == ES.V && Sel.SrcValPart == SrcPartIdx) &&
            Sel.ShiftAmount == ShiftAmount) {
          Sel.SrcSelMask |= 1 << ES.ExtractIdx;
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

bool MaskShuffleAnalysis::analyzeVectorSources(bool &AllTrue) const {
  // Check whether all non-scalar sources are the constant `1` or undef
  AllTrue = true;
  for (unsigned i = 0; i < IsConstantOne.size(); ++i) {
    if (!UndefBits[i] && !IsConstantOne[i])
      AllTrue = false;
    break;
  }
  // all `1` background
  if (AllTrue)
    return true;

  // Check whether all segments are empty (eg all non-scalar sources are `0` or
  // undef)
  for (auto &SXPart : Segments) {
    // bit transfer from vector mask reg
    if (!SXPart.empty())
      return false;
    // Non-0 bits in the cconstant background
    for (unsigned SXBit = 0; SXBit < SXRegSize; ++SXBit) {
      if (IsConstantOne[SXPart.ResPartIdx * SXRegSize + SXBit]) {
        return false;
      }
    }
  }

  // all `0` background
  AllTrue = false;
  return true;
}

// materialize the code to synthesize this operation
SDValue MaskShuffleAnalysis::synthesize(CustomDAG &CDAG) {
  // this view reflects exactly those insertions that are non-constant and have
  // a MVT::i32 type
  VRegView VectorMV(CDAG, MV);
  SDValue BlendV; // VM to be OR-ed into the resulting vector

  bool HasScalarSourceEntries = hasNonZeroEntry(VectorMV);

  if (HasScalarSourceEntries) {
    LLVM_DEBUG(dbgs() << ":: has non-trivial insertion in VectorMV ::\n";);
    SDValue AVL = CDAG.getConstEVL(256); // FIXME
    // Synthesize the result vector
    ShuffleAnalysis VSA(VectorMV);
    auto Res = VSA.analyze();
    assert(Res == ShuffleAnalysis::CanSynthesize);
    SDValue VecSourceV = VSA.synthesize(CDAG, VectorMV.getValueType());
    BlendV = CDAG.createMaskCast(VecSourceV, AVL);
  }

  // Check for a constant in the bit transfer mask
  SDValue VMAccu;
  bool AllTrue;
  bool HasTrivialBackground = analyzeVectorSources(AllTrue);
  bool AllTrueBackground = HasTrivialBackground && AllTrue;
  bool AllFalseBackground = HasTrivialBackground && AllTrue;

  if (!HasScalarSourceEntries && AllTrueBackground) {
    // Must not have spurious `1` entries since what is undefined for the
    // vector/constant sources could be the defined insertion of a bit from a
    // scalar register. Short cut when the only occuring constant is a '1'
    VMAccu = CDAG.createUniformConstMask(256, true);

  } else if (AllFalseBackground) {
    // Don't need to check for spurious `1` bits here since
    // the scalar result and the vector/constant results are OR-ed together in
    // the end.
    VMAccu = SDValue();

  } else {
    VMAccu = CDAG.DAG.getUNDEF(MVT::v256i1);

    // There are non-trivial bit transfers from other vector registers
    // Actual mask synthesis code path
    std::map<std::pair<SDValue, unsigned>, SDValue> SourceParts;

    // Extract all source parts
    for (auto &ResPart : Segments) {
      for (auto &BitSel : ResPart.Selects) {
        auto Key =
            std::pair<SDValue, unsigned>(BitSel.SrcVal, BitSel.SrcValPart);
        if (SourceParts.find(Key) != SourceParts.end())
          continue;

        SDValue PartIdxC = CDAG.getConstant(Key.second, MVT::i64);
        auto SXPart = CDAG.createMaskExtract(Key.first, PartIdxC);
        SourceParts[Key] = SXPart;
      }
    }

    // Work through selects, blending and shifting the parts together
    for (auto &ResPart : Segments) {

      // Synthesize the constant background
      unsigned BaseConstant = 0;
      for (unsigned i = 0; i < SXRegSize; ++i) {
        unsigned BitPos = i + ResPart.ResPartIdx * SXRegSize;
        if (IsConstantOne[BitPos])
          BaseConstant |= (1 << i);
      }
      SDValue SXAccu = CDAG.getConstant(BaseConstant, MVT::i64);

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
  }

  // OR-in the BlendV (values inserted from scalar regs)
  if (BlendV && VMAccu) {
    return CDAG.getNode(ISD::OR, MVT::v256i1, {VMAccu, BlendV});
  }
  if (BlendV)
    return BlendV;
  if (VMAccu)
    return VMAccu;
  return CDAG.createUniformConstMask(256, false);
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

  VMVShuffleOp(unsigned DestStartPos, unsigned SubVectorLength,
               int32_t ShiftAmount, SDValue SrcVector)
      : DestStartPos(DestStartPos), SubVectorLength(SubVectorLength),
        ShiftAmount(ShiftAmount), SrcVector(SrcVector) {}

  ~VMVShuffleOp() override {}

  void print(raw_ostream &out) const override {
    out << "VMV { SubVL: " << SubVectorLength
        << ", DestStartPos: " << DestStartPos
        << ", ShiftAmount: " << ShiftAmount << ", Src: ";
    SrcVector->print(out);
    out << " }\n";
  }

  unsigned getAVL() const { return DestStartPos + SubVectorLength; }

  // transfer all insert positions to their destination
  SDValue synthesize(MaskView &MV, CustomDAG &CDAG, SDValue PartialV) override {
    // noop VMV
    if (ShiftAmount == 0 && PartialV->isUndef())
      return SrcVector;

    LaneBits VMVMask;
    // Synthesize the mask
    VMVMask.reset();
    for (size_t i = 0; i < getAVL(); ++i) {
      VMVMask[i] =
          (i >= (size_t)DestStartPos) && ((i - DestStartPos) < SubVectorLength);
    }
    SDValue MaskV = CDAG.createConstMask(getAVL(), VMVMask);
    SDValue VL = CDAG.getConstEVL(getAVL());
    SDValue ShiftV = CDAG.getConstant(ShiftAmount, MVT::i32);

    SDValue ResV =
        CDAG.createVMV(PartialV.getValueType(), SrcVector, ShiftV, MaskV, VL);
    return CDAG.createSelect(ResV.getValueType(), ResV, PartialV, MaskV, VL);
  }
};

struct VMVShuffleStrategy final : public ShuffleStrategy {
  // greedily match the longest subvector move from \p MV starting at \p
  // SrcStartPos and reading from the source vector \p SrcValue.
  // \returns  the last matching position
  unsigned matchSubvectorMove(MaskView &MV, SDValue SrcValue,
                              unsigned DestStartPos, unsigned SrcStartPos) {
    unsigned LastProperMatch = SrcStartPos;
    for (unsigned i = 1; DestStartPos + i < MV.getNumElements(); ++i) {
      auto ES = MV.getSourceElem(DestStartPos + i);
      // skip over undefined elements
      if (!ES.isDefined())
        continue;
      if (!ES.isElemTransfer())
        continue;

      // check for a contiguous element transfer from the same source vector
      if (ES.V != SrcValue)
        return LastProperMatch;
      unsigned SrcOffset = SrcStartPos + i;
      if (SrcOffset != ES.getElemIdx())
        return LastProperMatch;

      LastProperMatch = SrcOffset;
    }

    return LastProperMatch;
  }

  static int32_t WrapShiftAmount(int32_t ShiftAmount) {
    if (std::abs(ShiftAmount) <= 127)
      return ShiftAmount;
    if (ShiftAmount > 0)
      return -(256 - ShiftAmount);
    return 256 + ShiftAmount;
  }

  void planPartialShuffle(MaskView &MV, PartialShuffleState FromState,
                          PartialShuffleCB CB) override {
    // Seek the largest, lowest shift amount subvector
    SDValue BestSourceV;
    unsigned LongestSVSrcStart = 0;
    unsigned LongestSVDestStart = 0;
    unsigned LongestSubvector = 0;

    // Scan for the largest subvector match
    for (unsigned DestStartIdx = 0;
         DestStartIdx + LongestSubvector < MV.getNumElements();
         ++DestStartIdx) {

      if (!FromState.isMissing(DestStartIdx))
        continue;

      auto ES = MV.getSourceElem(DestStartIdx);
      if (!ES.isDefined())
        continue;
      if (ES.isElemInsert())
        continue;

      SDValue SrcVectorV = ES.V;
      unsigned SrcStartIdx = ES.getElemIdx();
      int32_t ShiftAmount = SrcStartIdx - (int32_t)DestStartIdx;

      // TODO allow wrapping
      unsigned SrcLastMatchIdx =
          matchSubvectorMove(MV, SrcVectorV, DestStartIdx, SrcStartIdx);
      unsigned LastMatchedSVPos = SrcLastMatchIdx - SrcStartIdx;
      unsigned MatchedSVLen = LastMatchedSVPos + 1;

      // new contender
      int32_t BestShiftAmount = LongestSVSrcStart - (int32_t)LongestSVDestStart;
      if ((MatchedSVLen > LongestSubvector) ||
          ((MatchedSVLen == LongestSubvector) &&
           (ShiftAmount < BestShiftAmount))) {
        LongestSVSrcStart = SrcStartIdx;
        LongestSVDestStart = DestStartIdx;
        LongestSubvector = MatchedSVLen;
        BestSourceV = SrcVectorV;
      }
    }

    // TODO cost considerations
    const unsigned MinSubvectorLen = 3;
    if (LongestSubvector < MinSubvectorLen) {
      return;
    }

    // Construct VMV and feed it to the callback
    PartialShuffleState Res = FromState;
    for (unsigned DestIdx = LongestSVDestStart;
         DestIdx < LongestSVDestStart + LongestSubvector; ++DestIdx) {
      Res.unsetMissing(DestIdx);
    }

    int32_t ShiftAmount =
        WrapShiftAmount(LongestSVSrcStart - (int32_t)LongestSVDestStart);
    auto *VMVOp = new VMVShuffleOp(LongestSVDestStart, LongestSubvector,
                                   ShiftAmount, BestSourceV);
    CB(VMVOp, Res);
  }
};

/// } VMV Shuffle Strategy

/// Legacy Pattern Strategy {

struct PatternShuffleOp final : public AbstractShuffleOp {
  BVKind PatternKind;
  unsigned FirstDef;
  unsigned LastDef;
  int64_t Stride;
  unsigned BlockLength;
  unsigned NumElems;

  PatternShuffleOp(BVKind PatternKind, unsigned FirstDef, unsigned LastDef,
                   int64_t Stride, unsigned BlockLength, unsigned NumElems)
      : PatternKind(PatternKind), FirstDef(FirstDef), LastDef(LastDef),
        Stride(Stride), BlockLength(BlockLength), NumElems(NumElems) {}

  ~PatternShuffleOp() override {}

  void print(raw_ostream &out) const override {
    out << "PatternShuffle { FirstDef: " << FirstDef << ", LastDef: " << LastDef
        << " }\n";
  }

  // transfer all insert positions to their destination
  SDValue synthesize(MaskView &MV, CustomDAG &CDAG, SDValue PartialV) override {
    EVT LegalResVT =
        PartialV.getValueType(); // LegalizeVectorType(Op.getValueType(),
                                 // Op, DAG, Mode);
    bool Packed = IsPackedType(LegalResVT);
    unsigned NativeNumElems = LegalResVT.getVectorNumElements();

    EVT ElemTy = PartialV.getValueType().getVectorElementType();

    // Include the last defined element in the broadcast
    SDValue OpVectorLength =
        CDAG.getConstant(Packed ? (LastDef + 1) / 2 : LastDef + 1, MVT::i32);

    SDValue TrueMask = CDAG.createUniformConstMask(NativeNumElems, true);

    switch (PatternKind) {

    // Could not detect pattern
    case BVKind::Unknown:
      llvm_unreachable("Cannot synthesize the 'Unknown' pattern!");

    // Fold undef
    case BVKind::AllUndef: {
      LLVM_DEBUG(dbgs() << "::AllUndef\n");
      return CDAG.getUndef(LegalResVT);
    }

    case BVKind::Broadcast: {
      LLVM_DEBUG(dbgs() << "::Broadcast\n");
      SDValue ScaVal = MV.getSourceElem(FirstDef).V;
      LLVM_DEBUG(ScaVal->dump());
      return CDAG.CreateBroadcast(LegalResVT, ScaVal, OpVectorLength);
    }

    case BVKind::Seq: {
      LLVM_DEBUG(dbgs() << "::Seq\n");
      // detected a proper stride pattern
      SDValue SeqV = CDAG.CreateSeq(LegalResVT, OpVectorLength);
      if (Stride == 1) {
        LLVM_DEBUG(dbgs() << "ConstantStride: VEC_SEQ\n");
        LLVM_DEBUG(CDAG.dumpValue(SeqV));
        return SeqV;
      }

      SDValue StrideV = CDAG.CreateBroadcast(
          LegalResVT, CDAG.getConstant(Stride, ElemTy), OpVectorLength);
      SDValue ret = CDAG.getNode(VEISD::VVP_MUL, LegalResVT,
                                 {SeqV, StrideV, TrueMask, OpVectorLength});
      LLVM_DEBUG(dbgs() << "ConstantStride: VEC_SEQ * VEC_BROADCAST\n");
      LLVM_DEBUG(CDAG.dumpValue(StrideV));
      LLVM_DEBUG(CDAG.dumpValue(ret));
      return ret;
    }

    case BVKind::SeqBlock: {
      LLVM_DEBUG(dbgs() << "::SeqBlock\n");
      // codegen for <0, 1, .., 15, 0, 1, .., ..... > constant patterns
      // constant == VSEQ % blockLength
      SDValue sequence = CDAG.CreateSeq(LegalResVT, OpVectorLength);
      SDValue modulobroadcast = CDAG.CreateBroadcast(
          LegalResVT, CDAG.getConstant(BlockLength - 1, ElemTy),
          OpVectorLength);

      SDValue modulo =
          CDAG.getNode(VEISD::VVP_AND, LegalResVT,
                       {sequence, modulobroadcast, TrueMask, OpVectorLength});

      LLVM_DEBUG(dbgs() << "BlockStride2: VEC_SEQ & VEC_BROADCAST\n");
      LLVM_DEBUG(CDAG.dumpValue(sequence));
      LLVM_DEBUG(CDAG.dumpValue(modulobroadcast));
      LLVM_DEBUG(CDAG.dumpValue(modulo));
      return modulo;
    }

    case BVKind::BlockSeq: {
      LLVM_DEBUG(dbgs() << "::BlockSeq\n");
      // codegen for <0, 0, .., 0, 0, 1, 1, .., 1, 1, .....> constant patterns
      // constant == VSEQ >> log2(blockLength)
      int64_t blockLengthLog = log2(BlockLength);
      SDValue sequence = CDAG.CreateSeq(LegalResVT, OpVectorLength);
      SDValue shiftbroadcast = CDAG.CreateBroadcast(
          LegalResVT, CDAG.getConstant(blockLengthLog, ElemTy), OpVectorLength);

      SDValue shift =
          CDAG.getNode(VEISD::VVP_SRL, LegalResVT,
                       {sequence, shiftbroadcast, TrueMask, OpVectorLength});
      LLVM_DEBUG(dbgs() << "BlockStride: VEC_SEQ >> VEC_BROADCAST\n");
      LLVM_DEBUG(sequence.dump());
      LLVM_DEBUG(shiftbroadcast.dump());
      LLVM_DEBUG(shift.dump());
      return shift;
    }
    }
    llvm_unreachable("UNREACHABLE!");
  }
};

class LegacyPatternStrategy final : public ShuffleStrategy {
public:
  void planPartialShuffle(MaskView &MV, PartialShuffleState FromState,
                          PartialShuffleCB CB) override {
    // Seek the largest, lowest shift amount subvector
    // TODO move this to the planning stage
    unsigned FirstDef = 0;
    unsigned LastDef = 0;
    int64_t Stride = 0;
    unsigned BlockLength = 0;
    unsigned NumElems = 0;

    BVKind PatternKind =
        AnalyzeMaskView(MV, FirstDef, LastDef, Stride, BlockLength, NumElems);

    if (PatternKind == BVKind::Unknown)
      return;

    // This is the number of LSV that may be used to represent a BUILD_VECTOR
    // Otw, this defaults to VLD of a constant
    // FIXME move this to TTI
    const unsigned InsertThreshold = 4;

    // Always use broadcast if you can -> this enables implicit broadcast
    // matching during isel (eg vfadd_vsvl) if one operand is a VEC_BROADCAST
    // node
    // TODO preserve the bitmask in VEC_BROADCAST to expand VEC_BROADCAST late
    // into LVS when its not folded
    if ((PatternKind != BVKind::Broadcast) && (NumElems < InsertThreshold)) {
      return;
    }

    // all missing bits provided
    PartialShuffleState FinalState;
    FinalState.MissingLanes.reset();

    CB(new PatternShuffleOp(PatternKind, FirstDef, LastDef, Stride, BlockLength,
                            NumElems),
       FinalState);
  }
};

/// } Legacy Pattern Strategy

/// Broadcast Strategy {

// This strategy tries to identify the most-frequent element to
// broadcast-and-merge

struct BroadcastOp final : public AbstractShuffleOp {
  ElemSelect SourceElem;
  LaneBits TargetLanes;
  unsigned MaxAVL;

  BroadcastOp(ElemSelect SourceElem, LaneBits TargetLanes, unsigned MaxAVL)
      : SourceElem(SourceElem), TargetLanes(TargetLanes), MaxAVL(MaxAVL) {}

  ~BroadcastOp() {}

  SDValue synthesize(MaskView &MV, CustomDAG &CDAG, SDValue PartialV) {
    SDValue ScalarSrcV;
    if (SourceElem.isElemInsert()) {
      ScalarSrcV = SourceElem.V;
    } else {
      ScalarSrcV = CDAG.getVectorExtract(SourceElem.V, SourceElem.ExtractIdx);
    }

    EVT VecTy = PartialV.getValueType();
    const unsigned NumElems = VecTy.getVectorNumElements();

    const SDValue PivotV = CDAG.getConstEVL(MaxAVL);
    SDValue BlendMaskV = CDAG.createConstMask(NumElems, TargetLanes);
    SDValue BroadcastV = CDAG.CreateBroadcast(VecTy, ScalarSrcV, PivotV);
    return CDAG.createSelect(VecTy, BroadcastV, PartialV, BlendMaskV, PivotV);
  }

  void print(raw_ostream &out) const {
    out << "Broadcast (AVL: " << MaxAVL << ", Elem: ";
    SourceElem.print(out) << "\n";
  }
};

class BroadcastStrategy final : public ShuffleStrategy {
public:
  void planPartialShuffle(MaskView &MV, PartialShuffleState FromState,
                          PartialShuffleCB CB) override {

    std::unordered_map<ElemSelect, unsigned> ESMap;

    unsigned MaxVL = 0;

    // Create a histogram of all selected values
    FromState.for_missing([&](unsigned Idx) {
      if (!MV.getSourceElem(Idx).isDefined())
        return IterContinue;
      MaxVL = Idx + 1;

      ElemSelect ES = MV.getSourceElem(Idx);
      auto ItES = ESMap.find(ES);
      unsigned Count = 0;
      if (ItES != ESMap.end()) {
        Count = ItES->second + 1;
      }
      ESMap[ES] = Count;
      return IterContinue;
    });

    // find the most frequent (and cheapest) element to broadcast and blend
    unsigned BestCount = 0;
    ElemSelect BestES;
    for (const auto ItElemCount : ESMap) {
      if (ItElemCount.second > BestCount) {
        BestES = ItElemCount.first;
        BestCount = ItElemCount.second;
      }
    }

    // FIXME cost considerations
    const unsigned BroadcastThreshold = 4;
    if (BestCount < BroadcastThreshold)
      return;

    // tick off all merged positions
    LaneBits BroadcastMask;
    BroadcastMask.reset();
    for (unsigned i = 0; i < MV.getNumElements(); ++i) {
      auto ES = MV.getSourceElem(i);
      if (!ES.isDefined())
        continue;
      if (BestES != ES)
        continue;
      FromState.unsetMissing(i);
      BroadcastMask[i] = true;
    }

    CB(new BroadcastOp(BestES, BroadcastMask, MaxVL), FromState);
  }
};

/// } Broadcast Strategy

IterControl ShuffleAnalysis::runStrategy(ShuffleStrategy &Strat,
                                         unsigned NumRounds, MaskView &MV,
                                         PartialShuffleState &PSS) {
  for (unsigned i = 0; i < NumRounds; ++i) {
    bool Progress = false;
    Strat.planPartialShuffle(
        MV, PSS,
        [&](AbstractShuffleOp *PartialOp, PartialShuffleState NextPSS) {
          Progress = true;
          PSS = NextPSS,
          ShuffleSeq.push_back(std::unique_ptr<AbstractShuffleOp>(PartialOp));
          return IterBreak;
        });
    if (!Progress)
      break;
  }
  return PSS.isComplete() ? IterBreak : IterContinue;
}

ShuffleAnalysis::AnalyzeResult ShuffleAnalysis::analyze() {
  PartialShuffleState PSS = PartialShuffleState::fromInitialMask(MV);

  if (IterBreak == run<LegacyPatternStrategy>(1, MV, PSS))
    return CanSynthesize;
  if (IterBreak == run<BroadcastStrategy>(3, MV, PSS))
    return CanSynthesize;
  if (IterBreak == run<VMVShuffleStrategy>(5, MV, PSS))
    return CanSynthesize;

  // Fallback
  ScalarTransferStrategy STS;
  STS.planPartialShuffle(
      MV, PSS, [&](AbstractShuffleOp *PartialOp, PartialShuffleState NextPSS) {
        assert(NextPSS.isComplete() && "scalar transfer is always complete..");
        ShuffleSeq.push_back(std::unique_ptr<AbstractShuffleOp>(PartialOp));
        return IterBreak;
      });

  return CanSynthesize;
}

raw_ostream &ShuffleAnalysis::print(raw_ostream &out) const {
  out << "ShuffleAnalysis. Sequence {\n";
  for (const auto &ShuffleOp : ShuffleSeq) {
    out << "- ";
    ShuffleOp->print(out);
  }
  out << "}\n";
  return out;
}

SDValue ShuffleAnalysis::synthesize(CustomDAG &CDAG, EVT LegalResultVT) {
  LLVM_DEBUG(dbgs() << "Synthesized shuffle sequence:\n"; print(dbgs()));

  SDValue AccuV = CDAG.getUndef(LegalResultVT);
  for (auto &ShuffOp : ShuffleSeq) {
    AccuV = ShuffOp->synthesize(MV, CDAG, AccuV);
  }
  return AccuV;
}

/// } ShuffleAnalysis

} // namespace llvm
