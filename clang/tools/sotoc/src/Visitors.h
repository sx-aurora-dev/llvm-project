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

#include "clang/AST/RecursiveASTVisitor.h"
#include "llvm/ADT/Optional.h"
#include "DeclResolver.h"

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
  DiscoverTypesInDeclVisitor(DeclResolver<DiscoverTypesInDeclVisitor> &Types);
  DiscoverTypesInDeclVisitor(std::function<void(clang::TypeDecl *)> F)
      : OnEachTypeRef(F) {};
  bool VisitDecl(clang::Decl *D);
  bool VisitExpr(clang::Expr *D);
  bool VisitType(clang::Type *T);
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
  DeclResolver<DiscoverTypesInDeclVisitor> &Types;
  DiscoverTypesInDeclVisitor DiscoverTypeVisitor;
  FindDeclRefExprVisitor FindDeclRefVisitor;

  clang::FunctionDecl *LastVisitedFuncDecl;
  std::unordered_set<std::string> FuncDeclWithoutBody;

public:
  FindTargetCodeVisitor(TargetCode &Code, DeclResolver<DiscoverTypesInDeclVisitor> &Types,
                        clang::ASTContext &Context)
      : TargetCodeInfo(Code), Types(Types), DiscoverTypeVisitor(Types),
        Context(Context) {}
  bool VisitStmt(clang::Stmt *S);
  bool VisitDecl(clang::Decl *D);

private:
  bool processTargetRegion(clang::OMPExecutableDirective *TargetDirective);
  void addTargetRegionArgs(clang::CapturedStmt *S,
                           std::shared_ptr<TargetCodeRegion> TCR);
};

