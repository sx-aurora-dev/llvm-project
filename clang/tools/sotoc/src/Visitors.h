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

class TypeDeclResolver;

llvm::Optional<std::string> getSystemHeaderForDecl(clang::Decl *D);

class DiscoverTypesInDeclVisitor
    : public clang::RecursiveASTVisitor<DiscoverTypesInDeclVisitor> {

  std::function<void(clang::TypeDecl *)> OnEachTypeRef;
  void processType(const clang::Type *D);

public:
  DiscoverTypesInDeclVisitor(std::function<void(clang::TypeDecl *)> F)
      : OnEachTypeRef(F) {}
  DiscoverTypesInDeclVisitor(TypeDeclResolver &Types);
  bool VisitDecl(clang::Decl *D);
  bool VisitExpr(clang::Expr *D);
  bool VisitType(clang::Type *T);
};

class FindTargetCodeVisitor
    : public clang::RecursiveASTVisitor<FindTargetCodeVisitor> {

  clang::ASTContext &Context;

  TargetCode &TargetCodeInfo;
  TypeDeclResolver &Types;
  DiscoverTypesInDeclVisitor DiscoverTypeVisitor;

  clang::FunctionDecl *LastVisitedFuncDecl;
  std::unordered_set<std::string> FuncDeclWithoutBody;

public:
  FindTargetCodeVisitor(TargetCode &Code, TypeDeclResolver &Types,
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

#if 0
class RewriteTargetRegionsVisitor
    : public clang::RecursiveASTVisitor<RewriteTargetRegionsVisitor> {

  clang::Rewriter &TargetCodeRewriter;
  TargetCodeRegion &TargetRegion;
  // We store the result of SourceLocation::getRawEncoding() here because we
  // cannot store SourceLocation of the DeclRefExpr themselves.
  // There care cases were one source location has multiple DeclRefExpr and
  // would get rewritten multiple times which leads to incorrect syntax.
  std::unordered_set<unsigned> RewrittenRefs;

public:
  RewriteTargetRegionsVisitor(clang::Rewriter &TargetCodeRewriter,
                              TargetCodeRegion &TCR)
      : TargetCodeRewriter(TargetCodeRewriter), TargetRegion(TCR){};
  bool VisitStmt(clang::Stmt *S);

private:
  void rewriteVar(clang::DeclRefExpr *Var);
};
#endif
