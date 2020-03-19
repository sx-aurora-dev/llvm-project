#include "MaskView.h"

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
};

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
