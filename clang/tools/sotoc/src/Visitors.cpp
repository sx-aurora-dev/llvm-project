//===-- sotoc/src/Visitor.cpp ---------------------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
///
/// \file
/// This file implements the classes DiscoverTypesInDeclVisitor and
/// FindTargetCodeVisitor.
///
//===----------------------------------------------------------------------===//

#include <sstream>
#include <string>

#include "clang/AST/ASTContext.h"
#include "clang/AST/Attr.h"
#include "clang/AST/Decl.h"
#include "clang/AST/ExprOpenMP.h"
#include "clang/AST/Stmt.h"
#include "clang/AST/StmtOpenMP.h"
#include "clang/Basic/OpenMPKinds.h"
#include "clang/Basic/SourceLocation.h"
#include "clang/Basic/SourceManager.h"
#include "clang/Rewrite/Core/Rewriter.h"

#include "Debug.h"
#include "DeclResolver.h"
#include "TargetCode.h"
#include "TargetCodeFragment.h"
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

  DEBUGPDECL(D, "Get system header for Decl: ");

  if (!SM.isInSystemHeader(D->getBeginLoc())) {
    return llvm::Optional<std::string>();
  }

  // we dont want to include the original system header in which D was
  // declared, but the system header which exposes D to the user's file
  // (the last system header in the include stack)
  auto IncludedFile = SM.getFileID(D->getBeginLoc());

  // Fix for problems with math.h
  // If our declaration is really a macro expansion, we need to find the actual
  // spelling location first.
  bool SLocInvalid = false;
  auto SLocEntry = SM.getSLocEntry(IncludedFile, &SLocInvalid);
  if (SLocEntry.isExpansion()) {
    IncludedFile = SM.getFileID(SLocEntry.getExpansion().getSpellingLoc());
  }

  auto IncludingFile = SM.getDecomposedIncludedLoc(IncludedFile);

  while (SM.isInSystemHeader(SM.getLocForStartOfFile(IncludingFile.first))) {
    IncludedFile = IncludingFile.first;
    IncludingFile = SM.getDecomposedIncludedLoc(IncludedFile);
  }

  return llvm::Optional<std::string>(
      std::string(SM.getFilename(SM.getLocForStartOfFile(IncludedFile))));
}

bool FindTargetCodeVisitor::TraverseDecl(clang::Decl *D) {
  if (auto *FD = llvm::dyn_cast<clang::FunctionDecl>(D)) {
    LastVisitedFuncDecl.push(FD);
  }
  bool ret = clang::RecursiveASTVisitor<FindTargetCodeVisitor>::TraverseDecl(D);
  if (auto *FD = llvm::dyn_cast<clang::FunctionDecl>(D)) {
    LastVisitedFuncDecl.pop();
  }
  return ret;
}

bool FindTargetCodeVisitor::VisitStmt(clang::Stmt *S) {
  if (auto *TD = llvm::dyn_cast<clang::OMPTargetDirective>(S)) {
    processTargetRegion(TD);
  } else if (auto *TD = llvm::dyn_cast<clang::OMPTargetTeamsDirective>(S)) {
    processTargetRegion(TD);
  } else if (auto *TD = llvm::dyn_cast<clang::OMPTargetParallelDirective>(S)) {
    processTargetRegion(TD);
  } else if (auto *LD = llvm::dyn_cast<clang::OMPLoopDirective>(S)) {
    if (auto *TD = llvm::dyn_cast<clang::OMPTargetParallelForDirective>(LD)) {
      processTargetRegion(TD);
    } else if (auto *TD =
                   llvm::dyn_cast<clang::OMPTargetParallelForSimdDirective>(
                       LD)) {
      processTargetRegion(TD);
    } else if (auto *TD = llvm::dyn_cast<clang::OMPTargetSimdDirective>(LD)) {
      processTargetRegion(TD);
    } else if (auto *TD =
                   llvm::dyn_cast<clang::OMPTargetTeamsDistributeDirective>(
                       LD)) {
      processTargetRegion(TD);
    } else if (auto *TD = llvm::dyn_cast<
                   clang::OMPTargetTeamsDistributeParallelForDirective>(LD)) {
      processTargetRegion(TD);
    } else if (auto *TD = llvm::dyn_cast<
                   clang::OMPTargetTeamsDistributeParallelForSimdDirective>(
                   LD)) {
      processTargetRegion(TD);
    } else if (auto *TD =
                   llvm::dyn_cast<clang::OMPTargetTeamsDistributeSimdDirective>(
                       LD)) {
      processTargetRegion(TD);
    }
  }
  return true;
}

