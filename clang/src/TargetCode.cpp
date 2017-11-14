#include "llvm/Support/raw_ostream.h"
#include "clang/AST/Stmt.h"
#include "clang/AST/StmtOpenMP.h"
#include "clang/AST/Decl.h"
#include "clang/Basic/SourceLocation.h"
#include "clang/Basic/SourceManager.h"

#include "TargetCode.h"


clang::SourceRange TargetLocation::getRealRange() {
    return Node->getSourceRange();
}


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


clang::SourceRange TargetRegionLocation::getInnerRange() {
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


void TargetRegionLocation::addCapturedVar(clang::VarDecl *Var) {
    CapturedVars.push_back(Var);
}


bool TargetCode::addCodeLocation(std::shared_ptr<TargetLocation> Location) {
    for (const auto &r : CodeLocations) {
        if (SM.isBeforeInTranslationUnit(r->getRealRange().getBegin(),
                                         Location->getNode()->getLocStart()) &&
            SM.isBeforeInTranslationUnit(Location->getNode()->getLocStart(),
                                         r->getRealRange().getEnd())) {
            return false;
        }
    }
    CodeLocations.push_back(Location);
    return true;
}


void TargetCode::generateCode(llvm::raw_ostream &out) {
    for (auto i = CodeLocations.begin(),
              e = CodeLocations.end();
          i != e; ++i) {

        std::shared_ptr<TargetLocation> TL = *i;
        TargetRegionLocation *TRL = llvm::dyn_cast<TargetRegionLocation>(&(*TL));

        if (TRL) {
            generateFunctionPrologue(TRL, out);
        }

        out << TargetCodeRewriter.getRewrittenText(TL->getInnerRange());

        if (TRL) {
            out << "\n}\n";
        }
    }
}


void TargetCode::generateFunctionPrologue(TargetRegionLocation *TRL, llvm::raw_ostream &out) {
    bool first = true;
    out << "void funcNameHere(";
    for (auto i = TRL->getCapturedVarsBegin(),
              e = TRL->getCapturedVarsEnd(); i != e; ++i) {
        if (!first) {
            out << ", ";
        }
        first = false;

        out << (*i)->getType().getAsString() << "* " << (*i)->getDeclName().getAsString();
        // todo: use `Name.print` instead
    }
    out << ")\n{\n";
}
