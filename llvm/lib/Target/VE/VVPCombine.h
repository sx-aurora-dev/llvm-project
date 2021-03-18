//===-- CustomDAG.h - VE Custom DAG Nodes ------------*- C++ -*-===//
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

#ifndef LLVM_LIB_TARGET_VE_VVPCOMBINE_H
#define LLVM_LIB_TARGET_VE_VVPCOMBINE_H

#include "llvm/CodeGen/SelectionDAG.h"
#include "CustomDAG.h"

namespace llvm {
  SDValue match_ReplLoHi(SDValue N, PackElem &SrcElem);

  // Simplify unpack.
  SDValue combineUnpackLoHi(CustomDAG &CDAG, SDNode *N);
  SDValue combineUnpackLoHi(SDValue PackedVec, PackElem UnpackPart, EVT DestVT, SDValue AVL, const CustomDAG &CDAG);

  bool match_FPOne(SDValue V);
  SDValue getSplatValue(SDNode *N);

} // namespace llvm

#endif // LLVM_LIB_TARGET_VE_CUSTOMDAG_H