class CollectOMPClauseParamsVarsVisitor
    : public clang::RecursiveASTVisitor<CollectOMPClauseParamsVarsVisitor> {
  std::shared_ptr<TargetCodeRegion> TCR;
public:
  CollectOMPClauseParamsVarsVisitor(std::shared_ptr<TargetCodeRegion> &TCR)
    : TCR(TCR) {};

  bool VisitStmt(clang::Stmt *S) {
    if (auto *DRE = llvm::dyn_cast<clang::DeclRefExpr>(S)) {
      if (auto *VD = llvm::dyn_cast<clang::VarDecl>(DRE->getDecl())) {
        TCR->addOMPClauseParam(VD->getCanonicalDecl());
      }
    }
    return true;
  };
};

class CollectOMPClauseParamsVisitor
    : public clang::RecursiveASTVisitor<CollectOMPClauseParamsVisitor> {

      CollectOMPClauseParamsVarsVisitor VarsVisitor;
  bool InExplicitCast;
public:
  CollectOMPClauseParamsVisitor(std::shared_ptr<TargetCodeRegion> &TCR)
    : VarsVisitor(TCR), InExplicitCast(false) {};
  bool VisitStmt(clang::Stmt *S) {
    // This relies on the captured statement being the last child
    if (llvm::isa<clang::CapturedStmt>(S)) {
        return false;
    }

    if (llvm::isa<clang::ImplicitCastExpr>(S)) {
      InExplicitCast = true;
      return true;
    }

    auto *DRE = llvm::dyn_cast<clang::DeclRefExpr>(S);
    if (DRE && InExplicitCast) {
      if (auto *VD = llvm::dyn_cast<clang::VarDecl>(DRE->getDecl())) {
        VarsVisitor.TraverseStmt(VD->getInit());
      }
    }
    InExplicitCast = false;
    return true;
  };
};

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
          CS, TargetDirective, LastVisitedFuncDecl.top(), Context);
      // if the target region cannot be added we dont want to parse its args
      if (TargetCodeInfo.addCodeFragment(TCR)) {

        FindArraySectionVisitor(TCR->CapturedLowerBounds).TraverseStmt(TargetDirective);

        for (auto C : TargetDirective->clauses()) {
          TCR->addOMPClause(C);
        }

        // For more complex data types (like structs) we need to traverse the
        // tree
        DiscoverTypeVisitor.TraverseStmt(CS);
        DiscoverFunctionVisitor.TraverseStmt(CS);
        addTargetRegionArgs(CS, TargetDirective, TCR);
        TCR->NeedsSemicolon = stmtNeedsSemicolon(CS);
        TCR->TargetCodeKind = TargetDirective->getDirectiveKind();
      }
    }
  }
  return true;
}

void FindTargetCodeVisitor::addTargetRegionArgs(
    clang::CapturedStmt *S, clang::OMPExecutableDirective *TargetDirective,
    std::shared_ptr<TargetCodeRegion> TCR) {

  DEBUGP("Add target region args");
  for (const auto &i : S->captures()) {
    if (!(i.capturesVariableArrayType())) {
      DEBUGP("captured Var: " + i.getCapturedVar()->getNameAsString());
      TCR->addCapture(&i);
    } else {
      // Not sure what exactly is caputred here. It looks like we have an
      // additional capture in cases of VATs.
      DEBUGP("Current capture is a variable-length array type (skipped)");
    }
  }

  // Find all not locally declared variables in the region
  FindPrivateVariablesVisitor PrivateVarsVisitor(S->getBeginLoc(),
                                                 Context.getSourceManager());
  PrivateVarsVisitor.TraverseStmt(S);

  // Remove any not locally declared variables which are already captured
  auto VarSet = PrivateVarsVisitor.getVarSet();
  for (auto &CapturedVar : TCR->capturedVars()) {
    VarSet.erase(CapturedVar.getDecl());
  }

  // Add variables used in OMP clauses which are not captured as first-private
  // variables
  CollectOMPClauseParamsVisitor(TCR).TraverseStmt(TargetDirective);

  // Add non-local, non-capured variable as private variables
  TCR->setPrivateVars(VarSet);
}

bool FindTargetCodeVisitor::VisitDecl(clang::Decl *D) {
  auto *FD = llvm::dyn_cast<clang::FunctionDecl>(D);
  if (FD) {
    auto search = FuncDeclWithoutBody.find(FD->getNameAsString());
    if (search != FuncDeclWithoutBody.end()) {
      Functions.addDecl(D);
      FuncDeclWithoutBody.erase(search);
    }
  }

  // search Decl attributes for 'omp declare target' attr
  for (auto &attr : D->attrs()) {
    if (attr->getKind() == clang::attr::OMPDeclareTargetDecl) {
      Functions.addDecl(D);
      if (FD) {
        if (FD->hasBody() && !FD->doesThisDeclarationHaveABody()) {
          FuncDeclWithoutBody.insert(FD->getNameAsString());
        }
      }
      return true;
    }
  }
  return true;
}

