//==- llvm/NOELLE/PDG/PDG.h - PDG Construction -*- C++ -*-==//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// PDG Analysis Pass
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_NOELLE_PDG_PDGANALYSIS_H
#define LLVM_NOELLE_PDG_PDGANALYSIS_H

#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"

#include "llvm/NOELLE/PDG/PDG.h"

using namespace noelle;

namespace llvm {

class Loop;

// Cheating the PM because we can't normally return a pointer.
class PDGAnalysisResult {
public:
  PDGAnalysisResult(PDG *pdg_) : pdg(pdg_) {}
  PDG *getPDG() { return pdg; }

private:
  PDG *pdg;
};

class PDGAnalysis : public AnalysisInfoMixin<PDGAnalysis> {
  friend AnalysisInfoMixin<PDGAnalysis>;
  static AnalysisKey Key;

public:
  typedef PDGAnalysisResult Result;

  PDGAnalysisResult run(Module &M, ModuleAnalysisManager &MAM);
};

/// Prints PDG in .dot files. Used for visualization.
class PDGDotPrinter : public PassInfoMixin<PDGDotPrinter> {
public:
  llvm::PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM);
};

/// Prints PDG in .dot files. Used for lit-based tests.
class PDGTextPrinter : public PassInfoMixin<PDGTextPrinter> {
public:
  explicit PDGTextPrinter(llvm::raw_ostream &os_) : os(os_) {}
  llvm::PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM);

private:
  llvm::raw_ostream &os;
};

} // namespace llvm

#endif // LLVM_NOELLE_PDG_PDGANALYSIS_H