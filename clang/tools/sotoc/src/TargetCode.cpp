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
#include <string>

#include "clang/AST/Decl.h"
#include "clang/AST/PrettyPrinter.h"
#include "clang/AST/Stmt.h"
#include "clang/AST/StmtOpenMP.h"
#include "clang/Basic/SourceLocation.h"
#include "clang/Basic/SourceManager.h"
#include "clang/Lex/Lexer.h"
#include "llvm/ADT/APInt.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/Format.h"
#include "llvm/Support/Process.h"
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
  bool stdlib = false;
  bool unistd = false;
  
  for (auto &i : SystemHeaders) {
    std::string Header(i);
    size_t include_pos = Header.rfind("nclude/");
    if (include_pos != std::string::npos) {
      Header.erase(0, include_pos + strlen("nclude/"));
    }
    Out << "#include <" << Header << ">\n";
    if (Header.compare("unistd.h") == 0) {
        unistd = true;
    } else if (Header.compare("stdlib.h") == 0) {
        stdlib = true;
    }
  }

  if (!stdlib && std::atoi(llvm::sys::Process::GetEnv("NEC_TARGET_DELAY").getValueOr("0").c_str())) {
    Out << "#include <stdlib.h>\n";
  }
  if (!unistd && std::atoi(llvm::sys::Process::GetEnv("NEC_TARGET_DELAY").getValueOr("0").c_str())) {
    Out << "#include <unistd.h>\n";
  }

  // Override omp_is_initial_device() with macro, because this
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

void TargetCode::generateArgument(const TargetRegionVariable &Arg,
                                  llvm::raw_ostream &Out) {
  std::string LHSStore;
  std::string RHSStore;
  llvm::raw_string_ostream LHS(LHSStore);
  llvm::raw_string_ostream RHS(RHSStore);

  for (auto &Shape : Arg.shapes()) {
    if (Shape.isPointer()) {
      LHS << "(*";
      RHS << ")";
    } else if (Shape.isConstantArray()) {
      RHS << "[" << Shape.getConstantDimensionExpr() << "]";
    } else if (Shape.isVariableArray()) {
      RHS << "[]";
    }
  }

  Out << LHS.str() << Arg.name() << RHS.str();
}

void TargetCode::generateFunctionPrologue(TargetCodeRegion *TCR,
                                          llvm::raw_ostream &Out) {
  bool first = true;

  Out << "void " << generateFunctionName(TCR) << "(";

  for (auto &Var : TCR->capturedVars()) {
    if (!first) {
      Out << ", ";
    }
    first = false;

    if (Var.isArray()) {
      for (auto &d : Var.variableArrayShapes()) {
        Out << "unsigned long long __sotoc_vla_dim"
            << d.getVariableDimensionIndex() << "_" << Var.name() << ", ";
      }
    }
    // Because arrays are passed by reference and (for our purposes) their type
    // is 'void', the rest of their handling ist the same as for scalars.
    if (Var.isArray()) {
      Out << "void ";
    } else {
      // In cases where we get a first-private float, we want to recieve the
      // full 64 bit we input into veo. We then later can change the type back
      // to float. I suspect some weirdness with IEEE 754 and the change of
      // variable length from 32 to 64 and back to 32 bit.
      if (!Var.passedByPointer() && Var.baseTypeName() == "float") {
        Out << "unsigned long long __sotoc_conv_var_";
      } else {
        Out << Var.baseTypeName() << " ";
      }
    }

    if (Var.passedByPointer()) {
      Out << "*__sotoc_var_" << Var.name();
    } else {
      generateArgument(Var, Out);
    }
  }

  unsigned int clauseParam = 0;
  for (auto C : TCR->getOMPClauses()) {
    if ((C->getClauseKind() == clang::OpenMPClauseKind::OMPC_num_threads) &&
        !C->isImplicit()) {
      if (!first) {
        Out << ", ";
      } else {
        first = false;
      }
      Out << "int __sotoc_clause_param_" << std::to_string(clauseParam) << " ";
      clauseParam++;
    }
  }

  Out << ")\n{\n";

  // Target Delay
  if (std::atoi(llvm::sys::Process::GetEnv("NEC_TARGET_DELAY").getValueOr("0").c_str())) {
    Out << "sleep(atoi((getenv(\"NEC_TARGET_DELAY\") != NULL) ? getenv(\"NEC_TARGET_DELAY\") : \"0\"));\n";
  }
  
  // bring captured scalars into scope
  for (auto &Var : TCR->capturedVars()) {
    // Ignore everything not passed by reference here
    if (Var.passedByPointer()) {
      // Handle multi-dimensional arrays
      if (Var.isArray()) {
        // Declare the arrays as a pointer. This way we can assign it a pointer
        // However, this also means we have to ignore the first array
        // dimension.
        Out << "  " << Var.baseTypeName() << " (*" << Var.name() << ")";

        // For every array dimension other then the first: declare them by
        // adding the array brackets ('[', ']') to the declaration. Also add
        // the size of this dimension if we have it.
        bool first = true;
        for (auto &Shape : Var.shapes()) {
          // We need to discard the first element
          if (first) {
            first = false;
            continue;
          }
          Out << "[";
          if (Shape.isConstantArray()) {
            Out << Shape.getConstantDimensionExpr();
          } else if (Shape.isVariableArray()) {
            Out << "__sotoc_vla_dim" << Shape.getVariableDimensionIndex() << "_"
                << Var.name();
          }
          Out << "]";
        }
        // After we have declare the array, we also need to assign it.
        // We may also have to adjust the array bounds if we only get a slice
        // of the array (in the first dimesion. All other dimensions should
        // not require adjustment as their slicing is ignored)
        Out << " =  __sotoc_var_" << Var.name() << ";\n";
        // Move the bounds if we have a slice
        auto LowerBound = Var.arrayLowerBound();
        if (LowerBound.hasValue()) {
          Out << "  " << Var.name() << " = " << Var.name() << " - ";
          LowerBound.getValue()->printPretty(Out, NULL, TCR->getPP());
          Out << ";\n";
        }
      } else if (Var.isPointer()){
        Out << Var.baseTypeName() << "* " << Var.name() << " = "
            << "__sotoc_var_" << Var.name() << ";\n";
      } else {
        // Handle all other types passed by reference
        Out << Var.baseTypeName() << " " << Var.name() << " = "
            << "*__sotoc_var_" << Var.name() << ";\n";
      }
      // After recieving floats as unsigned long long we want to change them
      // back to floats but without conversion as they already are formated
      // according to 32 bit floating point spec.
    } else if (!Var.isArray() && !Var.passedByPointer() &&
               Var.baseTypeName() == "float") {
      Out << "float " << Var.name() << " = *(float*)&(__sotoc_conv_var_"
          << Var.name() << ");\n";
    }
  }

  // Generate local declarations.
  for (auto *privateVar : TCR->privateVars()) {
    Out << "  " << privateVar->getType().getAsString() << " "
        << privateVar->getName() << ";\n";
  }

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
  for (auto &Var : TCR->capturedVars()) {
    if (Var.passedByPointer() && !Var.isArray() && !Var.isPointer()) {
      Out << "\n  *__sotoc_var_" << Var.name() << " = " << Var.name() << ";";
    } else if (Var.isPointer()){
      Out << "\n  __sotoc_var_" << Var.name() << " = " << Var.name() << ";";
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
