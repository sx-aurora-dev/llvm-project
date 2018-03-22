//===-- VETargetInfo.cpp - VE Target Implementation -----------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "VE.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/TargetRegistry.h"
using namespace llvm;

Target &llvm::getTheVETarget() {
  static Target TheVETarget;
  return TheVETarget;
}

extern "C" void LLVMInitializeVETargetInfo() {
  RegisterTarget<Triple::ve, /*HasJIT=*/false> X(getTheVETarget(), "ve",
                                                 "VE", "VE");
}
