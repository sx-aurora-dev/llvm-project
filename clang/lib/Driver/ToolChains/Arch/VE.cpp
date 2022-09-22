//===--- VE.cpp - Tools Implementations -------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "VE.h"
#include "clang/Driver/Driver.h"
#include "clang/Driver/DriverDiagnostic.h"
#include "clang/Driver/Options.h"
#include "llvm/Option/ArgList.h"

using namespace clang::driver;
using namespace clang::driver::tools;
using namespace clang;
using namespace llvm::opt;

void ve::getVETargetFeatures(const Driver &D, const ArgList &Args,
                             std::vector<StringRef> &Features) {
  // Defaults.
  bool EnableVPU = true;
  bool EnableSIMD = false;

  // Whether to enable VPU registers and isel.
  if (auto *A = Args.getLastArg(options::OPT_mvevpu, options::OPT_mno_vevpu)) {
    if (A->getOption().matches(options::OPT_mno_vevpu))
      EnableVPU = false;
  }

  // Whether to enable fixed-SIMD patterns
  if (auto *A =
          Args.getLastArg(options::OPT_mvesimd, options::OPT_mno_vesimd)) {
    if (A->getOption().matches(options::OPT_mvesimd)) {
      EnableSIMD = true;
      EnableVPU = false;
    }
  }

  // Fixed SIMD
  if (EnableSIMD) {
    Features.push_back("-vpu");
    Features.push_back("+simd");
    return;
  }

  // VVP
  if (EnableVPU)
    Features.push_back("+vpu");
}
