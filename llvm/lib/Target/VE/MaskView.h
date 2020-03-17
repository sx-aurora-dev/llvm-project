#ifndef TARGET_VE_MASKVIEW_H
#define TARGET_VE_MASKVIEW_H

#include "llvm/CodeGen/SelectionDAG.h"

namespace llvm {

struct ElemSelect {
  SDValue V;          // the value that is chosen
  int64_t ExtractIdx; // whether (>=0) this indicates element extraction

  // Undef ctor
  ElemSelect() : V(), ExtractIdx(0) {}

  // insertion from scalar
  ElemSelect(SDValue V) : V(V), ExtractIdx(-1) {}

  // elem transfer of V
  ElemSelect(SDValue V, int64_t ExtractIdx) : V(V), ExtractIdx(ExtractIdx) {}

  bool isDefined() const { return ((bool)V) && !V.isUndef(); }

  // element of V transfered from dest
  bool isElemTransfer() const { return ExtractIdx >= 0; }
  // V as a whole inserted into dest
  bool isElemInsert() const { return ExtractIdx < 0; }
};

struct MaskView {

  virtual ~MaskView() {}

  // get the element selection at i
  virtual ElemSelect getSourceElem(unsigned DestIdx) = 0;
};

MaskView *requestMaskView(SDNode *N);

} // namespace llvm

#endif // TARGET_VE_MASKVIEW_H
