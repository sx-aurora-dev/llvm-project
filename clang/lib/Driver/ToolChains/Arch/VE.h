//===--- VE.h - VE-specific Tool Helpers ------------------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_CLANG_LIB_DRIVER_TOOLCHAINS_ARCH_VE_H
#define LLVM_CLANG_LIB_DRIVER_TOOLCHAINS_ARCH_VE_H

#include "clang/Driver/Driver.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Option/Option.h"
#include <string>
#include <vector>

namespace clang {
namespace driver {
namespace tools {
namespace ve {

enum class FloatABI {
  Invalid,
  Soft,
  Hard,
};

FloatABI getVEFloatABI(const Driver &D, const llvm::opt::ArgList &Args);

void getVETargetFeatures(const Driver &D, const llvm::opt::ArgList &Args,
                            std::vector<llvm::StringRef> &Features);
const char *getVEAsmModeForCPU(llvm::StringRef Name,
                                  const llvm::Triple &Triple);

} // end namespace ve
} // end namespace target
} // end namespace driver
} // end namespace clang

#endif // LLVM_CLANG_LIB_DRIVER_TOOLCHAINS_ARCH_VE_H
