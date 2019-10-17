//===-- sotoc/src/TargetCodeFragment.cpp ---------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
///
/// \file
/// This file implements the classes TargetCodeDecl and TargetCodeRegion.
///
//===----------------------------------------------------------------------===//

#include <sstream>

#include "clang/AST/Decl.h"
#include "clang/AST/DeclOpenMP.h"
#include "clang/AST/PrettyPrinter.h"
#include "clang/AST/Stmt.h"
#include "clang/AST/StmtOpenMP.h"
#include "clang/Basic/LangOptions.h"
#include "clang/Basic/SourceLocation.h"
#include "clang/Basic/TokenKinds.h"
#include "clang/Lex/Lexer.h"
#include "clang/Lex/Token.h"

#include "OmpPragma.h"
#include "TargetCodeFragment.h"

void TargetCodeRegion::addCapture(const clang::CapturedStmt::Capture *Capture) {
  CapturedVars.push_back(TargetRegionVariable(Capture, CapturedLowerBounds));
}

void TargetCodeRegion::addOMPClause(clang::OMPClause *Clause) {
  OMPClauses.push_back(Clause);
}

static bool hasRegionCompoundStmt(const clang::Stmt *S) {
  if (const auto *SS = llvm::dyn_cast<clang::CapturedStmt>(S)) {
    if (llvm::isa<clang::CompoundStmt>(SS->getCapturedStmt())) {
      return true;
    } else if (llvm::isa<clang::CapturedStmt>(SS->getCapturedStmt())) {
      return hasRegionCompoundStmt(SS->getCapturedStmt());
    }
  }
  return false;
}

static bool hasRegionOMPStmt(const clang::Stmt *S) {
  if (const auto *SS = llvm::dyn_cast<clang::CapturedStmt>(S)) {
    if (llvm::isa<clang::OMPExecutableDirective>(SS->getCapturedStmt())) {
      return true;
    } else if (llvm::isa<clang::CapturedStmt>(SS->getCapturedStmt())) {
      return hasRegionOMPStmt(SS->getCapturedStmt());
    }
  }
  return false;
}

static clang::SourceLocation getOMPStmtSourceLocEnd(const clang::Stmt *S) {
  while (auto *CS = llvm::dyn_cast<clang::CapturedStmt>(S)) {
    S = CS->getCapturedStmt();
  }

  while (auto *OmpExecS = llvm::dyn_cast<clang::OMPExecutableDirective>(S)) {
    S = OmpExecS->getInnermostCapturedStmt();
    if (auto *CS = llvm::dyn_cast<clang::CapturedStmt>(S)) {
      S = CS->getCapturedStmt();
    }
  }

  return S->getEndLoc();
}

// TODO: Implement recursiv for an arbitrary depth?
static clang::SourceLocation findPreviousToken(clang::SourceLocation Loc,
                                               clang::SourceManager &SM,
                                               const clang::LangOptions &LO) {
  clang::Token token;

  Loc = clang::Lexer::GetBeginningOfToken(Loc, SM, LO);

  // Search until we find a valid token before Loc
  // TODO: Error handling if no token can be found
  do {
    Loc = clang::Lexer::GetBeginningOfToken(Loc.getLocWithOffset(-1), SM, LO);
  } while ((clang::Lexer::getRawToken(Loc, token, SM, LO)));

  return token.getLocation();
}

TargetCodeFragment::~TargetCodeFragment() {}

clang::SourceLocation TargetCodeRegion::getStartLoc() {
  clang::SourceManager &SM = Context.getSourceManager();
  const clang::LangOptions &LO = Context.getLangOpts();
  auto TokenBegin = clang::Lexer::GetBeginningOfToken(
      CapturedStmtNode->getBeginLoc(), SM, LO);
  if (hasRegionCompoundStmt(CapturedStmtNode)) {

#if 0
    // This piece of code could be used to check if we start with a new scope.
    // However, the pretty printer destroys this again somehow...
    // Since the extra scope does not realy hurt, i will leave it as it is for now.
    clang::Token token;
    if(!(clang::Lexer::getRawToken(TokenBegin, token, SM, LO))) {
      if (token.is(clang::tok::l_brace)) {
        auto possibleNextToken = clang::Lexer::findNextToken(
                TokenBegin, SM, LO);
        if (possibleNextToken.hasValue()) {
          return possibleNextToken.getValue().getLocation();
        } else {
          llvm::outs()<< "OUCH\n";
        }
        return TokenBegin.getLocWithOffset(1);
      }
    }
    else llvm::outs() << "NOTOK\n";
#endif

    return TokenBegin;
  } else if (hasRegionOMPStmt(CapturedStmtNode)) {
    // We have to go backwards 2 tokens in case of an OMP statement
    // (the '#' and the 'pragma').
    return findPreviousToken(findPreviousToken(TokenBegin, SM, LO), SM, LO);
  } else {
    return CapturedStmtNode->getBeginLoc();
  }
}

