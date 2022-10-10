#include "ShuffleSynthesis.h"
#include <cmath>
#include <unordered_map>

namespace llvm {

unsigned GetVectorNumElements(Type *Ty) {
  return cast<FixedVectorType>(Ty)->getNumElements();
}

Type *GetVectorElementType(Type *Ty) {
  return cast<FixedVectorType>(Ty)->getElementType();
}

/// MaskShuffleAnalysis {

class ZeroDefaultingView : public MaskView {
protected:
  MaskView &BaseMV;
  SDValue ConstZeroV;
  ElemSelect ZeroInsert;

public:
  ZeroDefaultingView(MaskView &BaseMV, VECustomDAG &CDAG)
      : BaseMV(BaseMV), ConstZeroV(CDAG.getConstant(0, MVT::i32)),
        ZeroInsert(ConstZeroV) {}
};

// shows only those elements of a vNi1 vector that are sourced from SX-registers
// or vector registers
class VRegView final : public ZeroDefaultingView {
public:
  VRegView(VECustomDAG &CDAG, MaskView &BitMV)
      : ZeroDefaultingView(BitMV, CDAG) {}

  ~VRegView() {}

  // get the element selection at i
  ElemSelect getSourceElem(unsigned DestIdx) override {
    auto ZeroInsert = ElemSelect(ConstZeroV);

    auto ES = BaseMV.getSourceElem(DestIdx);
    // Default
    if (!ES.isDefined())
      return ElemSelect::Undef();

      // insertion from scalar registers (not a constant)
#if 0
    LLVM_DEBUG(dbgs() << "VRegView ES: " << DestIdx << " value: ";
               ES.V->print(dbgs());
               dbgs() << " with value type "
                      << ES.V.getValueType().getEVTString() << "\n";);
#endif

    // Only model element insertions
    if (ES.isElemInsert() && !isa<ConstantSDNode>(ES.V)) {
      return ES;
    }

    // Otw, produce '0' for safe OR-ing of the two views
    return ZeroInsert;
  }

  // the abstract type of this mask
  EVT getValueType() const override {
    return MVT::getVectorVT(MVT::i32,
                            BaseMV.getValueType().getVectorNumElements());
  }

  unsigned getNumElements() const override {
    return getValueType().getVectorNumElements();
  }
};

class BitMaskView final : public ZeroDefaultingView {
public:
  BitMaskView(MaskView &BitMV, VECustomDAG &CDAG)
      : ZeroDefaultingView(BitMV, CDAG) {}
  ~BitMaskView() {}

  // get the element selection at i
  ElemSelect getSourceElem(unsigned DestIdx) override {
    auto ES = BaseMV.getSourceElem(DestIdx);

#if 0
    LLVM_DEBUG(dbgs() << "OriginalMV ES: " << DestIdx << " value: ";
               ES.V->print(dbgs());
               dbgs() << " with value type "
                      << ES.V.getValueType().getEVTString() << "\n";);
#endif

    if (!ES.isDefined())
      return ES;

    // insertion from scalar registers
    if (ES.isElemInsert() && !isa<ConstantSDNode>(ES.V)) {
      // produce '0' for safe OR-ing of the two views
      return ZeroInsert;
    }

    // Otw, this is a proper bit transfer
    return ES;
  }

