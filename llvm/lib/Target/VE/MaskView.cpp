#include "MaskView.h"
#include "VECustomDAG.h"
#include <cmath>
#include <set>

#define DEBUG_TYPE "ve-maskview"

namespace llvm {

// SDNode abstractions
struct ShuffleVectorView : public MaskView {
  ShuffleVectorSDNode *SN;

  ShuffleVectorView(ShuffleVectorSDNode *SN) : SN(SN) {}

  ElemSelect getSourceElem(unsigned DestIdx) override {
    unsigned SrcPos = SN->getMaskElt(DestIdx);
    unsigned NumOps = SN->getNumOperands();
    unsigned CurrentBase = 0;
    for (unsigned i = 0; i < NumOps; ++i) {
      SDValue Op = SN->getOperand(i);
      bool SrcIsVector = Op->getValueType(0).isVector();
      unsigned OpWidth =
          SrcIsVector ? Op->getValueType(0).getVectorNumElements() : 1;

      if (SrcPos >= CurrentBase && SrcPos < CurrentBase + OpWidth) {
        // selecting from Op at SrcPos - CurrentBase
        if (SrcIsVector) {
          return ElemSelect(Op, SrcPos - CurrentBase);
        }

        return ElemSelect(Op);
      }

      CurrentBase += OpWidth;
    }

    return ElemSelect();
  }

  virtual SDNode *getNode() const override { return SN; }

  virtual EVT getValueType() const override { return SN->getValueType(0); }
};

// SDNode abstractions
struct BuildVectorView : public MaskView {
  BuildVectorSDNode *BVN;

  BuildVectorView(BuildVectorSDNode *BVN) : BVN(BVN) {}

  ElemSelect getSourceElem(unsigned DestIdx) override {
    unsigned NumOps = BVN->getNumOperands();
    unsigned CurrentBase = 0;
    for (unsigned i = 0; i < NumOps; ++i) {
      SDValue Op = BVN->getOperand(i);
      bool SrcIsVector = Op->getValueType(0).isVector();
      unsigned OpWidth =
          SrcIsVector ? Op->getValueType(0).getVectorNumElements() : 1;

      if (DestIdx >= CurrentBase && DestIdx < CurrentBase + OpWidth) {
        // selecting from Op at SrcPos - CurrentBase
        if (SrcIsVector) {
          return ElemSelect(Op, DestIdx - CurrentBase);
        }

        return ElemSelect(Op);
      }

      CurrentBase += OpWidth;
    }

    return ElemSelect();
  }

  virtual EVT getValueType() const override { return BVN->getValueType(0); }

  virtual SDNode *getNode() const override { return BVN; }
};

// SDNode abstractions
struct ExtractSubvectorView : public MaskView {
  SDValue EVN;
  unsigned Offset;

  ExtractSubvectorView(SDValue EVN)
      : EVN(EVN),
        Offset(cast<const ConstantSDNode>(EVN.getOperand(1))->getZExtValue()) {}

  SDValue getSrc() const { return EVN.getOperand(0); }

  ElemSelect getSourceElem(unsigned DestIdx) override {
    return ElemSelect(getSrc(), DestIdx + Offset);
  }

  virtual EVT getValueType() const override { return EVN->getValueType(0); }

  virtual SDNode *getNode() const override { return EVN.getNode(); }
};

static SplitView splitBuildVector(BuildVectorSDNode &BVN, VECustomDAG &CDAG) {
  std::vector<SDValue> Inputs[2];

  for (unsigned Idx = 0; Idx < BVN.getNumOperands(); ++Idx) {
    PackElem Part = Idx % 2 == 0 ? PackElem::Hi : PackElem::Lo;
    unsigned PartIdx = (unsigned)Part;
    Inputs[PartIdx].push_back(BVN.getOperand(Idx));
  }

  EVT ElemVT = BVN.getValueType(0).getVectorElementType();
  EVT LoVecVT = CDAG.getVectorVT(ElemVT, Inputs[(int)PackElem::Lo].size());
  EVT HiVecVT = CDAG.getVectorVT(ElemVT, Inputs[(int)PackElem::Hi].size());

  SplitView Split;
  SDValue LoBVN =
      CDAG.getNode(ISD::BUILD_VECTOR, LoVecVT, Inputs[(int)PackElem::Lo]);
  Split.LoView.reset(requestMaskView(LoBVN.getNode()));
  SDValue HiBVN =
      CDAG.getNode(ISD::BUILD_VECTOR, HiVecVT, Inputs[(int)PackElem::Lo]);
  Split.HiView.reset(requestMaskView(HiBVN.getNode()));
  return Split;
}

struct SynthShuffle : public MaskView {
  SDNode *N;
  EVT VT;

  std::vector<ElemSelect> Mask;
  std::set<SDValue> SourceVecs;

  SynthShuffle(SDNode *N, EVT VT) : N(N), VT(VT) {}

  void pushSource(SDValue SrcV, int MaskIdx) {
    Mask.emplace_back(SrcV, MaskIdx);
    SourceVecs.insert(SrcV);
  }
  void pushUndef() { Mask.emplace_back(SDValue(), -1); }

