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
#include "llvm/IR/MatcherCast.h"
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

  void copyIRFlags(const Value *V, bool IncludeWrapFlags) {
    cast<Instruction>(this)->copyIRFlags(V, IncludeWrapFlags);
  }

  BasicBlock *getParent() { return cast<Instruction>(this)->getParent(); }
  const BasicBlock *getParent() const {
    return cast<const Instruction>(this)->getParent();
  }

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

    if (!VPInst)
      return cast<Instruction>(this)->getOpcode();

    auto OC = VPInst->getFunctionalOpcode();

    return OC ? *OC : (unsigned) Instruction::Call;
  }

  bool isVectorReduction() const;

  static bool classof(const Instruction *I) { return isa<Instruction>(I); }
  static bool classof(const ConstantExpr *CE) { return false; }
  static bool classof(const Value *V) { return isa<Instruction>(V); }

  /// Convenience function for getting all the fast-math flags, which must be an
  /// operator which supports these flags. See LangRef.html for the meaning of
  /// these flags.
  FastMathFlags getFastMathFlags() const;
};

class PredicatedOperator : public User {
public:
  // The PredicatedOperator class is intended to be used as a utility, and is
  // never itself instantiated.
  PredicatedOperator() = delete;
  ~PredicatedOperator() = delete;

  void *operator new(size_t s) = delete;

  /// Return the opcode for this Instruction or ConstantExpr.
  unsigned getOpcode() const {
    auto *VPInst = dyn_cast<VPIntrinsic>(this);

    // Conceal the fp operation if it has non-default rounding mode or exception
    // behavior
    if (VPInst && !VPInst->isConstrainedOp()) {
      auto OC = VPInst->getFunctionalOpcode();
      return OC ? *OC : (unsigned) Instruction::Call;
    }

    if (const Instruction *I = dyn_cast<Instruction>(this))
      return I->getOpcode();

    return cast<ConstantExpr>(this)->getOpcode();
  }

  Value *getMask() const {
    auto thisVP = dyn_cast<VPIntrinsic>(this);
    if (!thisVP)
      return nullptr;
    return thisVP->getMaskParam();
  }

  Value *getVectorLength() const {
    auto thisVP = dyn_cast<VPIntrinsic>(this);
    if (!thisVP)
      return nullptr;
    return thisVP->getVectorLengthParam();
  }

  void copyIRFlags(const Value *V, bool IncludeWrapFlags = true);
  FastMathFlags getFastMathFlags() const {
    auto *I = dyn_cast<Instruction>(this);
    if (I)
      return I->getFastMathFlags();
    else
      return FastMathFlags();
  }

  static bool classof(const Instruction *I) {
    return isa<VPIntrinsic>(I) || isa<Operator>(I);
  }
  static bool classof(const ConstantExpr *CE) { return isa<Operator>(CE); }
  static bool classof(const Value *V) {
    return isa<VPIntrinsic>(V) || isa<Operator>(V);
  }
};

class PredicatedUnaryOperator : public PredicatedOperator {
public:
  // The PredicatedUnaryOperator class is intended to be used as a utility, and
  // is never itself instantiated.
  PredicatedUnaryOperator() = delete;
  ~PredicatedUnaryOperator() = delete;

  using UnaryOps = Instruction::UnaryOps;

  void *operator new(size_t s) = delete;

  static bool classof(const Instruction *I) {
    if (isa<UnaryOperator>(I))
      return true;
    auto VPInst = dyn_cast<VPIntrinsic>(I);
    return VPInst && VPInst->isUnaryOp();
  }
  static bool classof(const ConstantExpr *CE) {
    return isa<UnaryOperator>(CE);
  }
  static bool classof(const Value *V) {
    auto *I = dyn_cast<Instruction>(V);
    if (I && classof(I))
      return true;
    auto *CE = dyn_cast<ConstantExpr>(V);
    return CE && classof(CE);
  }

