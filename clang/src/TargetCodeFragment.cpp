#include <sstream>

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

void TargetCodeRegion::addOpenMPClause(clang::OMPClause *Clause){
  OMPClauses.push_back(Clause);
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

//TODO: REMOVE this
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

// TODO: Use StringRef?
std::string TargetCodeRegion::PrintClauses(){
  clang::SourceManager &SM = Context.getSourceManager();
  const clang::LangOptions &LO = Context.getLangOpts();
  std::stringstream Out;
  for(auto C : OMPClauses) {
    // getEndLoc should deliver the location of the right paren.
    // However, there in July 2018 there is a bug in clang, such
    // that a wrong location for 'map', 'num_threads', 'shared', 'private'
    // is returned. We wait for the fix..
    clang::SourceRange CRange(C->getLocStart(), C->getLocEnd());
    clang::CharSourceRange CCRange = clang::CharSourceRange::getTokenRange(CRange);
    Out << std::string(clang::Lexer::getSourceText(CCRange, SM, LO)) << " ";
  }
  return Out.str();
}

std::string TargetCodeRegion::PrintPretty() {
  // Do pretty printing in order to resolve Macros.
  // TODO: Is there a better approach (e.g., token or preprocessor based?)
  // One issue here: Addition braces (i.e., scope) in some cases.
  std::string PrettyStr = "";
  llvm::raw_string_ostream PrettyOS(PrettyStr);
  if(Node != NULL)
    Node->printPretty(PrettyOS, NULL, PP);
  return PrettyOS.str();
}

std::string TargetCodeDecl::PrintPretty() {
  std::string PrettyStr = "";
  llvm::raw_string_ostream PrettyOS(PrettyStr);
  if(Node != NULL)
    //Node->getBody()->printPretty(PrettyOS, NULL, PP);
    Node->print(PrettyOS, PP);
  return PrettyOS.str();
}
