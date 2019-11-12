//===-- llvm/PredicatedInst.h - Predication utility subclass --*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines various classes for working with predicated instructions.
// Predicated instructions are either regular instructions or calls to
// Vector Predication (VP) intrinsics that have a mask and an explicit
// vector length argument.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_IR_PREDICATEDINST_H
#define LLVM_IR_PREDICATEDINST_H

#include "llvm/ADT/None.h"
#include "llvm/ADT/Optional.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/Operator.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/Value.h"
#include "llvm/Support/Casting.h"

#include <cstddef>

namespace llvm {

class BasicBlock;

class PredicatedInstruction : public User {
public:
  // The PredicatedInstruction class is intended to be used as a utility, and is
  // never itself instantiated.
  PredicatedInstruction() = delete;
  ~PredicatedInstruction() = delete;

  void *operator new(size_t s) = delete;

  Value *getMaskParam() const {
    auto thisVP = dyn_cast<VPIntrinsic>(this);
    if (!thisVP)
      return nullptr;
    return thisVP->getMaskParam();
  }

  Value *getVectorLengthParam() const {
    auto thisVP = dyn_cast<VPIntrinsic>(this);
    if (!thisVP)
      return nullptr;
    return thisVP->getVectorLengthParam();
  }

  /// \returns True if the passed vector length value has no predicating effect
  /// on the op.
  bool canIgnoreVectorLengthParam() const;

  /// \return True if the static operator of this instruction has a mask or
  /// vector length parameter.
  bool isVectorPredicatedOp() const { return isa<VPIntrinsic>(this); }

  /// \returns the effective Opcode of this operation (ignoring the mask and
  /// vector length param).
  unsigned getOpcode() const {
    auto *VPInst = dyn_cast<VPIntrinsic>(this);

    if (!VPInst) {
      return cast<Instruction>(this)->getOpcode();
    }

    return VPInst->getFunctionalOpcode();
  }

  static bool classof(const Instruction *I) { return isa<Instruction>(I); }
  static bool classof(const ConstantExpr *CE) { return false; }
  static bool classof(const Value *V) { return isa<Instruction>(V); }

  /// Convenience function for getting all the fast-math flags, which must be an
  /// operator which supports these flags. See LangRef.html for the meaning of
  /// these flags.
  FastMathFlags getFastMathFlags() const;
};

} // namespace llvm

#endif // LLVM_IR_PREDICATEDINST_H
