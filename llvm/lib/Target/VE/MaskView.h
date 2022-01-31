#ifndef TARGET_VE_MASKVIEW_H
#define TARGET_VE_MASKVIEW_H

#include "llvm/CodeGen/SelectionDAG.h"
#include <functional>

namespace llvm {

struct VECustomDAG;

struct ElemSelect {
  SDValue V;          // the value that is chosen
  int64_t ExtractIdx; // whether (>=0) this indicates element extraction

  // (explicit) undef construction
  static ElemSelect Undef() { return ElemSelect(); }

  // (implicit) Undef ctor
  ElemSelect() : V(), ExtractIdx(0) {}

  // insertion from scalar
  ElemSelect(SDValue V) : V(V), ExtractIdx(-1) {}

  // elem transfer of V
  ElemSelect(SDValue V, int64_t ExtractIdx) : V(V), ExtractIdx(ExtractIdx) {}

  bool isDefined() const { return ((bool)V) && !V.isUndef(); }

  unsigned getElemIdx() const {
    assert(isElemTransfer());
    return ExtractIdx;
  }

  // element of V transfered from dest
  bool isElemTransfer() const { return ExtractIdx >= 0; }
  // V as a whole inserted into dest
  bool isElemInsert() const { return ExtractIdx < 0; }

  bool operator==(const ElemSelect &ES) const {
    if (!isDefined() && !ES.isDefined())
      return true;
    if (isDefined() != ES.isDefined())
      return false;
    return (ES.V == V) && (ExtractIdx == ES.ExtractIdx);
  }
  bool operator!=(const ElemSelect &ES) const { return !(*this == ES); }

  raw_ostream &print(raw_ostream &out) const {
    if (isElemTransfer()) {
      out << "Trans Idx: " << ExtractIdx << ", From: ";
      V->print(dbgs());
    } else {
      out << "Insert: ";
      V->print(dbgs());
    }
    return out;
  }
};

struct MaskView {
  virtual SDNode *getNode() const { return nullptr; }
  virtual ~MaskView() {}

  // get the element selection at i
  virtual ElemSelect getSourceElem(unsigned DestIdx) = 0;

  // the abstracr type of this mask
  virtual EVT getValueType() const = 0;

  virtual unsigned getNumElements() const {
    return getValueType().getVectorNumElements();
  }
};

struct SplitView {
  std::unique_ptr<MaskView> LoView;
  std::unique_ptr<MaskView> HiView;

  bool isValid() const { return LoView && HiView; }
};

SplitView requestSplitView(SDNode *N, VECustomDAG &CDAG);

MaskView *requestMaskView(SDNode *N);

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
                       unsigned &NumElements);

enum class BVMaskKind : int8_t {
  Unknown,  // could not infer mask pattern
  Interval, //  interval of all-ones
};

BVMaskKind AnalyzeBitMaskView(MaskView &MV, unsigned &FirstOne,
                              unsigned &FirstZero, unsigned &NumElements);

} // namespace llvm

// custom specialization of std::hash can be injected in namespace std
namespace std {
template <> struct hash<llvm::ElemSelect> {
  std::size_t operator()(llvm::ElemSelect const &ES) const noexcept {
    return ((std::size_t)ES.V.getNode()) ^ ES.ExtractIdx;
  }
};
} // namespace std

#endif // TARGET_VE_MASKVIEW_H