  // the abstracr type of this mask
  EVT getValueType() const override { return BaseMV.getValueType(); }

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

static unsigned AnalyzePart(BitMaskView &BitMV, unsigned DestPartBase,
                            unsigned NumPartBits, unsigned NumMissingBits,
                            std::vector<bool> &MappedPartBits,
                            MaskShuffleAnalysis::BitSelect &Sel) {
  // dbgs() << "]=== PART (" << DestPartBase << ") ROUND ===\n";
  for (unsigned i = 0; i < NumPartBits; ++i) {
    if (MappedPartBits[i])
      continue;
    ElemSelect ES = BitMV.getSourceElem(i + DestPartBase);
    // Skip both kinds of undef (no value transfered or source is undef).
    if (!ES.isDefined()) {
      MappedPartBits[i] = true;
      --NumMissingBits;
      continue;
    }

    // Inserted bit constants.
    if (!ES.isElemTransfer()) {
      MappedPartBits[i] = true;
      --NumMissingBits;
      // This only works because we know that the BitMaskView will mask-out
      // any non-constant bit insertions
      continue;
    }

    // Proper bit transfer from a vector mask reg.
    unsigned SrcPartIdx =
        (ES.ExtractIdx / SXRegSize); // sx sub-register to chose from
    // Required shift amount of the elements of the sub register
    int64_t SrcOffset = (ES.ExtractIdx % SXRegSize);
    int64_t DestOffset = i - SrcOffset; // shift left by this amount

    // errs() << "  Trans. SrcPart: " << SrcPartIdx << ". Offset: " << SrcOffset
    // << "\n";

    // First bit transfer in this round.
    if (!Sel.SrcVal) {
      Sel.SrcVal = ES.V;
      Sel.SrcValPart = SrcPartIdx;
      Sel.ShiftAmount = DestOffset; // Shift by the required amount.
      Sel.SrcSelMask =
          1ul << SrcOffset; // Mask out the bit at the source position.
      NumMissingBits--;
      MappedPartBits[i] = true;
      // dbgs() << "NEW CHUNK(" << i << "): "; Sel.print(dbgs());
      continue;
    }

    // Copy all bits with similar alignment.
    if ((Sel.SrcVal == ES.V && Sel.SrcValPart == SrcPartIdx) &&
        (Sel.ShiftAmount - i) == DestOffset) {
      Sel.SrcSelMask |= 1ul << i;
      // dbgs() << "\tJOIN CHUNK(" << i << "): "; Sel.print(dbgs());
      NumMissingBits--;
      MappedPartBits[i] = true;
      continue;
    }

    // errs() << "    misaligned!\n";

    // misaligned bit // TODO start from here next round
  }
  return NumMissingBits;
}

// Check whether this is a complete mask reversal and insertion.
static bool AnalyzeReversal(BitMaskView &BitMV, unsigned DestPartBase,
                            unsigned NumPartBits,
                            MaskShuffleAnalysis::BitReverse &BitReverse) {
  if (getenv("LLVMVE_NO_REVERSE"))
    return false;
  if (NumPartBits != SXRegSize)
    return false; // FIXME: Should still work (junk tail.. so what!)
  SDValue SrcV;
  unsigned SrcPart = 0;

  for (unsigned i = 0; i < NumPartBits; ++i) {
    ElemSelect ES = BitMV.getSourceElem(i + DestPartBase);
    // Skip both kinds of undef (no value transfered or source is undef).
    if (!ES.isDefined()) {
      return false;
    }
    if (!ES.isElemTransfer()) {
      // This only works because we know that the BitMaskView will mask-out
      // any non-constant bit insertions
      return false;
    }

    // Only one possible source register and part.
    unsigned ElemSrcPart = ES.getElemIdx() / SXRegSize;
    if (!SrcV) {
      SrcV = ES.V;
      SrcPart = ElemSrcPart;
    } else if ((SrcV != ES.V) || (SrcPart != ElemSrcPart))
      return false;

    unsigned SrcOffset = ES.getElemIdx() % SXRegSize;
    if ((SXRegSize - 1) - SrcOffset != i)
      return false;
  }

  BitReverse.SrcVal = SrcV;
  BitReverse.SrcValPart = SrcPart;
  return true;
}

// match a 64 bit segment, mapping out all source bits
// FIXME this implies knowledge about the underlying object structure
MaskShuffleAnalysis::MaskShuffleAnalysis(MaskView &MV, VECustomDAG &CDAG)
    : MV(MV) {
  // This view only reflects insertions of actual i1 bits (from other mask
  // registers, or MVT::i32 constants). Insertion of SX register will be masked
  // out.
  BitMaskView BitMV(MV, CDAG);
  const unsigned NumEls = BitMV.getNumElements();
  const unsigned SXRegSize = 64;

  // Detect constants and undef elements.
  IsConstantOne.reset();
  UndefBits.reset();
  for (unsigned i = 0; i < NumEls; ++i) {
    ElemSelect ES = BitMV.getSourceElem(i);
    if (!ES.isDefined()) {
      // Skip both kinds of undef (no value transfered or source is undef).
      UndefBits[i] = true;
    } else if (!ES.isElemTransfer()) {
      // Inserted bit constants.
      // This only works because we know that the BitMaskView will mask-out
      // any non-constant bit insertions
      auto ConstBit = cast<ConstantSDNode>(ES.V);
      bool IsTrueBit = 0 != ConstBit->getZExtValue();
      IsConstantOne[i] = IsTrueBit;
    }
  }

  // Loop over SX chunks of the destination mask and piece it together with mask
  // & shift operations
  for (unsigned PartIdx = 0; PartIdx * SXRegSize < NumEls; ++PartIdx) {
    const unsigned DestPartBase = PartIdx * SXRegSize;
    const unsigned NumPartBits = std::min(SXRegSize, NumEls - DestPartBase);

    // Collection of all actions on this result part.
    ResPart Part(PartIdx);

    // errs() << "==== Part " << PartIdx <<" ====\n";
    // Common bit reversal pattern.
    if (AnalyzeReversal(BitMV, DestPartBase, NumPartBits, Part.BitReversal)) {
      LLVM_DEBUG(Part.print(dbgs()););
      Segments.push_back(Part);
      continue;
    }

    // Free-form mask bit shuffle.
    unsigned NumMissingBits = NumPartBits; // keeps track of matcher rouds
    std::vector<bool> MappedPartBits(SXRegSize, false);
    while (NumMissingBits > 0) {
      BitSelect Sel;
      NumMissingBits = AnalyzePart(BitMV, DestPartBase, NumPartBits,
                                   NumMissingBits, MappedPartBits, Sel);
      if (Sel.SrcVal) {
        Part.Selects.push_back(Sel);
      }
    }

    LLVM_DEBUG(Part.print(dbgs()););
    Segments.push_back(Part);
  }
}

SDValue MaskShuffleAnalysis::synthesize(SDValue Passthru, BitSelect &BSel,
                                        SDValue SXV, VECustomDAG &CDAG) const {
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
  SDValue ShiftV = CDAG.getElementShift(MaskedV.getValueType(), MaskedV,
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
      unsigned BitPos = SXPart.ResPartIdx * SXRegSize + SXBit;
      if (!UndefBits[BitPos] && IsConstantOne[BitPos]) {
        return false;
      }
    }
  }

