//===-- VEISelLowering.h - VE DAG Lowering Interface ------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines the interfaces that VE uses to lower LLVM code into a
// selection DAG.
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

#ifndef DEBUG_TYPE
#define DEBUG_TYPE "shuffleanalysis"
#endif

namespace llvm {

struct ElemSelect {
  SDValue V;          // the value that is chosen
  int64_t ExtractIdx; // whether (>=0) this indicates element extraction

  // insertion from scalar
  ElemSelect(SDValue V) : V(V), ExtractIdx(-1) {}

  // elem transfer of V
  ElemSelect(SDValue V, int64_t ExtractIdx) : V(V), ExtractIdx(ExtractIdx) {}

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

    abort(); // invalid SN
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

    abort(); // invalid BVN
  }
};

static MaskView *requestMaskView(SDNode *N) {
  auto BVN = dyn_cast<BuildVectorSDNode>(N);
  if (BVN)
    return new BuildVectorView(BVN);
  auto SN = dyn_cast<ShuffleVectorSDNode>(N);
  if (SN)
    return new ShuffleVectorView(SN);
  return nullptr;
}


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
          assert(ES.isElemTransfer() && "TODO implement shuffle-in of scalars");

          // skip undef
          if (ES.V.isUndef()) {
            DefinedBits[i] = true;
            NumMissingBits--;
          }

          // map a new source (and a shift amount)
          unsigned SrcPartIdx =
              (ES.ExtractIdx / SXRegSize); // sx sub-register to chose from
          int64_t ShiftAmount =
              (ES.ExtractIdx % SXRegSize) -
              i; // required shift amount of the elements of the sub register
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
        Part.Selects.push_back(Sel);
      }

      LLVM_DEBUG( Part.print(dbgs()); );
      Segments.push_back(Part);
    }
  }

  SDValue synthesize(SDValue Passthru, BitSelect &BSel, SDValue SXV, CustomDAG &CDAG) {
    const uint64_t AllSetMask = (uint64_t) -1;

    // match full register copies
    if ((BSel.SrcSelMask == AllSetMask) && (BSel.ShiftAmount == 0)) {
      return SXV;
    }
    
    abort(); // TODO implement shifting and stuff
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

// decompose shuffle masks into digestible chunks
// template<typename SegmentMatcher>
// class ShuffleAnalysis {
//   SegmentMatcher &SegM;
//
// public:
//   ShuffleAnalysis(SegmentMatcher & SegM) {}
//
//   void analyze(ShuffleVectorSDNode* ShufN) {
//     unsigned NumElems = ShufN->getValueType(0).getVectorNumElements();
//
//     std::vector<bool> MatchedBits(NumElems, false);
//
//     ArrayRef<int> Mask = ShufN->getMask();
//     unsigned FirstIdx = 0;
//     while (FirstIdx < NumElems) {
//       bool OK = SegM.matchSegment(Mask, FirstIdx, MatchedBits);
//     }
//
//     abort();
//   }
// };

} // namespace llvm

#endif // LLVM_LIB_TARGET_VE_SHUFFLEANALYSIS_H