  /// Construct a predicated binary instruction, given the opcode and the two
  /// operands.
  static Instruction *Create(Module *Mod, Value *Mask, Value *VectorLen,
                             Instruction::UnaryOps Opc, Value *V,
                             const Twine &Name, BasicBlock *InsertAtEnd,
                             Instruction *InsertBefore);

  static Instruction *Create(Module *Mod, Value *Mask, Value *VectorLen,
                             UnaryOps Opc, Value *V,
                             const Twine &Name = Twine(),
                             Instruction *InsertBefore = nullptr) {
    return Create(Mod, Mask, VectorLen, Opc, V, Name, nullptr,
                  InsertBefore);
  }

  static Instruction *Create(Module *Mod, Value *Mask, Value *VectorLen,
                             UnaryOps Opc, Value *V,
                             const Twine &Name, BasicBlock *InsertAtEnd) {
    return Create(Mod, Mask, VectorLen, Opc, V, Name, InsertAtEnd,
                  nullptr);
  }

  static Instruction *CreateWithCopiedFlags(Module *Mod, Value *Mask,
                                            Value *VectorLen, UnaryOps Opc,
                                            Value *V,
                                            Instruction *CopyBO,
                                            const Twine &Name = "") {
    Instruction *BO =
        Create(Mod, Mask, VectorLen, Opc, V, Name, nullptr, nullptr);
    BO->copyIRFlags(CopyBO);
    return BO;
  }
};

class PredicatedBinaryOperator : public PredicatedOperator {
public:
  // The PredicatedBinaryOperator class is intended to be used as a utility, and
  // is never itself instantiated.
  PredicatedBinaryOperator() = delete;
  ~PredicatedBinaryOperator() = delete;

  using BinaryOps = Instruction::BinaryOps;

  void *operator new(size_t s) = delete;

  static bool classof(const Instruction *I) {
    if (isa<BinaryOperator>(I))
      return true;
    auto VPInst = dyn_cast<VPIntrinsic>(I);
    return VPInst && VPInst->isBinaryOp();
  }
  static bool classof(const ConstantExpr *CE) {
    return isa<BinaryOperator>(CE);
  }
  static bool classof(const Value *V) {
    auto *I = dyn_cast<Instruction>(V);
    if (I && classof(I))
      return true;
    auto *CE = dyn_cast<ConstantExpr>(V);
    return CE && classof(CE);
  }

  /// Construct a predicated binary instruction, given the opcode and the two
  /// operands.
  static Instruction *Create(Module *Mod, Value *Mask, Value *VectorLen,
                             Instruction::BinaryOps Opc, Value *V1, Value *V2,
                             const Twine &Name, BasicBlock *InsertAtEnd,
                             Instruction *InsertBefore);

  static Instruction *Create(Module *Mod, Value *Mask, Value *VectorLen,
                             BinaryOps Opc, Value *V1, Value *V2,
                             const Twine &Name = Twine(),
                             Instruction *InsertBefore = nullptr) {
    return Create(Mod, Mask, VectorLen, Opc, V1, V2, Name, nullptr,
                  InsertBefore);
  }

  static Instruction *Create(Module *Mod, Value *Mask, Value *VectorLen,
                             BinaryOps Opc, Value *V1, Value *V2,
                             const Twine &Name, BasicBlock *InsertAtEnd) {
    return Create(Mod, Mask, VectorLen, Opc, V1, V2, Name, InsertAtEnd,
                  nullptr);
  }

  static Instruction *CreateWithCopiedFlags(Module *Mod, Value *Mask,
                                            Value *VectorLen, BinaryOps Opc,
                                            Value *V1, Value *V2,
                                            Instruction *CopyBO,
                                            const Twine &Name = "") {
    Instruction *BO =
        Create(Mod, Mask, VectorLen, Opc, V1, V2, Name, nullptr, nullptr);
    BO->copyIRFlags(CopyBO);
    return BO;
  }
};