  // all `0` background
  AllTrue = false;
  return true;
}

// materialize the code to synthesize this operation
SDValue MaskShuffleAnalysis::synthesize(VECustomDAG &CDAG, EVT LegalMaskVT) {
  Packing PackFlag =
      isPackedVectorType(LegalMaskVT) ? Packing::Dense : Packing::Normal;

  // this view reflects exactly those insertions that are non-constant and have
  // a MVT::i32 type
  VRegView VectorMV(CDAG, MV);
  SDValue BlendV; // VM to be OR-ed into the resulting vector

  // actual element count
  const unsigned NumElems = MV.getNumElements();
  // result type element count
  const unsigned LegalNumElems = LegalMaskVT.getVectorNumElements();
  bool HasScalarSourceEntries = hasNonZeroEntry(VectorMV);

  // There are insertions of scalar register bits.
  // CodeGen those as insertions into 'BlendV' to OR-them in later.
  if (HasScalarSourceEntries) {
    LLVM_DEBUG(dbgs() << ":: has non-trivial insertion in VectorMV ::\n";);
    SDValue AVL = CDAG.getConstEVL(PackFlag, NumElems);
    // Synthesize the result vector
    ShuffleAnalysis VSA(VectorMV);
    auto Res = VSA.analyze();
    assert(Res == ShuffleAnalysis::CanSynthesize);
    SDValue VecSourceV =
        VSA.synthesize(CDAG, CDAG.getVectorVT(MVT::i32, LegalNumElems));
    BlendV = CDAG.getMaskCast(VecSourceV, AVL);
  }

  // Check whether this is an all-zero or all-one constant mask (except for
  // scalar register insertions). If not, transfer the XS-sized chunks from
  // their respective source registers.
  SDValue VMAccu;
  bool AllTrue;
  bool HasTrivialBackground = analyzeVectorSources(AllTrue);
  bool AllTrueBackground = HasTrivialBackground && AllTrue;
  bool AllFalseBackground = HasTrivialBackground && !AllTrue;

  if (!HasScalarSourceEntries && AllTrueBackground) {
    // Must not have spurious `1` entries since what is undefined for the
    // vector/constant sources could be the defined insertion of a bit from a
    // scalar register. Short cut when the only occuring constant is a '1'
    VMAccu = CDAG.getUniformConstMask(PackFlag, LegalNumElems, true);

  } else if (AllFalseBackground) {
    // Don't need to check for spurious `1` bits here since
    // the scalar result and the vector/constant results are OR-ed together in
    // the end.
    VMAccu = SDValue(); // Deferring all-false codegen (so we can save on an
                        // 'OR' with the blend mask)

  } else {
    // Either non-trivial constant mask or non-trivial incoming bits from other
    // vector masks.
    VMAccu = CDAG.DAG.getUNDEF(LegalMaskVT);

    // There are non-trivial bit transfers from other vector registers
    // Actual mask synthesis code path
    std::map<std::pair<SDValue, unsigned>, SDValue> SourceParts;

    // Extract all source parts
    for (auto &ResPart : Segments) {
      if (ResPart.BitReversal.isValid()) {
        // TODO de-dup
        auto &BitRev = ResPart.BitReversal;
        auto Key =
            std::pair<SDValue, unsigned>(BitRev.SrcVal, BitRev.SrcValPart);
        if (SourceParts.find(Key) != SourceParts.end())
          continue;

        SDValue PartIdxC = CDAG.getConstant(Key.second, MVT::i64);
        auto SXPart = CDAG.getMaskExtract(Key.first, PartIdxC);
        SourceParts[Key] = SXPart;
        continue;
      }
      for (auto &BitSel : ResPart.Selects) {
        // TODO de-dup
        auto Key =
            std::pair<SDValue, unsigned>(BitSel.SrcVal, BitSel.SrcValPart);
        if (SourceParts.find(Key) != SourceParts.end())
          continue;

        SDValue PartIdxC = CDAG.getConstant(Key.second, MVT::i64);
        auto SXPart = CDAG.getMaskExtract(Key.first, PartIdxC);
        SourceParts[Key] = SXPart;
      }
    }

    // Work through selects, blending and shifting the parts together
    for (auto &ResPart : Segments) {
      SDValue SXAccu; // synthesized chunk.

      if (ResPart.BitReversal.isValid()) {
        auto &BitRev = ResPart.BitReversal;
        auto ItExtractedSrc = SourceParts.find(
            std::pair<SDValue, unsigned>(BitRev.SrcVal, BitRev.SrcValPart));
        assert(ItExtractedSrc != SourceParts.end());
        SXAccu = CDAG.getBitReverse(ItExtractedSrc->second);

      } else {
        // Synthesize the constant background
        unsigned BaseConstant = 0;
        for (unsigned i = 0; i < SXRegSize; ++i) {
          unsigned BitPos = i + ResPart.ResPartIdx * SXRegSize;
          if (IsConstantOne[BitPos])
            BaseConstant |= (1 << i);
        }
        SXAccu = CDAG.getConstant(BaseConstant, MVT::i64);

        // synthesize all operations that feed into this destionation sx part
        for (auto &BitSel : ResPart.Selects) {
          auto ItExtractedSrc = SourceParts.find(
              std::pair<SDValue, unsigned>(BitSel.SrcVal, BitSel.SrcValPart));
          assert(ItExtractedSrc != SourceParts.end());
          SXAccu = synthesize(SXAccu, BitSel, ItExtractedSrc->second, CDAG);
        }
      }

      // finally, insert the SX part into the the actual VM
      VMAccu = CDAG.getMaskInsert(
          VMAccu, CDAG.getConstant(ResPart.ResPartIdx, MVT::i64), SXAccu);
    }
  }

  // OR-in the BlendV (values inserted from scalar regs)
  if (BlendV && VMAccu) {
    return CDAG.getNode(ISD::OR, LegalMaskVT, {VMAccu, BlendV});
  }
  if (BlendV)
    return BlendV;
  if (VMAccu)
    return VMAccu;
  return CDAG.getUniformConstMask(PackFlag, LegalNumElems, false);
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
  virtual SDValue synthesize(MaskView &MV, VECustomDAG &CDAG,
                             SDValue PartialV) override {
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

  virtual void print(raw_ostream &out) const override {
    out << "Scalar Transfer";
  }
};

struct ScalarTransferStrategy final : public ShuffleStrategy {
  // Whether this strategy is applicable to non-packed shuffles
  static bool supportsNormalMode() { return true; }
  // Whether this strategy is applicable to packed shuffles
  static bool supportsPackedMode() { return false; }

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
  SDValue synthesize(MaskView &MV, VECustomDAG &CDAG,
                     SDValue PartialV) override {
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
    SDValue MaskV = CDAG.getConstMask(getAVL(), VMVMask);
    SDValue VL = CDAG.getConstant(getAVL(), MVT::i32);
    SDValue ShiftV = CDAG.getConstant(ShiftAmount, MVT::i32);

    SDValue ResV =
        CDAG.getVMV(PartialV.getValueType(), SrcVector, ShiftV, MaskV, VL);
    return CDAG.getSelect(ResV.getValueType(), ResV, PartialV, MaskV, VL);
  }
};

struct VMVShuffleStrategy final : public ShuffleStrategy {
  // Whether this strategy is applicable to non-packed shuffles
  static bool supportsNormalMode() { return true; }
  // Whether this strategy is applicable to packed shuffles
  static bool supportsPackedMode() { return false; }

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
  SDValue synthesize(MaskView &MV, VECustomDAG &CDAG,
                     SDValue PartialV) override {
    EVT LegalResVT =
        PartialV.getValueType(); // LegalizeVectorType(Op.getValueType(),
                                 // Op, DAG, Mode);
    bool Packed = isPackedVectorType(LegalResVT);
    unsigned NativeNumElems = LegalResVT.getVectorNumElements();

    EVT ElemTy = PartialV.getValueType().getVectorElementType();

    // Include the last defined element in the broadcast
    SDValue AVL = CDAG.getConstant(LastDef + 1, MVT::i32);
    // CDAG.getConstant(Packed ? (LastDef + 1) / 2 : LastDef + 1, MVT::i32);

    Packing P = Packed ? Packing::Dense : Packing::Normal;
    SDValue TrueMask = CDAG.getUniformConstMask(P, NativeNumElems, true);

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
      return CDAG.getBroadcast(LegalResVT, ScaVal, AVL);
    }

    case BVKind::Seq: {
      LLVM_DEBUG(dbgs() << "::Seq\n");
      // detected a proper stride pattern
      SDValue SeqV = CDAG.getSeq(LegalResVT, AVL);
      if (Stride == 1) {
        LLVM_DEBUG(dbgs() << "ConstantStride: VEC_SEQ\n");
        LLVM_DEBUG(CDAG.dumpValue(SeqV));
        return SeqV;
      }

      SDValue StrideV =
          CDAG.getBroadcast(LegalResVT, CDAG.getConstant(Stride, ElemTy), AVL);
      SDValue ret = CDAG.getNode(VEISD::VVP_MUL, LegalResVT,
                                 {SeqV, StrideV, TrueMask, AVL});
      LLVM_DEBUG(dbgs() << "ConstantStride: VEC_SEQ * VEC_BROADCAST\n");
      LLVM_DEBUG(CDAG.dumpValue(StrideV));
      LLVM_DEBUG(CDAG.dumpValue(ret));
      return ret;
    }

    case BVKind::SeqBlock: {
      LLVM_DEBUG(dbgs() << "::SeqBlock\n");
      // codegen for <0, 1, .., 15, 0, 1, .., ..... > constant patterns
      // constant == VSEQ % blockLength
      SDValue sequence = CDAG.getSeq(LegalResVT, AVL);
      SDValue modulobroadcast = CDAG.getBroadcast(
          LegalResVT, CDAG.getConstant(BlockLength - 1, ElemTy), AVL);

      SDValue modulo = CDAG.getNode(VEISD::VVP_AND, LegalResVT,
                                    {sequence, modulobroadcast, TrueMask, AVL});

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
      SDValue sequence = CDAG.getSeq(LegalResVT, AVL);
      SDValue shiftbroadcast = CDAG.getBroadcast(
          LegalResVT, CDAG.getConstant(blockLengthLog, ElemTy), AVL);

      SDValue shift = CDAG.getNode(VEISD::VVP_SRL, LegalResVT,
                                   {sequence, shiftbroadcast, TrueMask, AVL});
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

struct LegacyPatternStrategy final : public ShuffleStrategy {
  // Whether this strategy is applicable to non-packed shuffles
  static bool supportsNormalMode() { return true; }
  // Whether this strategy is applicable to packed shuffles
  static bool supportsPackedMode() { return true; }

  void planPartialShuffle(MaskView &MV, PartialShuffleState FromState,
                          PartialShuffleCB CB) override {
    // Seek the largest, lowest shift amount subvector
    // TODO move this to the planning stage
    unsigned FirstDef = 0;
    unsigned LastDef = 0;
    int64_t Stride = 0;
    unsigned BlockLength = 0;
    unsigned NumElems = 0;

    bool IsPackedMode = MV.getNumElements() > StandardVectorWidth;

    BVKind PatternKind =
        AnalyzeMaskView(MV, FirstDef, LastDef, Stride, BlockLength, NumElems);

    if (PatternKind == BVKind::Unknown)
      return;

    // This is the number of LSV that may be used to represent a BUILD_VECTOR
    // Otw, this defaults to VLD of a constant
    // FIXME move this to TTI
    const unsigned InsertThreshold = 4;

    bool SkipOtherThanBroadcast =
        (NumElems < InsertThreshold) || (IsPackedMode);
    // Always use broadcast if you can -> this enables implicit broadcast
    // matching during isel (eg vfadd_vsvl) if one operand is a VEC_BROADCAST
    // node
    // TODO preserve the bitmask in VEC_BROADCAST to expand VEC_BROADCAST late
    // into LVS when its not folded
    if ((PatternKind != BVKind::Broadcast) && SkipOtherThanBroadcast) {
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

  SDValue synthesize(MaskView &MV, VECustomDAG &CDAG,
                     SDValue PartialV) override {
    SDValue ScalarSrcV;
    if (SourceElem.isElemInsert()) {
      ScalarSrcV = SourceElem.V;
    } else {
      ScalarSrcV = CDAG.getVectorExtract(SourceElem.V, SourceElem.ExtractIdx);
    }

    EVT VecTy = PartialV.getValueType();
    const unsigned NumElems = VecTy.getVectorNumElements();

    const SDValue PivotV = CDAG.getConstant(MaxAVL, MVT::i32);
    SDValue BlendMaskV = CDAG.getConstMask(NumElems, TargetLanes);
    SDValue BroadcastV = CDAG.getBroadcast(VecTy, ScalarSrcV, PivotV);
    return CDAG.getSelect(VecTy, BroadcastV, PartialV, BlendMaskV, PivotV);
  }

  void print(raw_ostream &out) const override {
    out << "Broadcast (AVL: " << MaxAVL << ", Elem: ";
    SourceElem.print(out) << "\n";
  }
};

struct BroadcastStrategy final : public ShuffleStrategy {
  // Whether this strategy is applicable to non-packed shuffles
  static bool supportsNormalMode() { return true; }
  // Whether this strategy is applicable to packed shuffles
  static bool supportsPackedMode() { return false; }

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

/// Constant Elements {
// This strategy emits a constant vector with all the elements and loads it from
// memory.
struct ConstantElemOp final : public AbstractShuffleOp {
  Constant *VecConstant;
  ConstantElemOp(Constant *VecConstant) : VecConstant(VecConstant) {}
  ~ConstantElemOp() {}

  SDValue synthesize(MaskView &MV, VECustomDAG &CDAG,
                     SDValue PartialV) override {
    EVT LegalResVT = PartialV.getValueType();
    const EVT PtrVT = MVT::i64;
    // const unsigned LegalNumElems = LegalResVT.getVectorNumElements();
    Align VecAlignBytes(8);
    SDValue ConstantPtrV =
        CDAG.DAG.getConstantPool(VecConstant, PtrVT, VecAlignBytes);
    SDValue ResultV;
    CDAG.weaveIntoRootChain([&]() {
      SDValue Chain = CDAG.DAG.getEntryNode();
#if 1
      // FIXME only works for 32/64bit elements
      const unsigned NumBufferElems =
          GetVectorNumElements(VecConstant->getType());
      const auto *ElemTy =
          cast<FixedVectorType>(VecConstant->getType())->getElementType();
      uint64_t Stride = (ElemTy->getPrimitiveSizeInBits().getFixedSize() + 7) /
                        8; // FIXME should be using datala
      Packing P =
          isPackedVectorType(LegalResVT) ? Packing::Dense : Packing::Normal;
      SDValue MaskV =
          CDAG.getUniformConstMask(P, LegalResVT.getVectorNumElements(), true);
      SDValue StrideV = CDAG.getConstant(Stride, MVT::i64);
      SDValue AVL = CDAG.getConstant(NumBufferElems, MVT::i32);
      ResultV =
          CDAG.getVVPLoad(LegalResVT, Chain, ConstantPtrV, StrideV, MaskV, AVL);
#else
      MachinePointerInfo MPI;
      ResultV = CDAG.DAG.getLoad(LegalResVT, CDAG.DL, Chain, ConstantPtrV, MPI);
#endif
      return SDValue(ResultV.getNode(), 1);
    });
    return ResultV;
  }

  void print(raw_ostream &out) const override {
    out << "ConstantElemShuffle (";
    VecConstant->print(out);
    out << ")\n";
  }
};

struct ConstantElemStrategy final : public ShuffleStrategy {
  // Whether this strategy is applicable to non-packed shuffles
  static bool supportsNormalMode() { return true; }
  // Whether this strategy is applicable to packed shuffles
  static bool supportsPackedMode() { return false; }

  void planPartialShuffle(MaskView &MV, PartialShuffleState FromState,
                          PartialShuffleCB CB) override {

    Type *ElemTy = nullptr;
    unsigned NumConstElems = 0;
    std::vector<Constant *> CVec;
    unsigned LastConstElemVL = 0;
    for (unsigned Idx = 0; Idx < MV.getNumElements(); ++Idx) {
      auto ES = MV.getSourceElem(Idx);
      Constant *ElemC = nullptr;
      if (!ES.isDefined()) {
        ElemC = nullptr;
      } else if (!ES.isElemInsert()) {
        ElemC = nullptr;
      } else if (ConstantSDNode *ElemN = dyn_cast<ConstantSDNode>(ES.V)) {
        ElemC = const_cast<ConstantInt *>(ElemN->getConstantIntValue());
      } else if (ConstantFPSDNode *ElemN = dyn_cast<ConstantFPSDNode>(ES.V)) {
        ElemC = const_cast<ConstantFP *>(ElemN->getConstantFPValue());
      }

      if (ElemC) {
        if (!ElemTy)
          ElemTy = ElemC->getType();
        LastConstElemVL = Idx + 1;
        ++NumConstElems;
      }

      CVec.push_back(ElemC);
    }

    // FIXME Heuristics
    const unsigned ConstElemThreshold = 8;
    if (NumConstElems < ConstElemThreshold)
      return;

    // Truncate up to the last constant entry
    CVec.resize(LastConstElemVL);

    auto UDVal = UndefValue::get(ElemTy);
    for (unsigned Idx = 0; Idx < CVec.size(); ++Idx) {
      if (!CVec[Idx]) {
        CVec[Idx] = UDVal;
      } else {
        FromState.unsetMissing(Idx);
      }
    }

    auto *CV = ConstantVector::get(CVec);
    CB(new ConstantElemOp(CV), FromState);
  }
};

/// } Constant Elements

/// Gather Strategy {

// This strategy provides missing lanes by writing the source register to the
// stack a stack lot and gathering from it to the right lanes (using passthru)

struct GatherShuffleOp final : public AbstractShuffleOp {
  SDValue SrcVectorV;
  std::vector<unsigned> SrcLanes;
  LaneBits TargetLanes;
  unsigned MaxVL;

  GatherShuffleOp(SDValue SrcVectorV, LaneBits TargetLanes, unsigned MaxVL)
      : SrcVectorV(SrcVectorV), TargetLanes(TargetLanes), MaxVL(MaxVL) {}

  ~GatherShuffleOp() {}

  SDValue synthesize(MaskView &MV, VECustomDAG &CDAG,
                     SDValue PartialV) override {
    // Spill the requires elements of \p SrcVectorV to the stack
    EVT LegalizedSrcVT =
        CDAG.legalizeVectorType(SrcVectorV, VVPExpansionMode::ToNextWidth);

    EVT LegalResVT = PartialV.getValueType();
    const unsigned LegalNumElems = LegalResVT.getVectorNumElements();
    const unsigned ElemBytes =
        LegalResVT.getVectorElementType().getStoreSizeInBits() / 8;

    // ptr offset type
    MVT PtrVT = MVT::i64;
    EVT PtrVecVT = CDAG.getVectorVT(PtrVT, LegalNumElems);

    const unsigned SpillAlign = 8;
    //
    // TODO use the smallest possible spill type
#if 1
    auto VecSlotPtr = CDAG.DAG.CreateStackTemporary(LegalizedSrcVT, SpillAlign);
#else
    // FIXME use something like the below code:
    uint64_t TySize = CDAG.getDataLayout().getTypeAllocSize(LegalizeSrcVT);
    int SSFI = MF.getFrameInfo().CreateStackObject(TySize, Align, false);
    SDValue StackSlot = DAG.getFrameIndex(SSFI, TLI.getFrameIndexTy(DL));
    Chain = DAG.getTruncStore(Chain, Location, OpInfo.CallOperand, StackSlot,
                              MachinePointerInfo::getFixedStack(MF, SSFI),
                              TLI.getMemValueType(DL, Ty));
#endif

    // Spill to VecSlot
    MachinePointerInfo MPI;
    SDValue Chain = CDAG.DAG.getStore(CDAG.DAG.getEntryNode(), CDAG.DL,
                                      SrcVectorV, VecSlotPtr, MPI);

    // Compute gahter indices
    SDValue TrueMaskV =
        CDAG.getUniformConstMask(Packing::Normal, LegalNumElems, true);
    SDValue MaskV =
        PartialV.isUndef() ? TrueMaskV : CDAG.getConstMask(MaxVL, TargetLanes);

    std::vector<SDValue> GatherOffsets;
    for (unsigned Idx = 0; Idx < MaxVL; ++Idx) {
      auto ES = MV.getSourceElem(Idx);
      if (ES.V != SrcVectorV) {
        // Need to emit an inbounds offset here to do the gather without
        // masking.
        GatherOffsets.push_back(CDAG.getConstant(0, PtrVT));
        continue;
      }

      assert(ES.isElemTransfer());
      GatherOffsets.push_back(
          CDAG.getConstant(ElemBytes * ES.getElemIdx(), PtrVT)); // TODO
    }
    for (unsigned Idx = MaxVL; Idx < LegalNumElems; ++Idx) {
      GatherOffsets.push_back(CDAG.getUndef(PtrVT));
    }

    SDValue MaxVLV = CDAG.getConstant(MaxVL, MVT::i32);
    SDValue BasePtrV = CDAG.getBroadcast(PtrVecVT, VecSlotPtr, MaxVLV);
    SDValue OffsetV = CDAG.getNode(
        ISD::BUILD_VECTOR, PtrVecVT,
        GatherOffsets); // TODO directly call into constant vector generation
    SDValue GatherPtrV = CDAG.getNode(ISD::ADD, PtrVecVT, {BasePtrV, OffsetV});

    SDValue ElemV =
        CDAG.getVVPGather(LegalResVT, Chain, GatherPtrV, TrueMaskV, MaxVLV);
    Chain = SDValue(ElemV.getNode(), 1);

    // weave in with the root chain
    CDAG.DAG.setRoot(CDAG.getTokenFactor({CDAG.getRootOrEntryChain(), Chain}));

    if (PartialV.isUndef()) {
      return ElemV;
    }
    return CDAG.getSelect(LegalResVT, ElemV, PartialV, MaskV, MaxVLV);
  }

  void print(raw_ostream &out) const override {
    out << "GatherShuffle (VL: " << MaxVL << ", SourceVector: ";
    SrcVectorV->print(out);
    out << ")\n";
  }
};

struct GatherStrategy final : public ShuffleStrategy {
  // Whether this strategy is applicable to non-packed shuffles
  static bool supportsNormalMode() { return true; }
  // Whether this strategy is applicable to packed shuffles
  // FIXME needs split gather
  static bool supportsPackedMode() { return false; }

  void planPartialShuffle(MaskView &MV, PartialShuffleState FromState,
                          PartialShuffleCB CB) override {

    std::unordered_map<SDNode *, unsigned> VecSourceHisto;

    // most frequent vector source
    SDValue MaxV;
    unsigned MaxCount = 0;
    unsigned MaxVL = 0;

    // Find the most frequent vector source
    FromState.for_missing([&](unsigned Idx) {
      ElemSelect ES = MV.getSourceElem(Idx);
      if (!ES.isDefined())
        return IterContinue;
      if (ES.isElemInsert())
        return IterContinue;

      SDNode *SrcN = ES.V.getNode();
      auto ItSrc = VecSourceHisto.find(SrcN);
      unsigned Count = 0;
      if (ItSrc != VecSourceHisto.end()) {
        Count = ItSrc->second + 1;
      }
      if (Count > MaxCount) {
        MaxCount = Count;
        MaxV = ES.V;
        MaxVL = Idx + 1;
      }
      VecSourceHisto[SrcN] = Count;
      return IterContinue;
    });

    // Abort if below a certain threshold
    const unsigned MinGatherElements = 32;
    if (MaxCount < MinGatherElements)
      return;

    // Find all lanes with this source
    LaneBits TargetBits;
    TargetBits.reset();
    FromState.for_missing([&](unsigned Idx) {
      auto ES = MV.getSourceElem(Idx);
      if (!ES.isDefined())
        return IterContinue;
      if (ES.V == MaxV) {
        TargetBits[Idx] = ES.V == MaxV;
        FromState.unsetMissing(Idx);
      }
      return IterContinue;
    });

    CB(new GatherShuffleOp(MaxV, TargetBits, MaxVL), FromState);
  }
};

/// } Gather Strategy

IterControl ShuffleAnalysis::runStrategy(ShuffleStrategy &Strat,
                                         unsigned NumRounds, MaskView &MV,
                                         PartialShuffleState &PSS) {
  for (unsigned i = 0; !PSS.isComplete() && i < NumRounds; ++i) {
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

  // Detect simple broadcast, SEQ patterns (that explains the *entire* pattern)
  if (IterBreak == run<LegacyPatternStrategy>(1, MV, PSS))
    return CanSynthesize;

  // Load all constant entries from the constant pool.
  if (IterBreak == run<ConstantElemStrategy>(1, MV, PSS))
    return CanSynthesize;

  // Broadcast and blend the most frequent single element.
  if (IterBreak == run<BroadcastStrategy>(3, MV, PSS))
    return CanSynthesize;
  // Provide elements by VMV.
  if (IterBreak == run<VMVShuffleStrategy>(5, MV, PSS))
    return CanSynthesize;
  // Finally, store vector sources to memory and gather them
  if (IterBreak == run<GatherStrategy>(3, MV, PSS))
    return CanSynthesize;

  // Fallback: LVS-LSV the elements into place.
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

SDValue ShuffleAnalysis::synthesize(VECustomDAG &CDAG, EVT LegalResultVT) {
  LLVM_DEBUG(dbgs() << "Synthesized shuffle sequence:\n"; print(dbgs()));

  SDValue AccuV = CDAG.getUndef(LegalResultVT);
  for (auto &ShuffOp : ShuffleSeq) {
    AccuV = ShuffOp->synthesize(MV, CDAG, AccuV);
  }
  return AccuV;
}

/// } ShuffleAnalysis

} // namespace llvm