  raw_ostream &print(raw_ostream &Out, SelectionDAG *DAG) const {
    Out << "SynthShuffle (" << Mask.size() << ") [\n";
    for (int i = 0; i < (int)Mask.size(); ++i) {
      auto E = Mask[i];
      if (!E.V)
        continue;
      Out << "\t" << i << " = " << E.ExtractIdx << " : ";
      E.V->print(Out, DAG);
      Out << "\n";
    }
    Out << "] SynthShuffle\n";
    return Out;
  }

  virtual SDNode *getNode() const override { return N; }

  // get the element selection at i
  virtual ElemSelect getSourceElem(unsigned DestIdx) override {
    return Mask[DestIdx];
  }

  // the abstracr type of this mask
  virtual EVT getValueType() const override { return VT; }

  virtual unsigned getNumElements() const override { return Mask.size(); }
};

static SplitView splitShuffleVector(ShuffleVectorSDNode &SVN,
                                    VECustomDAG &CDAG) {
  EVT OrigVT = SVN.getValueType(0);
  EVT LegalResVT = CDAG.legalizeVectorType(SDValue(&SVN, 0),
                                           VVPExpansionMode::ToNativeWidth);
  EVT LegalSplitVT = CDAG.splitVectorType(LegalResVT);
  unsigned NumEls = OrigVT.getVectorNumElements();

  SDValue LHS = SVN.getOperand(0);
  int NumLHSElems = LHS.getValueType().getVectorNumElements();
  SDValue RHS = SVN.getOperand(1);

  // SourcedPart x OriginalSrcV -> UnpackedPartFromOriginalSrcV
  std::map<std::pair<PackElem, SDValue>, SDValue> UnpackCache;

  SplitView Split;
  SDValue AVL = CDAG.getConstEVL(256);
  for (PackElem Part : {PackElem::Hi, PackElem::Lo}) {
    unsigned PartIdx = (unsigned)Part;
    SynthShuffle *Shuffle = new SynthShuffle(&SVN, LegalSplitVT);
    unsigned OffByOne = (Part == PackElem::Hi) ? NumEls % 2 : 0;
    unsigned PartNumEls = NumEls / 2 + OffByOne;
    // Scan through all positions, unpacking over-packed sources on the fly.
    for (unsigned i = 0; i < PartNumEls; ++i) {
      int SrcIdx = SVN.getMaskElt(2 * i + PartIdx);
      // Undef element.
      if (SrcIdx < 0) {
        Shuffle->pushUndef();
        continue;
      }

      // Decompose accessed element
      SDValue SrcVal = LHS;
      if (SrcIdx > NumLHSElems) {
        SrcIdx = SrcIdx - NumLHSElems;
        SrcVal = RHS;
      }
      PackElem SrcPart;
      if (SrcIdx % 2 == 0) {
        SrcPart = PackElem::Hi;
      } else {
        SrcPart = PackElem::Lo;
      }
      SrcIdx = SrcIdx / 2;

      // Unpack the operand vector.
      auto CacheKey = std::make_pair<>(SrcPart, SrcVal);
      auto ItCache = UnpackCache.find(CacheKey);
      SDValue UnpackedV;
      if (ItCache != UnpackCache.end())
        UnpackedV = ItCache->second;
      else {
        UnpackedV = CDAG.getUnpack(LegalSplitVT, SrcVal, SrcPart, AVL);
        UnpackCache[CacheKey] = UnpackedV;
      }

      // Materialize
      Shuffle->pushSource(UnpackedV, SrcIdx);
    }

    LLVM_DEBUG(Shuffle->print(errs(), CDAG.getDAG()););
    if (Part == PackElem::Lo)
      Split.LoView.reset(Shuffle);
    else
      Split.HiView.reset(Shuffle);
  }
  return Split;
}

SplitView requestSplitView(SDNode *N, VECustomDAG &CDAG) {
  auto BVN = dyn_cast<BuildVectorSDNode>(N);
  if (BVN)
    return splitBuildVector(*BVN, CDAG);

  auto SN = dyn_cast<ShuffleVectorSDNode>(N);
  if (SN)
    return splitShuffleVector(*SN, CDAG);

  return SplitView();
}

MaskView *requestMaskView(SDNode *N) {
  auto BVN = dyn_cast<BuildVectorSDNode>(N);
  if (BVN)
    return new BuildVectorView(BVN);
  auto SN = dyn_cast<ShuffleVectorSDNode>(N);
  if (SN)
    return new ShuffleVectorView(SN);
  if (N->getOpcode() == ISD::EXTRACT_SUBVECTOR)
    return new ExtractSubvectorView(SDValue(N, 0));
  return nullptr;
}

/// Simple Analysis {
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

  // std::optional<int64_t> InnerStrideOpt;
  // std::optional<int64_t> OuterStrideOpt
  // std::optional<unsigned> BlockSizeOpt;

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
/// } Simple Analysis

} // namespace llvm
