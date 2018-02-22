#include <sstream>

#include "clang/Basic/SourceLocation.h"
#include "clang/AST/Stmt.h"
#include "clang/AST/StmtOpenMP.h"
#include "clang/Rewrite/Core/Rewriter.h"
#include "clang/AST/Decl.h"
#include "clang/AST/Attr.h"

#include "TargetCode.h"
#include "TargetCodeFragment.h"
#include "Visitors.h"


bool FindTargetCodeVisitor::VisitStmt(clang::Stmt *S) {
    if(auto *TD = llvm::dyn_cast<clang::OMPTargetDirective>(S)) {
        processTargetRegion(TD);
    }
    return true;
}


bool FindTargetCodeVisitor::processTargetRegion(clang::OMPTargetDirective *TargetDirective) {
    for (auto i = TargetDirective->child_begin(), e = TargetDirective->child_end(); i != e; ++i) {
        if (auto *CS = llvm::dyn_cast<clang::CapturedStmt>(*i)) {
            auto TCR = std::make_shared<TargetCodeRegion>(CS, TargetDirective->getLocStart(), LastVisitedFuncDecl);
            // if the target region cannot be added we dont want to parse its args
            if (TargetCodeInfo.addCodeFragment(TCR))
            {
                addTargetRegionArgs(CS, TCR);
            }
        }
    }
    return true; // why even have a return?
}


void FindTargetCodeVisitor::addTargetRegionArgs(clang::CapturedStmt *S,
                                                std::shared_ptr<TargetCodeRegion> TCR) {
    for (const auto &i : S->captures()) {
        TCR->addCapturedVar(i.getCapturedVar());
    }
}


bool FindTargetCodeVisitor::VisitDecl(clang::Decl *D) {
    auto *FD = llvm::dyn_cast<clang::FunctionDecl>(D);
    if (FD) {
        LastVisitedFuncDecl = FD;

        auto search = FuncDeclWithoutBody.find(FD->getNameAsString());
        if (search != FuncDeclWithoutBody.end()) {
            TargetCodeInfo.addCodeFragment(
                std::make_shared<TargetCodeDecl>(D));
            FuncDeclWithoutBody.erase(search);
        }
    }

    // search Decl attributes for 'omp declare target' attr
    for (auto &attr : D->attrs()) {
        if (attr->getKind() == clang::attr::OMPDeclareTargetDecl) {
            auto TCD = std::make_shared<TargetCodeDecl>(D);
            TargetCodeInfo.addCodeFragment(TCD);
            if (FD) {
                if (FD->hasBody() && 
                    !FD->doesThisDeclarationHaveABody()) {
                    FuncDeclWithoutBody.insert(FD->getNameAsString());
                }
            }
            break;
        }
    }
    return true;
}


bool  RewriteTargetRegionsVisitor::VisitStmt (clang::Stmt *S) {
    if (auto *DRE = llvm::dyn_cast<clang::DeclRefExpr>(S)) {
        if (auto *VD = llvm::dyn_cast<clang::VarDecl>(DRE->getDecl())) {
            // check if this DeclRefExpr belongs to a variable we captured
            // and check if we have already rewritten this DeclRefExpr
            if (!VD->getType().getTypePtr()->isPointerType() &&
                std::find(TargetRegion.getCapturedVarsBegin(),
                          TargetRegion.getCapturedVarsEnd(), VD) != TargetRegion.getCapturedVarsEnd() &&
                RewrittenRefs.find(DRE->getLocation().getRawEncoding()) == RewrittenRefs.end()) {
                rewriteVar(DRE);
                RewrittenRefs.insert(DRE->getLocation().getRawEncoding());
            }
        }
    }
    return true;
}


void RewriteTargetRegionsVisitor::rewriteVar(clang::DeclRefExpr *Var) {
    std::string VarName = Var->getNameInfo().getName().getAsString();
    std::stringstream VarNameReplacement;
    VarNameReplacement << "(*" << VarName << ")";
    TargetCodeRewriter.ReplaceText(clang::SourceRange(Var->getLocStart(), Var->getLocEnd()),
                         VarNameReplacement.str());
}
