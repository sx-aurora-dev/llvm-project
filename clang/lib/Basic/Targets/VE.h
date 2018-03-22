//===--- VE.h - Declare VE target feature support ---------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file declares VE TargetInfo objects.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_CLANG_LIB_BASIC_TARGETS_VE_H
#define LLVM_CLANG_LIB_BASIC_TARGETS_VE_H

#include "clang/Basic/TargetInfo.h"
#include "clang/Basic/TargetOptions.h"
#include "llvm/ADT/Triple.h"
#include "llvm/Support/Compiler.h"

namespace clang {
namespace targets {

class LLVM_LIBRARY_VISIBILITY VETargetInfo : public TargetInfo {
  static const Builtin::Info BuiltinInfo[];

public:
  VETargetInfo(const llvm::Triple &Triple, const TargetOptions &)
      : TargetInfo(Triple) {
    NoAsmVariants = true;
    LongDoubleWidth = 128;
    LongDoubleAlign = 128;
    LongDoubleFormat = &llvm::APFloat::IEEEquad();
    DoubleAlign = LongLongAlign = 64;
    SuitableAlign = 64;
    LongWidth = LongAlign = PointerWidth = PointerAlign = 64;
    SizeType = UnsignedLong;
    PtrDiffType = SignedLong;
    IntPtrType = SignedLong;
    IntMaxType = SignedLong;
    Int64Type = SignedLong;
    RegParmMax = 8;

    WCharType = UnsignedInt;
    WIntType = UnsignedInt;
    UseZeroLengthBitfieldAlignment = true;
    resetDataLayout("e-m:e-i64:64-n32:64-S64");
  }

  void getTargetDefines(const LangOptions &Opts,
                        MacroBuilder &Builder) const override;

  ArrayRef<Builtin::Info> getTargetBuiltins() const override;

  BuiltinVaListKind getBuiltinVaListKind() const override {
    return TargetInfo::VoidPtrBuiltinVaList;
  }

  const char *getClobbers() const override { return ""; }

  ArrayRef<const char *> getGCCRegNames() const override {
    static const char *const GCCRegNames[] = {
        "s0",  "s1",  "s2",  "s3",  "s4",  "s5",  "s6",  "s7",
        "sl",  "fp",  "lr",  "sp", "s12", "s13",  "tp", "got",
       "plt", "s17", "s18", "s19", "s20", "s21", "s22", "s23",
       "s24", "s25", "s26", "s27", "s28", "s29", "s30", "s31",
       "s32", "s33", "s34", "s35", "s36", "s37", "s38", "s39",
       "s40", "s41", "s42", "s43", "s44", "s45", "s46", "s47",
       "s48", "s49", "s50", "s51", "s52", "s53", "s54", "s55",
       "s56", "s57", "s58", "s59", "s60", "s61", "s62", "s63",
    };
    return llvm::makeArrayRef(GCCRegNames);
  }

  ArrayRef<TargetInfo::GCCRegAlias> getGCCRegAliases() const override {
    return None;
  }

  bool validateAsmConstraint(const char *&Name,
                             TargetInfo::ConstraintInfo &Info) const override {
    return false;
  }

  int getEHDataRegisterNumber(unsigned RegNo) const override {
    // R0=ExceptionPointerRegister R1=ExceptionSelectorRegister
    return (RegNo < 2) ? RegNo : -1;
  }

  bool allowsLargerPreferedTypeAlignment() const override { return false; }
};
} // namespace targets
} // namespace clang
#endif // LLVM_CLANG_LIB_BASIC_TARGETS_VE_H
