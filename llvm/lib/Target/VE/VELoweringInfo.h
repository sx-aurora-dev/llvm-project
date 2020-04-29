//===-- VELoweringInfo.h - VE DAG Lowering Interface ------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file provides an abstract interface to expose select legalization
// methods to *VE-internal* users, most importantly the CustomDAG.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_VE_VELOWERINGINFO_H
#define LLVM_LIB_TARGET_VE_VELOWERINGINFO_H

#include "llvm/CodeGen/SelectionDAG.h"
#include "llvm/CodeGen/TargetLowering.h"

namespace llvm {

// Describes which result type should be used in custom widening
// When replacing nodes in ReplaceNodeResults we have to respect the next legal
// vector type as dictated by ISel (ToNextWidth) In LowerOperation, we are free
// to pick the correct type directly (ToNativeWidth).
enum class VVPExpansionMode : int8_t {
  ToNextWidth = 0,
  // for use in result type legalization - expand to the next expected result
  // size

  ToNativeWidth = 1
  // for use in LowerOperation -> directly expand to the expanded width
};

class VELoweringInfo {
public:
  virtual EVT LegalizeVectorType(EVT ResTy, SDValue Op, SelectionDAG &DAG,
                                 VVPExpansionMode) const = 0;
  virtual ~VELoweringInfo() {}
};

} // namespace llvm

#endif // LLVM_LIB_TARGET_VE_VEISELLOWERING_H
