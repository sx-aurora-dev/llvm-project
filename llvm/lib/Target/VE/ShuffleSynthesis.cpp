#include "ShuffleSynthesis.h"

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
  VecLenOpt MaskVL = InferLengthFromMask(Mask);

  // TODO analyze Mask
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

  // the minimum of dynamicVL and the VLHint
  VecLenOpt MinOfAllHints =
      MinVectorLength(MinVectorLength(MaskVL, VLHint), EVLVal);
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
  if (hasBlockStride)
    return BVKind::BlockSeq;
  if (hasBlockStride2)
    return BVKind::SeqBlock;
  return BVKind::Unknown;
}

/// MaskShuffleAnalysis {

// match a 64 bit segment, mapping out all source bits
// FIXME this implies knowledge about the underlying object structure
MaskShuffleAnalysis::MaskShuffleAnalysis(MaskView &MV, unsigned NumEls) {

  unsigned FirstZero = 0, FirstOne = 0, NumElements = 0;

  BVMaskKind MaskPattern =
      AnalyzeBitMaskView(MV, FirstOne, FirstZero, NumElements);

  // match a broadcast
  if (MaskPattern == BVMaskKind::Interval) {
  }

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
        ElemSelect ES = MV.getSourceElem(i + DestPartBase);
        // skip both kinds of undef (no value transfered or source is undef)
        if (!ES.isDefined()) {
          DefinedBits[i] = true;
          UndefBits[DestPartBase + i] = true;
          NumMissingBits--;
          continue;
        }

        // inserted bit constants
        if (!ES.isElemTransfer()) {
          DefinedBits[i] = true;
          NumMissingBits--;
          // TODO implement SX bit insertions
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
  // Check for a constant splat
  bool IsTrueSplat = true;
  for (unsigned i = 0; i < IsConstantOne.size(); ++i) {
    if (!UndefBits[i] && !IsConstantOne[i])
      IsTrueSplat = false;
  }
  if (IsTrueSplat) {
    return CDAG.createConstMask(256, true);
  }

  // Actual mask synthesis code path
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

  VMVShuffleOp(unsigned DestStartPos, unsigned SubVectorLength,
               int32_t ShiftAmount, SDValue SrcVector)
      : DestStartPos(DestStartPos), SubVectorLength(SubVectorLength),
        ShiftAmount(ShiftAmount), SrcVector(SrcVector) {}

  ~VMVShuffleOp() override {}

  void print(raw_ostream &out) const override {
    out << "VMV { SubVL: " << SubVectorLength
        << ", DestStartPos: " << DestStartPos
        << ", ShuftAmount: " << ShiftAmount << ", Src: ";
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
    return CDAG.createSelect(ResV, PartialV, MaskV, VL);
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
      int32_t ShiftAmount = DestStartIdx - (int32_t)SrcStartIdx;

      // TODO allow wrapping
      unsigned SrcLastMatchIdx =
          matchSubvectorMove(MV, SrcVectorV, DestStartIdx, SrcStartIdx);
      unsigned LastMatchedSVPos = SrcLastMatchIdx - SrcStartIdx;
      unsigned MatchedSVLen = LastMatchedSVPos + 1;

      // new contender
      int32_t BestShiftAmount = LongestSVDestStart - (int32_t)LongestSVSrcStart;
      if ((MatchedSVLen > LongestSubvector) ||
          ((MatchedSVLen == LongestSubvector) &&
           (ShiftAmount < BestShiftAmount))) {
        LongestSVSrcStart = SrcStartIdx;
        LongestSVDestStart = DestStartIdx;
        LongestSubvector = MatchedSVLen;
        BestSourceV = SrcVectorV;
      }
    }

    LLVM_DEBUG(
        dbgs() << "Best Source: "; if (BestSourceV) BestSourceV->print(dbgs());
        dbgs() << ", BestSV: " << LongestSubvector
               << ", LongestSVDestStart: " << LongestSVDestStart << "\n";);

    // TODO cost considerations
    const unsigned MinSubvectorLen = 2;
    if (LongestSubvector < MinSubvectorLen) {
      return;
    }

    // Construct VMV and feed it to the callback
    PartialShuffleState Res = FromState;
    for (unsigned DestIdx = LongestSVDestStart;
         DestIdx < LongestSVDestStart + LongestSubvector; ++DestIdx) {
      Res.unsetMissing(DestIdx);
    }

    int32_t ShiftAmount = LongestSVDestStart - (int32_t)LongestSVSrcStart;
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
      : FirstDef(FirstDef), LastDef(LastDef), Stride(Stride),
        BlockLength(BlockLength), NumElems(NumElems) {}

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

    SDValue TrueMask = CDAG.CreateConstMask(NativeNumElems, true);

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
      int64_t blockLengthLog = log2(BlockLength);

      if (pow(2, blockLengthLog) != BlockLength)
        break;

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

      if (pow(2, blockLengthLog) != BlockLength)
        break;

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
    llvm_unreachable("");
  }
};

class LegacyPatternStrategy final : ShuffleStrategy {
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

ShuffleAnalysis::ShuffleAnalysis(MaskView &Mask) {
  PartialShuffleState PSS = PartialShuffleState::fromInitialMask(Mask);

  // Use the legacy strategy where applicable
  LegacyPatternStrategy LegacyStrategy;
  LegacyStrategy.planPartialShuffle(
      Mask, PSS,
      [&](AbstractShuffleOp *PartialOp, PartialShuffleState NextPSS) {
        PSS = NextPSS,
        ShuffleSeq.push_back(std::unique_ptr<AbstractShuffleOp>(PartialOp));
        return IterBreak;
      });
  if (!ShuffleSeq.empty())
    return;

  // Try lowering to VMV transfers
  const unsigned NumVMVRounds = 5;
  VMVShuffleStrategy VMVStrat;

  for (unsigned i = 0; i < NumVMVRounds; ++i) {

    bool Progress = false;
    VMVStrat.planPartialShuffle(
        Mask, PSS,
        [&](AbstractShuffleOp *PartialOp, PartialShuffleState NextPSS) {
          Progress = true;
          PSS = NextPSS,
          ShuffleSeq.push_back(std::unique_ptr<AbstractShuffleOp>(PartialOp));
          return IterBreak;
        });
    if (!Progress)
      break;
  }
  if (PSS.isComplete())
    return;

  // Fallback
  ScalarTransferStrategy STS;
  STS.planPartialShuffle(
      Mask, PSS,
      [&](AbstractShuffleOp *PartialOp, PartialShuffleState NextPSS) {
        assert(NextPSS.isComplete() && "scalar transfer is always complete..");
        ShuffleSeq.push_back(std::unique_ptr<AbstractShuffleOp>(PartialOp));
        return IterBreak;
      });
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

SDValue ShuffleAnalysis::synthesize(MaskView &Mask, CustomDAG &CDAG,
                                    EVT LegalResultVT) {
  SDValue AccuV = CDAG.getUndef(LegalResultVT);
  for (auto &ShuffOp : ShuffleSeq) {
    AccuV = ShuffOp->synthesize(Mask, CDAG, AccuV);
  }
  return AccuV;
}

/// } ShuffleAnalysis

} // namespace llvm
