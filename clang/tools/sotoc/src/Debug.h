//===-- sotoc/src/main.cpp ------------------------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
///
/// \file
/// This file defines a debug macro for sotoc
///
//===----------------------------------------------------------------------===//

#pragma once

#include "llvm/Support/FormatVariadic.h"
#include "llvm/Support/raw_ostream.h"

#ifdef SOTOC_DEBUG
extern int SotocDebugLevel;

#define DEBUGP(...)                                                            \
  do {                                                                         \
    if (SotocDebugLevel > 0) {                                                 \
      llvm::errs() << "Sotoc: " << __VA_ARGS__;                                \
      llvm::errs() << "\n";                                                    \
    }                                                                          \
  } while (false)

#define DEBUGPDECL(decl, ...)                                                  \
  do {                                                                         \
    if (SotocDebugLevel > 0) {                                                 \
      llvm::errs() << "Sotoc: " << llvm::formatv(__VA_ARGS__);                 \
      decl->print(llvm::errs());                                               \
      llvm::errs() << "\n";                                                    \
    }                                                                          \
  } while (false)

#else // OMPTARGET_DEBUG
#define DEBUGP(...)                                                            \
  {}
#define DEBUGPDECL(...)                                                        \
  {}
#endif // OMPTARGET_DEBUG
