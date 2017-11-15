#pragma once

#include <unordered_set>

#include "clang/AST/RecursiveASTVisitor.h"

namespace clang {
    class Stmt;
    class Decl;
    class CapturedStmt;
    class OMPTargetDirective;
    class SourceLocation;
    class FunctionDecl;
}

class TargetCode;
class TargetRegionLocation;


class FindTargetCodeVisitor
    : public clang::RecursiveASTVisitor<FindTargetCodeVisitor> {

    TargetCode &TargetCodeInfo;
    clang::FunctionDecl* LastVisitedFuncDecl;
public:
    FindTargetCodeVisitor(TargetCode &Code) : TargetCodeInfo(Code) {};
    bool VisitStmt(clang::Stmt *S);
    bool VisitDecl(clang::Decl *D);
private:
    bool processTargetRegion(clang::OMPTargetDirective *TargetDirective);
    void addTargetRegionArgs(clang::CapturedStmt *S,
                             std::shared_ptr<TargetRegionLocation> TRL);
};


class RewriteTargetRegionsVisitor
    : public clang::RecursiveASTVisitor<RewriteTargetRegionsVisitor> {

    clang::Rewriter &TargetCodeRewriter;
    TargetRegionLocation &TargetRegion;
    // We store the result of SourceLocation::getRawEncoding() here because we
    // cannot store SourceLocation of the DeclRefExpr themselves.
    // There care cases were one source location has multiple DeclRefExpr and
    // would get rewritten multiple times which leads to incorrect syntax.
    std::unordered_set<unsigned> RewrittenRefs;
public:
    RewriteTargetRegionsVisitor(clang::Rewriter &TargetCodeRewriter,
                                TargetRegionLocation &TRL)
        : TargetCodeRewriter(TargetCodeRewriter), TargetRegion(TRL) {};
    bool  VisitStmt (clang::Stmt *S);
private:
    void rewriteVar(clang::DeclRefExpr *Var);
};
