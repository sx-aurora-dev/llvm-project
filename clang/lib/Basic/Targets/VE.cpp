//===--- VE.cpp - Implement VE target feature support ---------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements VE TargetInfo objects.
//
//===----------------------------------------------------------------------===//

#include "VE.h"
#include "clang/Basic/Builtins.h"
#include "clang/Basic/MacroBuilder.h"
#include "clang/Basic/TargetBuiltins.h"

using namespace clang;
using namespace clang::targets;

const Builtin::Info VETargetInfo::BuiltinInfo[] = {
#define BUILTIN(ID, TYPE, ATTRS)                                               \
  {#ID, TYPE, ATTRS, nullptr, ALL_LANGUAGES, nullptr},
#define LIBBUILTIN(ID, TYPE, ATTRS, HEADER)                                    \
  {#ID, TYPE, ATTRS, HEADER, ALL_LANGUAGES, nullptr},
#include "clang/Basic/BuiltinsVE.def"
};

void VETargetInfo::getTargetDefines(const LangOptions &Opts,
                                       MacroBuilder &Builder) const {
  Builder.defineMacro("_LP64", "1");
  Builder.defineMacro("unix", "1");
  Builder.defineMacro("__unix__", "1");
  Builder.defineMacro("__linux__", "1");
  Builder.defineMacro("__ve", "1");
  Builder.defineMacro("__ve__", "1");
  Builder.defineMacro("__STDC_HOSTED__", "1");
  Builder.defineMacro("__STDC__", "1");
  Builder.defineMacro("__NEC__", "1");
  // FIXME: define __FAST_MATH__ 1 if -ffast-math is enabled
  // FIXME: define __OPTIMIZE__ n if -On is enabled
  // FIXME: define __VECTOR__ n 1 if automatic vectorization is enabled
}

ArrayRef<Builtin::Info> VETargetInfo::getTargetBuiltins() const {
  return llvm::makeArrayRef(BuiltinInfo, clang::VE::LastTSBuiltin -
                                         Builtin::FirstTSBuiltin);
}