class PredicatedICmpInst : public PredicatedBinaryOperator {
public:
  // The Operator class is intended to be used as a utility, and is never itself
  // instantiated.
  PredicatedICmpInst() = delete;
  ~PredicatedICmpInst() = delete;

  void *operator new(size_t s) = delete;

  static bool classof(const Instruction *I) {
    if (isa<ICmpInst>(I))
      return true;
    auto VPInst = dyn_cast<VPIntrinsic>(I);
    if (!VPInst)
      return false;
    auto OC = VPInst->getFunctionalOpcode();
    return OC && (*OC == Instruction::ICmp);
  }
  static bool classof(const ConstantExpr *CE) {
    return CE->getOpcode() == Instruction::ICmp;
  }
  static bool classof(const Value *V) {
    auto *I = dyn_cast<Instruction>(V);
    if (I && classof(I))
      return true;
    auto *CE = dyn_cast<ConstantExpr>(V);
    return CE && classof(CE);
  }

  ICmpInst::Predicate getPredicate() const {
    auto *ICInst = dyn_cast<const ICmpInst>(this);
    if (ICInst)
      return ICInst->getPredicate();
    auto *CE = dyn_cast<const ConstantExpr>(this);
    if (CE)
      return static_cast<ICmpInst::Predicate>(CE->getPredicate());
    return static_cast<ICmpInst::Predicate>(
        cast<VPIntrinsic>(this)->getCmpPredicate());
  }
};

class PredicatedFCmpInst : public PredicatedBinaryOperator {
public:
  // The Operator class is intended to be used as a utility, and is never itself
  // instantiated.
  PredicatedFCmpInst() = delete;
  ~PredicatedFCmpInst() = delete;

  void *operator new(size_t s) = delete;

  static bool classof(const Instruction *I) {
    if (isa<FCmpInst>(I))
      return true;
    auto VPInst = dyn_cast<VPIntrinsic>(I);
    if (!VPInst)
      return false;
    auto OC = VPInst->getFunctionalOpcode();
    return OC && (*OC == Instruction::FCmp);
  }
  static bool classof(const ConstantExpr *CE) {
    return CE->getOpcode() == Instruction::FCmp;
  }
  static bool classof(const Value *V) {
    auto *I = dyn_cast<Instruction>(V);
    if (I && classof(I))
      return true;
    return isa<ConstantExpr>(V);
  }

  FCmpInst::Predicate getPredicate() const {
    auto *FCInst = dyn_cast<const FCmpInst>(this);
    if (FCInst)
      return FCInst->getPredicate();
    auto *CE = dyn_cast<const ConstantExpr>(this);
    if (CE)
      return static_cast<FCmpInst::Predicate>(CE->getPredicate());
    return static_cast<FCmpInst::Predicate>(
        cast<VPIntrinsic>(this)->getCmpPredicate());
  }
};

class PredicatedSelectInst : public PredicatedOperator {
public:
  // The Operator class is intended to be used as a utility, and is never itself
  // instantiated.
  PredicatedSelectInst() = delete;
  ~PredicatedSelectInst() = delete;

  void *operator new(size_t s) = delete;

  static bool classof(const Instruction *I) {
    if (isa<SelectInst>(I))
      return true;
    auto VPInst = dyn_cast<VPIntrinsic>(I);
    if (!VPInst)
      return false;
    auto OC = VPInst->getFunctionalOpcode();
    return OC && (*OC == Instruction::Select);
  }
  static bool classof(const ConstantExpr *CE) {
    return CE->getOpcode() == Instruction::Select;
  }
  static bool classof(const Value *V) {
    auto *I = dyn_cast<Instruction>(V);
    if (I && classof(I))
      return true;
    auto *CE = dyn_cast<ConstantExpr>(V);
    return CE && CE->getOpcode() == Instruction::Select;
  }

  const Value *getCondition() const { return getOperand(0); }
  const Value *getTrueValue() const { return getOperand(1); }
  const Value *getFalseValue() const { return getOperand(2); }
  Value *getCondition() { return getOperand(0); }
  Value *getTrueValue() { return getOperand(1); }
  Value *getFalseValue() { return getOperand(2); }

