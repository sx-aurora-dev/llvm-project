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

class TypeDeclResolver;

llvm::Optional<std::string> getSystemHeaderForDecl(clang::Decl *D);

/// Traverses (parts of) the AST to find DeclRefExpr that refer to types that
/// need to be present for that part of the AST to compile correctly. The
/// visitor is not only used to search through target regions and functions, but
/// also through type declarations themselves, in order to also find types that
/// the already found types depend on to compile.
class DiscoverTypesInDeclVisitor
    : public clang::RecursiveASTVisitor<DiscoverTypesInDeclVisitor> {

  /// Function run on the declaration of each type found by the visitor.
  std::function<void(clang::TypeDecl *)> OnEachTypeRef;
  /// Retrieves the declaration of the type found and passes it on.
  void processType(const clang::Type *D);

public:
  DiscoverTypesInDeclVisitor(TypeDeclResolver &Types);
  DiscoverTypesInDeclVisitor(std::function<void(clang::TypeDecl *)> F)
      : OnEachTypeRef(F){};
  bool VisitDecl(clang::Decl *D);
  bool VisitExpr(clang::Expr *D);
  bool VisitType(clang::Type *T);
};

/// Traverses (parts of) the AST to find DeclRefExpr that refer to functions
/// that need to be present for that part of the AST to compile correctly.
/// This way functions declared and defined in the same compilation unit do
/// not need to be annotated by the 'omp declare target' pragma.
/// The Visitor is not only used to search through target regions, but also
/// through the found functions themselves and through functions that are
/// annotated with the 'omp declare target' pragma, to find all necessary
/// dependencies recursively.
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
  std::unordered_set<clang::VarDecl *> *getVarSet() { return &VarSet; }
};

class FindLoopStmtVisitor
    : public clang::RecursiveASTVisitor<FindLoopStmtVisitor> {

  FindDeclRefExprVisitor FindDeclRefVisitor;

public:
  FindLoopStmtVisitor() {}
  bool VisitStmt(clang::Stmt *S);
  std::unordered_set<clang::VarDecl *> *getVarSet() {
    return FindDeclRefVisitor.getVarSet();
  }
};

/// Traverses the AST to find target and process target regions and function and
/// variables that are annotated by an 'omp declare target' target pragma.
class FindTargetCodeVisitor
    : public clang::RecursiveASTVisitor<FindTargetCodeVisitor> {

  clang::ASTContext &Context;

  /// The collection where target regions and other code is added to.
  TargetCode &TargetCodeInfo;
  /// A Visitor to find references to the types required by the target code.
  DiscoverTypesInDeclVisitor DiscoverTypeVisitor;
  /// A Visitor to find references to all functions required by the target
  /// code.
  DiscoverFunctionsInDeclVisitor DiscoverFunctionVisitor;
  /// Collection of all functions referenced and required by target code (and
  /// referenced by other required functions).
  FunctionDeclResolver &Functions;
  FindDeclRefExprVisitor FindDeclRefVisitor;

  /// The last function the visitor traversed. This is stored to be able to
  /// later compute the function name for the target region.
  std::stack<clang::FunctionDecl *> LastVisitedFuncDecl;
  /// Function with 'omp declare target' pragma, for which the visitor has not
  /// yet found a body.
  std::unordered_set<std::string> FuncDeclWithoutBody;

public:
  FindTargetCodeVisitor(TargetCode &Code, TypeDeclResolver &Types,
                        FunctionDeclResolver &Functions,
                        clang::ASTContext &Context)
      : Context(Context), TargetCodeInfo(Code), DiscoverTypeVisitor(Types),
        DiscoverFunctionVisitor(Functions), Functions(Functions){};
  bool TraverseDecl(clang::Decl *D);
  bool VisitStmt(clang::Stmt *S);
  bool VisitDecl(clang::Decl *D);

private:
  /// Extracts the necessary information about the target region from the AST,
  /// such as captured variables and relevant OpenMP clauses, and adds an
  /// TargetCodeRegion to the TargetCode instance.
  bool processTargetRegion(clang::OMPExecutableDirective *TargetDirective);
  /// Finds and adds all variables required by the target regions as arguments
  /// to the generated function.
  void addTargetRegionArgs(clang::CapturedStmt *S,
                           clang::OMPExecutableDirective *TargetDirective,
                           std::shared_ptr<TargetCodeRegion> TCR);
};

class FindArraySectionVisitor
    : public clang::RecursiveASTVisitor<FindArraySectionVisitor> {

  std::map<clang::VarDecl *, clang::Expr *> &LowerBoundsMap;

public:
  FindArraySectionVisitor(
      std::map<clang::VarDecl *, clang::Expr *> &LowerBoundsMap)
      : LowerBoundsMap(LowerBoundsMap) {}
  bool VisitExpr(clang::Expr *E);
};

class FindPrivateVariablesVisitor
    : public clang::RecursiveASTVisitor<FindPrivateVariablesVisitor> {

  clang::SourceManager &SM;
  clang::SourceLocation RegionTopSourceLocation;
  std::set<clang::VarDecl *> VarSet;

public:
  FindPrivateVariablesVisitor(clang::SourceLocation TopSourceLocation, clang::SourceManager &SM)
      : RegionTopSourceLocation(TopSourceLocation), SM(SM) {}

  bool VisitExpr(clang::Expr *E);
  std::set<clang::VarDecl *> &getVarSet() {
    return VarSet;
  }
};
