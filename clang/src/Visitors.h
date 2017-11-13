#pragma once

#include "clang/AST/RecursiveASTVisitor.h"

namespace clang {
    class Stmt;
    class CapturedStmt;
    class OMPTargetDirective;
}

class TargetCode;
class TargetRegionLocation;


class FindTargetCodeVisitor
    : public clang::RecursiveASTVisitor<FindTargetCodeVisitor> {

    TargetCode &TargetCodeInfo;
public:
    FindTargetCodeVisitor(TargetCode &Code) : TargetCodeInfo(Code) {};
    bool VisitStmt(clang::Stmt *S);
private:
    bool processTargetRegion(clang::OMPTargetDirective *TargetDirective);
    void addTargetRegionArgs(clang::CapturedStmt *S,
                             std::shared_ptr<TargetRegionLocation> TRL);
};


class RewriteTargetRegionsVisitor
    : public clang::RecursiveASTVisitor<RewriteTargetRegionsVisitor> {

    clang::Rewriter &TargetCodeRewriter;
    TargetRegionLocation &TargetRegion;
public:
    RewriteTargetRegionsVisitor(clang::Rewriter &TargetCodeRewriter,
                                TargetRegionLocation &TRL)
        : TargetCodeRewriter(TargetCodeRewriter), TargetRegion(TRL) {};
    bool  VisitStmt (clang::Stmt *S);
private:
    void rewriteVar(clang::DeclRefExpr *Var);
};