  void setCondition(Value *V) { setOperand(0, V); }
  void setTrueValue(Value *V) { setOperand(1, V); }
  void setFalseValue(Value *V) { setOperand(2, V); }
};

namespace PatternMatch {

// PredicatedMatchContext for pattern matching
struct PredicatedContext {
  static constexpr bool IsEmpty = false;

  Value *Mask;
  Value *VectorLength;
  Module *Mod;

  void reset(Value *V) {
    auto *PI = dyn_cast<PredicatedInstruction>(V);
    if (!PI) {
      VectorLength = nullptr;
      Mask = nullptr;
      return;
    }
    VectorLength = PI->getVectorLengthParam();
    Mask = PI->getMaskParam();

    if (Mod) return;

    // try to get a hold of the Module
    auto *BB = PI->getParent();
    if (BB) {
      auto *Func = BB->getParent();
      if (Func) {
        Mod = Func->getParent();
      }
    }

    if (Mod) return;

    // try to infer the module from a call
    auto CallI = dyn_cast<CallInst>(V);
    if (CallI && CallI->getCalledFunction()) {
      Mod = CallI->getCalledFunction()->getParent();
    }
  }

  PredicatedContext(Value *Val)
      : Mask(nullptr), VectorLength(nullptr), Mod(nullptr) {
    reset(Val);
  }

  PredicatedContext(const PredicatedContext &PC)
  : Mask(PC.Mask), VectorLength(PC.VectorLength), Mod(PC.Mod) {}

  /// accept a match where \p Val is in a non-leaf position in a match pattern
  bool acceptInnerNode(const Value *Val) const {
    auto PredI = dyn_cast<PredicatedInstruction>(Val);
    if (!PredI)
      return VectorLength == nullptr && Mask == nullptr;
    return VectorLength == PredI->getVectorLengthParam() &&
           Mask == PredI->getMaskParam();
  }

  /// accept a match where \p Val is bound to a free variable.
  bool acceptBoundNode(const Value *Val) const { return true; }

  /// whether this context is compatiable with \p E.
  bool acceptContext(PredicatedContext PC) const {
    return std::tie(PC.Mask, PC.VectorLength) == std::tie(Mask, VectorLength);
  }

  /// merge the context \p E into this context and return whether the resulting
  /// context is valid.
  bool mergeContext(PredicatedContext PC) const { return acceptContext(PC); }

  /// match \p P in a new contesx for \p Val.
  template <typename Val, typename Pattern>
  bool reset_match(Val *V, const Pattern &P) {
    reset(V);
    return const_cast<Pattern &>(P).match_context(V, *this);
  }

  /// match \p P in the current context.
  template <typename Val, typename Pattern>
  bool try_match(Val *V, const Pattern &P) {
    PredicatedContext SubContext(*this);
    return const_cast<Pattern &>(P).match_context(V, SubContext);
  }
};

struct PredicatedContext;
template <> struct MatcherCast<PredicatedContext, BinaryOperator> {
  using ActualCastType = PredicatedBinaryOperator;
};
template <> struct MatcherCast<PredicatedContext, Operator> {
  using ActualCastType = PredicatedOperator;
};
template <> struct MatcherCast<PredicatedContext, ICmpInst> {
  using ActualCastType = PredicatedICmpInst;
};
template <> struct MatcherCast<PredicatedContext, FCmpInst> {
  using ActualCastType = PredicatedFCmpInst;
};
template <> struct MatcherCast<PredicatedContext, SelectInst> {
  using ActualCastType = PredicatedSelectInst;
};
template <> struct MatcherCast<PredicatedContext, Instruction> {
  using ActualCastType = PredicatedInstruction;
};

} // namespace PatternMatch

} // namespace llvm

#endif // LLVM_IR_PREDICATEDINST_H
