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

class OmpPragma {
  clang::PrintingPolicy PP;
  llvm::ArrayRef<clang::OMPClause *> Clauses;
  clang::OpenMPDirectiveKind Kind;

public:
  OmpPragma(TargetCodeRegion *TCR)
      : PP(TCR->getPP()), Clauses(*TCR->getOMPClauses()),
        Kind(TCR->getTargetCodeKind()){};
  OmpPragma(clang::OMPExecutableDirective *Directive, clang::PrintingPolicy PP)
      : PP(PP), Clauses(Directive->clauses()),
        Kind(Directive->getDirectiveKind()){};
  bool needsStructuredBlock();
  void printReplacement(llvm::raw_ostream &Out);

private:
  bool isClausePrintable(clang::OMPClause *Clause);
  void printClauses(llvm::raw_ostream &Out);
};
