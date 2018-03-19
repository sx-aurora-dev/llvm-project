#include "clang/AST/Decl.h"
#include "clang/AST/Stmt.h"
#include "clang/Basic/SourceLocation.h"
#include "clang/AST/StmtOpenMP.h"

#include "TargetCodeFragment.h"


void TargetCodeRegion::addCapturedVar(clang::VarDecl *Var) {
    CapturedVars.push_back(Var);
}


// TODO: this is a mess

static bool hasRegionCompoundStmt(const clang::Stmt* S) {
    if (const auto *SS = llvm::dyn_cast<clang::CapturedStmt>(S)) {
        if (llvm::isa<clang::CompoundStmt>(SS->getCapturedStmt())) {
            return true;
        }
    }
    return false;
}


static bool hasRegionOMPStmt(const clang::Stmt *S) {
    if (const auto *SS = llvm::dyn_cast<clang::CapturedStmt>(S)) {
        if (llvm::isa<clang::OMPExecutableDirective>(SS->getCapturedStmt())) {
            return true;
        }
    }
    return false;
}


static clang::SourceLocation getOMPStmtSourceLocEnd(const clang::Stmt *S) {
    if (auto *SS = llvm::dyn_cast<clang::CapturedStmt>(S)) {
        if (auto *SSS = llvm::dyn_cast<clang::OMPExecutableDirective>(SS->getCapturedStmt())) {
            const clang::OMPExecutableDirective *cur = SSS;
            const clang::OMPExecutableDirective *last = nullptr;

            do {
                last = cur;
            } while((cur = llvm::dyn_cast<clang::OMPExecutableDirective>(cur->getAssociatedStmt())));

            if (last) {
                return last->getAssociatedStmt()->getLocEnd().getLocWithOffset(1);
            }
        }
    }
    return S->getLocEnd().getLocWithOffset(1);
}


clang::SourceRange TargetCodeRegion::getInnerRange() {
    if (hasRegionCompoundStmt(getNode())) {
        return clang::SourceRange(getNode()->getLocStart().getLocWithOffset(1),
                                  getNode()->getLocEnd().getLocWithOffset(-1));
    } else if (hasRegionOMPStmt(getNode())) {
        return clang::SourceRange(getNode()->getLocStart().getLocWithOffset(-8), //try to get #pragma into source range
                                  getOMPStmtSourceLocEnd(getNode()));
    } else {
        // I'm not quite sure why this is necessary, but it is
        return clang::SourceRange(getNode()->getLocStart(),
                                  getNode()->getLocEnd().getLocWithOffset(2));
    }
}


clang::SourceRange TargetCodeDecl::getInnerRange() {
    if (llvm::isa<clang::TypeDecl>(Node)) {
        return getRealRange();
    } // Types have .NeedsSemicolon set to true
    auto *FD = Node->getAsFunction();
    if (!Node->hasBody() || (FD && !FD->doesThisDeclarationHaveABody())) {
        return clang::SourceRange(Node->getLocStart(),
                                  Node->getLocEnd().getLocWithOffset(2));
    }
    return getRealRange();
}