clang::SourceLocation TargetCodeRegion::getEndLoc() {
  clang::SourceManager &SM = Context.getSourceManager();
  const clang::LangOptions &LO = Context.getLangOpts();
  auto N = CapturedStmtNode;
  if (hasRegionCompoundStmt(N)) {
    return clang::Lexer::GetBeginningOfToken(N->getEndLoc(), SM, LO)
        .getLocWithOffset(-1); // TODO: If I set this to"1" it works too. I
                               // think it was here to remove addition scope
                               // which i get with "printPretty". Does this
                               // need some fixing?
  } else if (hasRegionOMPStmt(N)) {
    return getOMPStmtSourceLocEnd(N);
  } else {
    return N->getEndLoc();
  }
}

const std::string TargetCodeRegion::getParentFuncName() {
  return ParentFunctionDecl->getNameInfo().getAsString();
}

clang::SourceLocation TargetCodeRegion::getTargetDirectiveLocation() {
  return TargetDirective->getBeginLoc();
}

clang::SourceRange TargetCodeRegion::getRealRange() {
  return CapturedStmtNode->getSourceRange();
}

clang::SourceRange TargetCodeRegion::getSpellingRange() {
  auto &SM =
      CapturedStmtNode->getCapturedDecl()->getASTContext().getSourceManager();
  auto InnerRange = getInnerRange();
  return clang::SourceRange(SM.getSpellingLoc(InnerRange.getBegin()),
                            SM.getSpellingLoc(InnerRange.getEnd()));
}

clang::SourceRange TargetCodeRegion::getInnerRange() {
  auto InnerLocStart = getStartLoc();
  auto InnerLocEnd = getEndLoc();
  return clang::SourceRange(InnerLocStart, InnerLocEnd);
}

class TargetRegionPrinterHelper : public clang::PrinterHelper {
  clang::PrintingPolicy PP;

public:
  TargetRegionPrinterHelper(clang::PrintingPolicy PP) : PP(PP){};
  bool handledStmt(clang::Stmt *E, llvm::raw_ostream &OS) {
    if (auto *Directive = llvm::dyn_cast<clang::OMPExecutableDirective>(E)) {
      if (OmpPragma::isReplaceable(Directive)) {
        OmpPragma(Directive, PP).printReplacement(OS);
        OS << "\n";
        Directive->child_begin()->printPretty(OS, this, PP);
        return true;
      }

      if (OmpPragma::needsAdditionalPragma(Directive)) {
        OmpPragma(Directive, PP).printAddition(OS);
        OS << "\n";
        return false;
      }
    }
    return false;
  }
};

std::string TargetCodeRegion::PrintPretty() {
  // Do pretty printing in order to resolve Macros.
  // TODO: Is there a better approach (e.g., token or preprocessor based?)
  // One issue here: Addition braces (i.e., scope) in some cases.
  std::string PrettyStr = "";
  llvm::raw_string_ostream PrettyOS(PrettyStr);
  TargetRegionPrinterHelper Helper(PP);
  if (CapturedStmtNode != NULL)
    CapturedStmtNode->printPretty(PrettyOS, &Helper, PP);
  return PrettyOS.str();
}

clang::SourceRange TargetCodeDecl::getRealRange() {
  // return DeclNode->getSourceRange();
  // return DeclNode->getSourceRange();
  // auto &SM = DeclNode->getASTContext().getSourceManager();
  // return clang::SourceRange(SM.getSpellingLoc(DeclNode->getBeginLoc()),
  //                          SM.getSpellingLoc(DeclNode->getEndLoc()));
  return DeclNode->getSourceRange();
}

clang::SourceRange TargetCodeDecl::getSpellingRange() {
  auto &SM = DeclNode->getASTContext().getSourceManager();
  auto InnerRange = getInnerRange();
  return clang::SourceRange(SM.getSpellingLoc(InnerRange.getBegin()),
                            SM.getSpellingLoc(InnerRange.getEnd()));
}

std::string TargetCodeDecl::PrintPretty() {
  std::string PrettyStr = "";
  llvm::raw_string_ostream PrettyOS(PrettyStr);

  // This hack solves our problem with structs and enums being autoexpanded#
  // sometimes (See comment in Issue #20.
  clang::PrintingPolicy LocalPP(PP);
  if (llvm::isa<clang::TypedefDecl>(DeclNode)) {
    LocalPP.IncludeTagDefinition = 1;
  }

  TargetRegionPrinterHelper Helper(PP);

  // This hack removes the 'static' keyword from globalVarDecls, because we
  // cannot find variables from the host if they are static.
  bool HasStaticKeyword = false;
  if (auto *VarDeclNode = llvm::dyn_cast<clang::VarDecl>(DeclNode)) {
    if (VarDeclNode->getStorageClass() == clang::SC_Static) {
      HasStaticKeyword = true;
      VarDeclNode->setStorageClass(clang::SC_None);
    }
  }

  DeclNode->print(PrettyOS, LocalPP, 0, false, &Helper);

  // Add static storage class back so (hopefully) this doesnt break anyting
  // (but it totally will).
  if (auto *VarDeclNode = llvm::dyn_cast<clang::VarDecl>(DeclNode)) {
    if (HasStaticKeyword) {
      VarDeclNode->setStorageClass(clang::SC_Static);
    }
  }

  // This hack removes '#pragma omp declare target' from the output
  std::string outString = PrettyOS.str();
  const char *declareTargetPragma = "#pragma omp declare target";

  if (outString.compare(0, strlen(declareTargetPragma), declareTargetPragma) ==
      0) {
    outString = outString.substr(strlen(declareTargetPragma));
  }
  return outString;
}
