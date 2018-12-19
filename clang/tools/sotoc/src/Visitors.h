//===-- sotoc/src/Visitor.h -----------------------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#pragma once

#include <unordered_set>

#include "DeclResolver.h"
#include "clang/AST/RecursiveASTVisitor.h"
#include "llvm/ADT/Optional.h"

namespace clang {
class Stmt;
class Decl;
class Type;
class CapturedStmt;
class OMPExecutableDirective;
class SourceLocation;
class FunctionDecl;
class Attr;
class Rewriter;
class ASTContext;
} // namespace clang

class TargetCode;
class TargetCodeFragment;
class TargetCodeRegion;


llvm::Optional<std::string> getSystemHeaderForDecl(clang::Decl *D);

class DiscoverTypesInDeclVisitor
    : public clang::RecursiveASTVisitor<DiscoverTypesInDeclVisitor> {

  std::function<void(clang::TypeDecl *)> OnEachTypeRef;
  void processType(const clang::Type *D);

public:
  DiscoverTypesInDeclVisitor(TypeDeclResolver &Types);
  DiscoverTypesInDeclVisitor(std::function<void(clang::TypeDecl *)> F)
      : OnEachTypeRef(F) {};
  bool VisitDecl(clang::Decl *D);
  bool VisitExpr(clang::Expr *D);
  bool VisitType(clang::Type *T);
};

class DiscoverFunctionsInDeclVisitor
    : public clang::RecursiveASTVisitor<DiscoverFunctionsInDeclVisitor> {

  std::function<void(clang::FunctionDecl *)> OnEachFuncRef;

public:
  DiscoverFunctionsInDeclVisitor(FunctionDeclResolver &Functions);
  DiscoverFunctionsInDeclVisitor(std::function<void(clang::FunctionDecl *)> F)
      : OnEachFuncRef(F){};

  bool VisitExpr(clang::Expr *E);
};


class FindDeclRefExprVisitor
    : public clang::RecursiveASTVisitor<FindDeclRefExprVisitor> {

  std::unordered_set<clang::VarDecl *> VarSet;

public:
  FindDeclRefExprVisitor() {}
  bool VisitStmt(clang::Stmt *S);
  // bool VisitDecl(clang::Decl *D);
  std::unordered_set<clang::VarDecl *>* getVarSet() {
    return &VarSet;
  }
};

class FindLoopStmtVisitor
  : public clang::RecursiveASTVisitor<FindLoopStmtVisitor> {

  FindDeclRefExprVisitor FindDeclRefVisitor;

public:
  FindLoopStmtVisitor() {}
  bool VisitStmt(clang::Stmt *S);
  std::unordered_set<clang::VarDecl *>* getVarSet() {
    return FindDeclRefVisitor.getVarSet();
  }
};

class FindTargetCodeVisitor
    : public clang::RecursiveASTVisitor<FindTargetCodeVisitor> {

  clang::ASTContext &Context;

  TargetCode &TargetCodeInfo;
  TypeDeclResolver &Types;
  DiscoverTypesInDeclVisitor DiscoverTypeVisitor;
  DiscoverFunctionsInDeclVisitor DiscoverFunctionVisitor;
  FunctionDeclResolver &Functions;
  FindDeclRefExprVisitor FindDeclRefVisitor;

  clang::FunctionDecl *LastVisitedFuncDecl;
  std::unordered_set<std::string> FuncDeclWithoutBody;

public:
  FindTargetCodeVisitor(TargetCode &Code, TypeDeclResolver &Types,
                        FunctionDeclResolver &Functions,
                        clang::ASTContext &Context)
      : TargetCodeInfo(Code), Types(Types), DiscoverTypeVisitor(Types),
        DiscoverFunctionVisitor(Functions), Functions(Functions),
        Context(Context) {}
  bool VisitStmt(clang::Stmt *S);
  bool VisitDecl(clang::Decl *D);

private:
  bool processTargetRegion(clang::OMPExecutableDirective *TargetDirective);
  void addTargetRegionArgs(clang::CapturedStmt *S,
                           std::shared_ptr<TargetCodeRegion> TCR);
};

