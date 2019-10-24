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
    if ((SM.isPointWithin(Frag->getRealRange().getBegin(),
                          F->getRealRange().getBegin(),
                          F->getRealRange().getEnd()) &&
         Frag->getRealRange().getBegin() != F->getRealRange().getBegin()) &&
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

  // Override omp_is_initial_device() with macro, becuse this
  //   Out << "static inline int omp_is_initial_device(void) {return 0;}\n";
  // fails with the clang compiler. This still might cause problems, if
  // someone tries to include the omp.h header after the prolouge.
  Out << "#define omp_is_initial_device() 0\n";

  for (auto i = CodeFragments.begin(), e = CodeFragments.end(); i != e; ++i) {

    std::shared_ptr<TargetCodeFragment> Frag = *i;
    auto *TCR = llvm::dyn_cast<TargetCodeRegion>(Frag.get());

    if (TCR) {
      generateFunctionPrologue(TCR, Out);
    }

    Out << Frag->PrintPretty();

    if (TCR) {
      generateFunctionEpilogue(TCR, Out);
    }

    if (Frag->NeedsSemicolon) {
      Out << ";";
    }
    Out << "\n";
  }
  Out << "#undef omp_is_initial_device\n";
}

void TargetCode::generateFunctionPrologue(TargetCodeRegion *TCR,
                                          llvm::raw_ostream &Out) {

  std::string Prologue;

  std::list<int> nDim;
  std::list<std::string> DimString;
  std::string elemType;
  bool first = true;
  Out << "void " << generateFunctionName(TCR) << "(";
  for (auto i = TCR->getCapturedVarsBegin(), e = TCR->getCapturedVarsEnd();
       i != e; ++i) {
    std::string VarName = (*i)->getDeclName().getAsString();
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

      std::vector<int> VariableDimensions;
      handleArrays(&t, DimString, dim, VariableDimensions, TCR, elemType,
                   VarName);

      for (int d : VariableDimensions) {
        Out << "unsigned long long __sotoc_vla_dim" << d << "_" << VarName
            << ", ";
      }

      // set type to void* to avoid warnings from the compiler
      Out << "void *__sotoc_var_";
      nDim.push_back(dim); // push total number of dimensions
    } else {
      Out << (*i)->getType().getAsString() << " ";
      if (!(*i)->getType().getTypePtr()->isPointerType()) {
        if (C) {
          // Parameters which are not first private (e.g., explicit mapped vars)
          // are passed by reference, all others by value.
          if (C->getClauseKind() !=
                clang::OpenMPClauseKind::OMPC_firstprivate &&
              C->getClauseKind() !=
                clang::OpenMPClauseKind::OMPC_private &&
              C->getClauseKind() !=
                clang::OpenMPClauseKind::OMPC_depend) {
            Out << "*__sotoc_var_";
          }
        }
      }
    }
    Out << VarName;
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

      auto LowerBound = TCR->CapturedLowerBounds.find(*I);
      if (LowerBound != TCR->CapturedLowerBounds.end()) {
        Out << VarName << " = " << VarName << " - (";
        LowerBound->second->printPretty(Out, NULL, TCR->getPP());
        Out << ");\n";
      }

    } else {
      if (!(*I)->getType().getTypePtr()->isPointerType()) {
        if (C) {
          // Parameters which are not first private (e.g., explicit mapped vars)
          // are passed by reference, all others by value.
          if (C->getClauseKind() !=
                clang::OpenMPClauseKind::OMPC_firstprivate &&
              C->getClauseKind() !=
                clang::OpenMPClauseKind::OMPC_private &&
              C->getClauseKind() !=
                clang::OpenMPClauseKind::OMPC_depend) {
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

  // The runtime can decide to only create one team.
  // Therfore, replace target teams constructs.
  if (TCR->hasCombineConstruct()) {
    OmpPragma Pragma(TCR);
    Pragma.printReplacement(Out);
    if (Pragma.needsStructuredBlock()) {
      Out << "\n{";
    }
  }
  Out << "\n";
}

void TargetCode::generateFunctionEpilogue(TargetCodeRegion *TCR,
                                          llvm::raw_ostream &Out) {
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
          if (C->getClauseKind() !=
                clang::OpenMPClauseKind::OMPC_firstprivate &&
              C->getClauseKind() !=
                clang::OpenMPClauseKind::OMPC_private &&
              C->getClauseKind() !=
                clang::OpenMPClauseKind::OMPC_depend) {
            auto VarName = (*I)->getDeclName().getAsString();
            Out << "\n  *__sotoc_var_" << VarName << " = " << VarName << ";";
          }
        }
      }
    }
  }

  Out << "\n}\n";
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
                              std::vector<int> &VariableDims,
                              TargetCodeRegion *TCR, std::string &elemType,
                              const std::string &ArrayName) {
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
    PrettyOS << "__sotoc_vla_dim" << dim << "_" << ArrayName;
    DimString.push_back(PrettyOS.str());
    VariableDims.push_back(dim);
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
    handleArrays(t, DimString, dim, VariableDims, TCR, elemType, ArrayName);
  }
}
