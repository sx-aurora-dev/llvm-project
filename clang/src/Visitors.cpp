#include <sstream>
#include <string>

#include "clang/AST/ASTContext.h"
#include "clang/AST/Attr.h"
#include "clang/AST/Decl.h"
#include "clang/AST/Stmt.h"
#include "clang/AST/StmtOpenMP.h"
#include "clang/Basic/SourceLocation.h"
#include "clang/Basic/SourceManager.h"
#include "clang/Rewrite/Core/Rewriter.h"
#include "clang/Basic/OpenMPKinds.h"

#include "TargetCode.h"
#include "TargetCodeFragment.h"
#include "TypeDeclResolver.h"
#include "Visitors.h"

static bool stmtNeedsSemicolon(const clang::Stmt *S) {
  while (1) {
    if (auto *CS = llvm::dyn_cast<clang::CapturedStmt>(S)) {
      S = CS->getCapturedStmt();
    } else if (auto *OS = llvm::dyn_cast<clang::OMPExecutableDirective>(S)) {
      S = OS->getInnermostCapturedStmt();
    } else {
      break;
    }
  }
  if (llvm::isa<clang::CompoundStmt>(S) || llvm::isa<clang::ForStmt>(S) ||
      llvm::isa<clang::IfStmt>(S)) {
    return false;
  }
  return true;
}

llvm::Optional<std::string> getSystemHeaderForDecl(clang::Decl *D) {
  clang::SourceManager &SM = D->getASTContext().getSourceManager();

  if (!SM.isInSystemHeader(D->getLocStart())) {
    return llvm::Optional<std::string>();
  }

  // we dont want to include the original system header in which D was
  // declared, but the system header which exposes D to the user's file
  // (the last system header in the include stack)
  auto IncludedFile = SM.getFileID(D->getLocStart());
  auto IncludingFile = SM.getDecomposedIncludedLoc(IncludedFile);

  while (SM.isInSystemHeader(SM.getLocForStartOfFile(IncludingFile.first))) {
    IncludedFile = IncludingFile.first;
    IncludingFile = SM.getDecomposedIncludedLoc(IncludedFile);
  }

  return llvm::Optional<std::string>(
      std::string(SM.getFilename(SM.getLocForStartOfFile(IncludedFile))));
}

static bool isInSystemHeader(clang::Decl *D) {
  clang::SourceManager &SM = D->getASTContext().getSourceManager();
  clang::SourceLocation Loc = D->getLocStart();
  return SM.isInSystemHeader(Loc);
}

bool FindTargetCodeVisitor::VisitStmt(clang::Stmt *S) {
  if (auto *TD = llvm::dyn_cast<clang::OMPTargetDirective>(S)) {
    processTargetRegion(TD);
  } else if (auto *TD = llvm::dyn_cast<clang::OMPTargetTeamsDirective>(S)) {
    processTargetRegion(TD);
  } else if (auto *TD = llvm::dyn_cast<clang::OMPTargetParallelDirective>(S)) {
    processTargetRegion(TD);
  }
  return true;
}

bool FindTargetCodeVisitor::processTargetRegion(
    clang::OMPExecutableDirective *TargetDirective) {
  // TODO: Not sure why to iterate the children, because I think there
  // is only one child. For me this looks wrong.
  for (auto i = TargetDirective->child_begin(),
            e = TargetDirective->child_end();
       i != e; ++i) {
    if (auto *CS = llvm::dyn_cast<clang::CapturedStmt>(*i)) {
      while (auto *NCS =
                 llvm::dyn_cast<clang::CapturedStmt>(CS->getCapturedStmt())) {
        CS = NCS;
      }
      auto TCR = std::make_shared<TargetCodeRegion>(
          CS, TargetDirective->getLocStart(), LastVisitedFuncDecl, Context);
      // if the target region cannot be added we dont want to parse its args
      if (TargetCodeInfo.addCodeFragment(TCR)) {
        DiscoverTypeVisitor.TraverseStmt(CS);
        addTargetRegionArgs(CS, TCR);
        TCR->NeedsSemicolon = stmtNeedsSemicolon(CS);
        TCR->TargetCodeKind = TargetDirective->getDirectiveKind();

        // For some combined OpenMP constructs we need some of the clauses.
        // This parts figures out which clauses to add (regarding the
        // specification).
        // TODO: This is the case list for 'target parallel'. However,
        // this depends on combined construct!
        for (auto C : TargetDirective->clauses()) {
          switch(C->getClauseKind()) {
            case clang::OpenMPClauseKind::OMPC_if:
            case clang::OpenMPClauseKind::OMPC_default:
            case clang::OpenMPClauseKind::OMPC_private:
            case clang::OpenMPClauseKind::OMPC_shared:
            // 'copyin' is the only exception which is not allowed
            // case clang::OpenMPClauseKind::OMPC_copyin:
            case clang::OpenMPClauseKind::OMPC_proc_bind:
            case clang::OpenMPClauseKind::OMPC_num_threads:
            case clang::OpenMPClauseKind::OMPC_reduction:
              TCR->addOpenMPClause(C);
              break;
          }
        }
      }
    }
  }
  return true; // why even have a return?
}

void FindTargetCodeVisitor::addTargetRegionArgs(
    clang::CapturedStmt *S, std::shared_ptr<TargetCodeRegion> TCR) {
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
      TargetCodeInfo.addCodeFragment(std::make_shared<TargetCodeDecl>(D));
      FuncDeclWithoutBody.erase(search);
    }
  }

  // search Decl attributes for 'omp declare target' attr
  for (auto &attr : D->attrs()) {
    if (attr->getKind() == clang::attr::OMPDeclareTargetDecl) {
      auto SystemHeader = getSystemHeaderForDecl(D);
      if (SystemHeader.hasValue()) {
        TargetCodeInfo.addHeader(SystemHeader.getValue());
        return true;
      }

      auto TCD = std::make_shared<TargetCodeDecl>(D);
      TargetCodeInfo.addCodeFragment(TCD);
      DiscoverTypeVisitor.TraverseDecl(D);
      if (FD) {
        if (FD->hasBody() && !FD->doesThisDeclarationHaveABody()) {
          FuncDeclWithoutBody.insert(FD->getNameAsString());
        }
      }
      if (!D->hasBody() || (FD && !FD->doesThisDeclarationHaveABody())) {
        TCD->NeedsSemicolon = true;
      }
      return true;
    }
  }
  return true;
}

bool DiscoverTypesInDeclVisitor::VisitDecl(clang::Decl *D) {
  if (auto *VD = llvm::dyn_cast<clang::ValueDecl>(D)) {
    if (const clang::Type *TP = VD->getType().getTypePtrOrNull()) {
      processType(TP);
    }
  }
  return true;
}

bool DiscoverTypesInDeclVisitor::VisitExpr(clang::Expr *E) {
  if (const clang::Type *TP = E->getType().getTypePtrOrNull()) {
    processType(TP);
  }
  return true;
}

bool DiscoverTypesInDeclVisitor::VisitType(clang::Type *T) {
  processType(T);
  return true;
}

void DiscoverTypesInDeclVisitor::processType(const clang::Type *TP) {
  if (const clang::TypedefType *TDT = TP->getAs<clang::TypedefType>()) {
    OnEachTypeRef(TDT->getDecl());
  } else if (auto *TD = TP->getAsTagDecl()) {
    OnEachTypeRef(TD);
  }
}

DiscoverTypesInDeclVisitor::DiscoverTypesInDeclVisitor(
    TypeDeclResolver &Types) {
  OnEachTypeRef = [&Types](clang::TypeDecl *D) { Types.addTypeDecl(D); };
}
