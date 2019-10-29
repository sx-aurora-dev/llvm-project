//===-- sotoc/src/OmpPragma.h ---------------------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#pragma once

#include "clang/AST/OpenMPClause.h"
#include "clang/AST/StmtOpenMP.h"
#include "llvm/ADT/APInt.h"
#include "llvm/Support/raw_ostream.h"

#include "TargetCodeFragment.h"

/// A helper class to rewrite some "pragma omp" (mostly teams and similar
/// combined constructs), which are not supported by sotoc.
/// We currently only support one team to be run on the target because ncc does
/// not support 'freestanding' teams. So we need to remove teams and
/// distribute constructs from the generated target code. But teams constructs
/// can also appear in combined constructs. These combined constructs cannot
/// simply be removed, they must be replace by "non-team" equivalents to
/// preserve correctness.
/// This class provides helper functions that finds a suitable replacement for
/// omp pragmas that contain teams constructs.
/// It is used during code generation: The omp pragma of each target region
/// that is declared as part of a combined construct and each pragma found
/// during pretty printing is encapsulated by an object of this class which is
/// then used to generate a replacement.
class OmpPragma {
  clang::PrintingPolicy PP;
  llvm::ArrayRef<clang::OMPClause *> Clauses;
  clang::OpenMPDirectiveKind Kind;

public:
  OmpPragma(TargetCodeRegion *TCR)
      : PP(TCR->getPP()), Clauses(TCR->getOMPClauses()),
        Kind(TCR->getTargetCodeKind()){};
  OmpPragma(clang::OMPExecutableDirective *Directive, clang::PrintingPolicy PP)
      : PP(PP), Clauses(Directive->clauses()),
        Kind(Directive->getDirectiveKind()){};
  /// Returns true if the omp pragma encapsulated, needs to be followed by a
  /// structured block (i.e. {...}).
  bool needsStructuredBlock();
  /// Prints a replacement omp pragma for the encapsulated pragma onto \p Out.
  void printReplacement(llvm::raw_ostream &Out);
  void printAddition(llvm::raw_ostream &Out);
  static bool isReplaceable(clang::OMPExecutableDirective *Directive);
  static bool needsAdditionalPragma(clang::OMPExecutableDirective *Directive);
private:
  bool isClausePrintable(clang::OMPClause *Clause);
  void printClauses(llvm::raw_ostream &Out);
};
