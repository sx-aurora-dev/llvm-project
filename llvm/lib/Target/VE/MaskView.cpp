#include "MaskView.h"
#include "CustomDAG.h"

#define DEBUG_TYPE "ve-maskview"

#include <set>

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

  virtual EVT getValueType() const override {
    return SN->getValueType(0);
  }
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

  virtual EVT getValueType() const override {
    return BVN->getValueType(0);
  }

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

  virtual EVT getValueType() const override {
    return EVN->getValueType(0);
  }

  virtual SDNode *getNode() const override { return EVN.getNode(); }
};

static SplitView splitBuildVector(BuildVectorSDNode &BVN, CustomDAG &CDAG) {
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

static SplitView splitShuffleVector(ShuffleVectorSDNode &SVN, CustomDAG &CDAG) {
  EVT OrigVT = SVN.getValueType(0);
  EVT LegalResVT = CDAG.legalizeVectorType(SDValue(&SVN, 0),
                                           VVPExpansionMode::ToNativeWidth);
  EVT LegalSplitVT = CDAG.getSplitVT(LegalResVT);
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
        UnpackedV = CDAG.CreateUnpack(LegalSplitVT, SrcVal, SrcPart, AVL);
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

SplitView requestSplitView(SDNode *N, CustomDAG &CDAG) {
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

} // namespace llvm
