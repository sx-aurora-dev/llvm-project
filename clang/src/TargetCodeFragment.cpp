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

clang::SourceLocation TargetCodeDecl::getStartLoc() {
  llvm::errs() << "NOT IMPLEMENTED: TargetCodeDecl::getStartLoc()\n";
}

clang::SourceLocation TargetCodeDecl::getEndLoc() {
  llvm::errs() << "NOT IMPLEMENTED: TargetCodeDecl::getEndLoc()\n";
}


//TODO: Implement recursiv for an arbitrary depth?
clang::SourceLocation findPreviousToken(clang::SourceLocation Loc, clang::SourceManager &SM, const clang::LangOptions &LO) {
  clang::Token token;

  Loc = clang::Lexer::GetBeginningOfToken(Loc, SM, LO);

  // Search until we find a valid token before Loc
  // TODO: Error handling if no token can be found
  do {
    Loc = clang::Lexer::GetBeginningOfToken(Loc.getLocWithOffset(-1), SM, LO);
  } while((clang::Lexer::getRawToken(Loc, token, SM, LO)));

  return token.getLocation();
}

clang::SourceLocation TargetCodeRegion::getStartLoc() {
  clang::SourceManager &SM = Context.getSourceManager();
  const clang::LangOptions &LO = Context.getLangOpts();
  auto TokenBegin =
       clang::Lexer::GetBeginningOfToken(getNode()->getLocStart(), SM, LO);
  if (hasRegionCompoundStmt(getNode())) {

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
  } else if (hasRegionOMPStmt(getNode())) {
    // We have to go backwards 2 tokens in case of an OMP statement 
    // (the '#' and the 'pragma').
    return findPreviousToken(findPreviousToken(TokenBegin, SM,LO), SM, LO);
  } else {
    return getNode()->getLocStart();
  }
}

clang::SourceLocation TargetCodeRegion::getEndLoc() {
  clang::SourceManager &SM = Context.getSourceManager();
  const clang::LangOptions &LO = Context.getLangOpts();
  auto N = getNode();
  if (hasRegionCompoundStmt(N)) {
    return clang::Lexer::GetBeginningOfToken(N->getLocEnd(), SM, LO)
            .getLocWithOffset(-1);// TODO: If I set this to"1" it works too. I
                                  // think it was here to remove addition scope
                                  // which i get with "printPretty". Does this
                                  // need some fixing?
  } else if (hasRegionOMPStmt(N)) {
    return getOMPStmtSourceLocEnd(N);
  } else {
    return N->getLocEnd();
  }
}


clang::SourceRange TargetCodeRegion::getInnerRange() {
  auto InnerLocStart = getStartLoc();
  auto InnerLocEnd = getEndLoc();
  return clang::SourceRange(InnerLocStart, InnerLocEnd);
}

// TODO:: Implement this as
// "return clang::SourceRange(getStartLoc(), getEndLoc())"
clang::SourceRange TargetCodeDecl::getInnerRange() {
  clang::SourceManager &SM = Context.getSourceManager();

  if (llvm::isa<clang::TypeDecl>(Node)) {
    return getRealRange();
  } // Types have .NeedsSemicolon set to true
  auto *FD = Node->getAsFunction();
  if (!Node->hasBody() || (FD && !FD->doesThisDeclarationHaveABody())) {
    clang::SourceManager &SM = Context.getSourceManager();
    auto possibleNextToken = clang::Lexer::findNextToken(
      Node->getLocEnd(), SM, Context.getLangOpts());
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
