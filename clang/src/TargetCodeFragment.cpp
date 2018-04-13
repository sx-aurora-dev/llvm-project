#include "clang/AST/ASTContext.h"
#include "clang/AST/Decl.h"
#include "clang/AST/Stmt.h"
#include "clang/AST/StmtOpenMP.h"
#include "clang/Basic/LangOptions.h"
#include "clang/Basic/SourceLocation.h"
#include "clang/Basic/TokenKinds.h"
#include "clang/Lex/Lexer.h"
#include "clang/Lex/Token.h"

#include "TargetCodeFragment.h"

void TargetCodeRegion::addCapturedVar(clang::VarDecl *Var) {
  CapturedVars.push_back(Var);
}

// TODO: this is a mess

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

  return S->getLocEnd();
}

clang::SourceRange TargetCodeRegion::getInnerRange() {
  clang::SourceManager &SM = Context.getSourceManager();
  const clang::LangOptions &LO = Context.getLangOpts();
  if (hasRegionCompoundStmt(getNode())) {
    // Use the lexer to determine the positions of the first and last tokens
    // despite its name, getLocdForEndOfToken points just behind the token
    auto InnerLocStart =
        clang::Lexer::getLocForEndOfToken(getNode()->getLocStart(), 0, SM, LO);

    clang::SourceLocation InnerLocEnd =
        clang::Lexer::GetBeginningOfToken(getNode()->getLocEnd(), SM, LO)
            .getLocWithOffset(-1);

    return clang::SourceRange(InnerLocStart, InnerLocEnd);
  } else if (hasRegionOMPStmt(getNode())) {
    return clang::SourceRange(getNode()->getLocStart().getLocWithOffset(
                                  -8), // try to get #pragma into source range
                              getOMPStmtSourceLocEnd(getNode()));
  } else {
    return getRealRange();
  }
}

clang::SourceRange TargetCodeDecl::getInnerRange() {
  if (llvm::isa<clang::TypeDecl>(Node)) {
    return getRealRange();
  } // Types have .NeedsSemicolon set to true
  auto *FD = Node->getAsFunction();
  if (!Node->hasBody() || (FD && !FD->doesThisDeclarationHaveABody())) {
    clang::SourceManager &SM = Context.getSourceManager();
    auto possibleNextToken = clang::Lexer::findNextToken(
      Node->getLocEnd().getLocWithOffset(1), SM, Context.getLangOpts());
    clang::SourceLocation endLoc;
    if (possibleNextToken.hasValue()) {
      endLoc = possibleNextToken.getValue().getEndLoc();
    } else {
      endLoc = Node->getLocEnd();
    }
    return clang::SourceRange(Node->getLocStart(), endLoc);
  }
  return getRealRange();
}
