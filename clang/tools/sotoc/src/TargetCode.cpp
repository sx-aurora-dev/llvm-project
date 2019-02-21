//===-- sotoc/src/TargetCode ------------------------ ---------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
///
/// \file
/// This file implements the class TargetCode, which can be used to add code
/// fragments and to generate new code (i.e., for outlining OpenMP target
/// region) from these fragments.
///
//===----------------------------------------------------------------------===//

#include <sstream>

#include "clang/AST/Decl.h"
#include "clang/AST/PrettyPrinter.h"
#include "clang/AST/Stmt.h"
#include "clang/AST/StmtOpenMP.h"
#include "clang/Basic/SourceLocation.h"
#include "clang/Basic/SourceManager.h"
#include "clang/Lex/Lexer.h"
#include "llvm/ADT/APInt.h"
#include "llvm/Support/Format.h"
#include "llvm/Support/raw_ostream.h"

#include "Debug.h"
#include "OmpPragma.h"
#include "TargetCode.h"

bool TargetCode::addCodeFragment(std::shared_ptr<TargetCodeFragment> Frag,
                                 bool PushFront) {
  for (auto &F : CodeFragments) {
    // Reject Fragments which are inside Fragments which we already have
    if (SM.isPointWithin(Frag->getRealRange().getBegin(),
                         F->getRealRange().getBegin(),
                         F->getRealRange().getEnd()) ||
        SM.isPointWithin(Frag->getRealRange().getEnd(),
                         F->getRealRange().getBegin(),
                         F->getRealRange().getEnd())) {
      return false;
    }
  }

  if (PushFront) {
    CodeFragments.push_front(Frag);
  } else {
    CodeFragments.push_back(Frag);
  }
  return true;
}

bool TargetCode::addCodeFragmentFront(
    std::shared_ptr<TargetCodeFragment> Frag) {
  return addCodeFragment(Frag, true);
}

void TargetCode::generateCode(llvm::raw_ostream &Out) {
  for (auto &i : SystemHeaders) {
    std::string Header(i);
    size_t include_pos = Header.rfind("nclude/");
    if (include_pos != std::string::npos) {
      Header.erase(0, include_pos + strlen("nclude/"));
    }
    Out << "#include <" << Header << ">\n";
  }

  for (auto i = CodeFragments.begin(), e = CodeFragments.end(); i != e; ++i) {

    std::shared_ptr<TargetCodeFragment> Frag = *i;
    auto *TCR = llvm::dyn_cast<TargetCodeRegion>(Frag.get());

    auto PrettyCode = Frag->PrintPretty();

    // This is a workaround, since "Decl::print" includes "pragma omp declare".
    if (PrettyCode != "")
      TargetCodeRewriter.ReplaceText(Frag->getSpellingRange(), PrettyCode);

    if (TCR) {
      generateFunctionPrologue(TCR);
    }

    if (TCR) {
      generateFunctionEpilogue(TCR);
    }
    Out << "\n";
    Out << TargetCodeRewriter.getRewrittenText(Frag->getSpellingRange());

    if (Frag->NeedsSemicolon) {
      Out << ";";
    }
    Out << "\n";
  }
}

void TargetCode::generateFunctionPrologue(TargetCodeRegion *TCR) {

  std::string Prologue;
  llvm::raw_string_ostream Out(Prologue);

  auto tmpSL = TCR->getStartLoc();

  std::list<int> nDim;
  std::list<std::string> DimString;
  std::string elemType;
  bool first = true;
  Out << "void " << generateFunctionName(TCR) << "(";
  for (auto i = TCR->getCapturedVarsBegin(), e = TCR->getCapturedVarsEnd();
       i != e; ++i) {
    auto C = TCR->GetReferredOMPClause(*i);
    if (!first) {
      Out << ", ";
    }
    first = false;

    // check for constant or variable length arrays, because of
    // AST representation and naive getType
    if (auto t = clang::dyn_cast_or_null<clang::ArrayType>(
            (*i)->getType().getTypePtr())) {
      DEBUGP("Generating code for array type");
      int dim = 0;

      handleArrays(&t, DimString, dim, TCR, elemType);

      // set type to void* to avoid warnings from the compiler
      Out << "void *__sotoc_var_";
      nDim.push_back(dim); // push total number of dimensions
    } else {
      DEBUGP("Generating code for non-array type");
      Out << (*i)->getType().getAsString() << " ";
      if (!(*i)->getType().getTypePtr()->isPointerType()) {
        if (C) {
          // Parameters which are not first private (e.g., explicit mapped vars)
          // are passed by reference, all others by value.
          if (!(C->getClauseKind() ==
                clang::OpenMPClauseKind::OMPC_firstprivate)) {
            Out << "*__sotoc_var_";
          }
        }
      }
    }
    Out << (*i)->getDeclName().getAsString();
  }
  Out << ")\n{\n";

  // bring captured scalars into scope
  for (auto I = TCR->getCapturedVarsBegin(), E = TCR->getCapturedVarsEnd();
       I != E; ++I) {
    auto C = TCR->GetReferredOMPClause(*I);
    // again check for constant and variable-length arrays
    if (auto t = clang::dyn_cast_or_null<clang::ArrayType>(
            (*I)->getType().getTypePtr())) {
      auto VarName = (*I)->getDeclName().getAsString();

      do {
        t = clang::dyn_cast_or_null<clang::ArrayType>(
            t->getElementType().getTypePtr());
      } while (t != NULL);

      Out << "  " << elemType << " (*" << VarName << ")";

      // Get number of Dimensions(nDim) and write sizes(DimString)
      for (int i = 1; i < nDim.front(); i++) {
        DimString.pop_front();
        Out << "[" << DimString.front() << "]";
      }
      DimString.pop_front(); // remove last size
      nDim.pop_front();      // remove number of dimensions of last variable

      Out << " = __sotoc_var_" << VarName << ";\n";

    } else {
      if (!(*I)->getType().getTypePtr()->isPointerType()) {
        if (C) {
          // Parameters which are not first private (e.g., explicit mapped vars)
          // are passed by reference, all others by value.
          if (!(C->getClauseKind() ==
                clang::OpenMPClauseKind::OMPC_firstprivate)) {
            auto VarName = (*I)->getDeclName().getAsString();
            Out << "  " << (*I)->getType().getAsString() << " " << VarName
                << " = "
                << "*__sotoc_var_" << VarName << ";\n";
          }
        }
      }
    }
  }
  Out << "\n";

  // Generate local declarations.
  Out << TCR->PrintLocalVarsFromClauses();

  // Handle combined OpenMP constructs.
  // Since the runtime can decide to only create one team,
  // target team contructs are ignored right now.
  // TODO: What to do with standalone team constructs?

  if (TCR->hasCombineConstruct()) {
    OmpPragma Pragma(TCR);
    Pragma.printReplacement(Out);
    if (Pragma.needsStructuredBlock()) {
      Out << "\n{";
    }
  }
  Out << "\n";

  if (TargetCodeRewriter.InsertTextBefore(tmpSL, Out.str()) == true)
    llvm::errs() << "ERROR: Prologue was not written\n";
}

