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

/*TODO: Adjust transformation of static arrays depending on the pointers given
        as parameters to the offloading functions.

        Idea for handling static arrays so far: Change the notation of static
        arrays from array-notation to pointer-notation and handle them.
          array[i] <=> *(array+i)

        Possible problem: Static arrays are not handled right (or as expected)
        when creating the __sotoc_var_ pointers and thusly we end up with
        inconsistancies in the pointers after the transformation.

        Furthermore: As the compiler is unlikely to detect the mentioned
        inconsistancies (as they are not syntactic [hopefully] but logical) lit
        will mark the given testcases as PASSED although the data is garbled.
        Thus a comparison with kwnown-good data should be added to the test.

  TODO: Add functionality for multidimensional, static arrays

        Idea so far: Cast type till NULL, sum up sizes
        (for malloc [just in case]), pass pointer (as above) and sizes of
        sub-arrays as parameter and reconstruct in target region.

        Reason: Array and Poiter-notation are not equivalent any more when
        handling multidimensional arrays.
*/

#include <sstream>

#include "clang/AST/Decl.h"
#include "clang/AST/PrettyPrinter.h"
#include "clang/AST/Stmt.h"
#include "clang/AST/StmtOpenMP.h"
#include "clang/Basic/SourceLocation.h"
#include "clang/Basic/SourceManager.h"
#include "clang/Lex/Lexer.h"
#include "llvm/Support/Format.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/ADT/APInt.h"

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
      TargetCodeRewriter.ReplaceText(Frag->getInnerRange(), PrettyCode);

    if (TCR) {
      generateFunctionPrologue(TCR);
    }

    if (TCR) {
      generateFunctionEpilogue(TCR);
    }
    Out << "\n";
    Out << TargetCodeRewriter.getRewrittenText(Frag->getInnerRange());

    if (Frag->NeedsSemicolon) {
      Out << ";";
    }
    Out << "\n";
  }
}

void TargetCode::generateFunctionPrologue(TargetCodeRegion *TCR) {

  auto tmpSL = TCR->getStartLoc();

  std::stringstream Out;
  bool first = true;
  Out << "void " << generateFunctionName(TCR) << "(";
  for (auto i = TCR->getCapturedVarsBegin(), e = TCR->getCapturedVarsEnd(); i != e; ++i) {
    if (!first) {
      Out << ", ";
    }
    first = false;

    // check for static arrays, because of AST representation and naive getType
    if (auto t = clang::dyn_cast_or_null<clang::ConstantArrayType>((*i)->getType().getTypePtr())){
      // possibly use t->getSize().toString(10, false) to get the size of the array
      //TODO: use VarName
      Out << t->getElementType().getAsString() << " *__sotoc_var_" << (*i)->getDeclName().getAsString();

    } else {

      Out << (*i)->getType().getAsString() << " ";
      if (!(*i)->getType().getTypePtr()->isPointerType()) {
        Out << "*__sotoc_var_";
      }
      Out << (*i)->getDeclName().getAsString();
      // todo: use `Name.print` instead
    }
  }
  Out << ")\n{\n";

  // bring captured scalars into scope
  for (auto I = TCR->getCapturedVarsBegin(), E = TCR->getCapturedVarsEnd();
       I != E; ++I) {

    // again check for static arrays
    if (auto t = clang::dyn_cast_or_null<clang::ConstantArrayType>((*I)->getType().getTypePtr())){
      auto VarName = (*I)->getDeclName().getAsString();
      Out << "  " << t->getElementType().getAsString() << " *"
          << VarName << "= __sotoc_var_" << VarName << ";\n";
    } else {
      if (!(*I)->getType().getTypePtr()->isPointerType()) {
        auto VarName = (*I)->getDeclName().getAsString();
        Out << "  " << (*I)->getType().getAsString() << " " << VarName << " = "
            << "*__sotoc_var_" << VarName << ";\n";
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
  if (TCR->TargetCodeKind == clang::OpenMPDirectiveKind::OMPD_target_parallel) {
    Out << "  #pragma omp parallel " << TCR->PrintClauses() << "\n  {\n";
  }

  if (TargetCodeRewriter.InsertTextBefore(tmpSL, Out.str()) == true)
    llvm::errs() << "ERROR: Prologue was not written\n";
}

void TargetCode::generateFunctionEpilogue(TargetCodeRegion *TCR) {
  std::stringstream Out;
  auto tmpSL = TCR->getEndLoc();

  if (TCR->TargetCodeKind == clang::OpenMPDirectiveKind::OMPD_target_parallel) {
    Out << "  }\n";
  }

  Out << "\n";
  // copy values from scalars from scoped vars back into pointers
  for (auto I = TCR->getCapturedVarsBegin(), E = TCR->getCapturedVarsEnd();
       I != E; ++I) {


    if (auto t = clang::dyn_cast_or_null<clang::ConstantArrayType>((*I)->getType().getTypePtr())){
       auto VarName = (*I)->getDeclName().getAsString();
       Out << "\n  __sotoc_var_" << VarName << " = " << VarName << ";";
    } else {
       if (!(*I)->getType().getTypePtr()->isPointerType()) {
         auto VarName = (*I)->getDeclName().getAsString();
         Out << "\n  *__sotoc_var_" << VarName << " = " << VarName << ";";
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