bool FindLoopStmtVisitor::VisitStmt(clang::Stmt *S) {
  if (auto LS = llvm::dyn_cast<clang::ForStmt>(S)) {
    FindDeclRefVisitor.TraverseStmt(LS->getInit());
  }
  return true;
}


bool FindDeclRefExprVisitor::VisitStmt(clang::Stmt *S) {
  if (auto DRE = llvm::dyn_cast<clang::DeclRefExpr>(S)) {
    if (auto DD = llvm::dyn_cast<clang::DeclaratorDecl>(DRE->getDecl())) {
      if (auto VD = llvm::dyn_cast<clang::VarDecl>(DD)) {
        if (VD->getNameAsString() != ".reduction.lhs") {
          VarSet.insert(VD);
        }
      }
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
  if (auto *DRE = llvm::dyn_cast<clang::DeclRefExpr>(E)) {
    if (auto *ECD = llvm::dyn_cast<clang::EnumConstantDecl>(DRE->getDecl())) {
      OnEachTypeRef(llvm::cast<clang::EnumDecl>(ECD->getDeclContext()));
      return true;
    }
  }
  if (const clang::Type *TP = E->getType().getTypePtrOrNull()) {
    if (TP->isPointerType()) {
      TP = TP->getPointeeOrArrayElementType();
    }
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
  OnEachTypeRef = [&Types](clang::Decl *D) { Types.addDecl(D); };
}

DiscoverFunctionsInDeclVisitor::DiscoverFunctionsInDeclVisitor(
    FunctionDeclResolver &Functions) {
  OnEachFuncRef = [&Functions](clang::FunctionDecl *FD) {
    Functions.addDecl(FD);
  };
}

bool DiscoverFunctionsInDeclVisitor::VisitExpr(clang::Expr *E) {
  clang::DeclRefExpr *DRE = llvm::dyn_cast<clang::DeclRefExpr>(E);
  if (DRE != nullptr) {
    if (auto *D = DRE->getDecl()) {
      if (auto *FD = llvm::dyn_cast<clang::FunctionDecl>(D)) {
        OnEachFuncRef(FD);
        auto *FDDefinition = FD->getDefinition();
        if (FDDefinition != FD && FDDefinition != NULL) {
          OnEachFuncRef(FDDefinition);
        }
      }
    }
  }
  return true;
}

bool FindArraySectionVisitor::VisitExpr(clang::Expr *E) {
  if (auto *ASE = llvm::dyn_cast<clang::OMPArraySectionExpr>(E)) {
    clang::Expr *Base = ASE->getBase();
    if (llvm::isa<clang::OMPArraySectionExpr>(Base)) {
      return true;
    }
    if (auto *CastBase = llvm::dyn_cast<clang::CastExpr>(Base)) {
      Base = CastBase->getSubExpr();
      if (auto *DRE = llvm::dyn_cast<clang::DeclRefExpr>(Base)) {
        auto *VarDecl = llvm::dyn_cast<clang::VarDecl>(DRE->getDecl());
        if (!VarDecl) {
          llvm::errs() << "VALDECL != VARDECL\n";
          return true;
        }
        clang::Expr *LowerBound = ASE->getLowerBound();
        if (!LowerBound) {
          return true;
        }

        if (auto *IntegerLiteral =
                llvm::dyn_cast<clang::IntegerLiteral>(LowerBound)) {
          if (IntegerLiteral->getValue() == 0) {
            return true;
          }
        }
        LowerBoundsMap.emplace(VarDecl, LowerBound);
      }
    }
  }
  return true;
}

bool FindPrivateVariablesVisitor::VisitExpr(clang::Expr *E) {
  if (auto *DRE = llvm::dyn_cast<clang::DeclRefExpr>(E)) {
    if (auto *VD = llvm::dyn_cast<clang::VarDecl>(DRE->getDecl())) {
      // We do not collect variables in 'collect target' declarations.
      for (auto &attr : VD->attrs()) {
        if (attr->getKind() == clang::attr::OMPDeclareTargetDecl) {
          return true;
        }
      }

      // If the variable is declared outside of the target region it may be a
      // private variable
      if (SM.isBeforeInTranslationUnit(VD->getLocation(), RegionTopSourceLocation)) {
        // Add the Variable to our set
        VarSet.insert(VD);
      }
    }
  }
  return true;
}