void TargetCode::generateFunctionEpilogue(TargetCodeRegion *TCR) {
  std::stringstream Out;
  auto tmpSL = TCR->getEndLoc();

  if (OmpPragma(TCR).needsStructuredBlock()) {
    Out << "\n}";
  }

  Out << "\n";
  // copy values from scalars from scoped vars back into pointers
  for (auto I = TCR->getCapturedVarsBegin(), E = TCR->getCapturedVarsEnd();
       I != E; ++I) {
    auto C = TCR->GetReferredOMPClause(*I);

    // if array then already pointer
    if (auto t = clang::dyn_cast_or_null<clang::ArrayType>(
            (*I)->getType().getTypePtr())) {
      auto VarName = (*I)->getDeclName().getAsString();
      Out << "\n  __sotoc_var_" << VarName << " = " << VarName << ";";
    } else {
      if (!(*I)->getType().getTypePtr()->isPointerType()) {
        if (C) {
          // Parameters which are not first private (e.g., explicit mapped vars)
          // are passed by reference, all others by value.
          if (!(C->getClauseKind() ==
                clang::OpenMPClauseKind::OMPC_firstprivate)) {
            auto VarName = (*I)->getDeclName().getAsString();
            Out << "\n  *__sotoc_var_" << VarName << " = " << VarName << ";";
          }
        }
      }
    }
  }

  Out << "\n}\n";
  if (TargetCodeRewriter.InsertTextBefore(tmpSL, Out.str()) == true)
    llvm::errs() << "ERROR: Epilogue was not written\n";
}

std::string TargetCode::generateFunctionName(TargetCodeRegion *TCR) {
  // TODO: this function needs error handling
  llvm::sys::fs::UniqueID ID;
  clang::PresumedLoc PLoc =
      SM.getPresumedLoc(TCR->getTargetDirectiveLocation());
  llvm::sys::fs::getUniqueID(PLoc.getFilename(), ID);
  uint64_t DeviceID = ID.getDevice();
  uint64_t FileID = ID.getFile();
  unsigned LineNum = PLoc.getLine();
  std::string FunctionName;

  llvm::raw_string_ostream fns(FunctionName);
  fns << "__omp_offloading" << llvm::format("_%x", DeviceID)
      << llvm::format("_%x_", FileID) << TCR->getParentFuncName() << "_l"
      << LineNum;
  return FunctionName;
}

void TargetCode::handleArrays(const clang::ArrayType **t,
                              std::list<std::string> &DimString, int &dim,
                              TargetCodeRegion *TCR, std::string &elemType) {
  auto OrigT = *t;

  if (!t) {
    return;
  } else {
    // We just remember the last element type
    elemType = OrigT->getElementType().getAsString();
    DEBUGP("The last QualType of the array is: " + elemType);
  }

  if (auto t1 = clang::dyn_cast_or_null<clang::ConstantArrayType>(OrigT)) {
    DEBUGP("ArrayType is CAT");
    DimString.push_back(t1->getSize().toString(10, false));
    ++dim;

  } else if (auto t1 =
                 clang::dyn_cast_or_null<clang::VariableArrayType>(OrigT)) {
    DEBUGP("ArrayType VAT");
    std::string PrettyStr = "";
    llvm::raw_string_ostream PrettyOS(PrettyStr);
    clang::PrintingPolicy PP(TCR->GetLangOpts());
    t1->getSizeExpr()->printPretty(PrettyOS, NULL, PP);
    DimString.push_back(PrettyOS.str());
    ++dim;

  } else {
    DEBUGP("No more array dimensions");
    // Restore t if we dont have an array type anymore
    *t = OrigT;
    return;
  }

  (*t) = clang::dyn_cast_or_null<clang::ArrayType>(
      OrigT->getElementType().getTypePtr());
  if (*t) {
    // Recursively handle all dimensions
    handleArrays(t, DimString, dim, TCR, elemType);
  }
}
