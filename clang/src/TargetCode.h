#pragma once

#include "clang/Rewrite/Core/Rewriter.h"

namespace clang {
    class Stmt;
    class SourceManager;
    class SourceRange;
    class VarDecl;
};


/* we use this for declare target functions and variables
 * as those do not need to be rewritten
 */
class TargetLocation {
public:
    // code for llvm's RTTI replacement
    enum TargetLocationKind {
        TLK_TargetLocation,
        TLK_TargetRegionLocation,
    };
    TargetLocationKind getKind() const { return Kind; };
    static bool classof(const TargetLocation *TL) {
        return TL->getKind() == TLK_TargetLocation;
    };
private:
    /* Node holds the AST node to describe the code location
     * in case of declare target functions and variables this ist the
     * top level node for that function/variable
     * in case of a target region, this should be its CapturedStmt
     */
    clang::Stmt *Node;

public:
    TargetLocation(clang::Stmt *Node, TargetLocationKind Kind)
        : Node(Node), Kind(Kind) {};
    const clang::Stmt *getNode() {
        return Node;
    };
    TargetLocation(clang::Stmt *Node)
        : Node(Node), Kind(TLK_TargetLocation) {};
    clang::SourceRange getRealRange();
    virtual clang::SourceRange getInnerRange() {
        return getRealRange();
    };

private:
    const TargetLocationKind Kind;
};


/* We need to rewrite target regions and need more info for that */
class TargetRegionLocation : public TargetLocation {
    /* this will hold the arguments to the implicit function of the target region */
    std::vector<clang::VarDecl*> CapturedVars;
public:
    TargetRegionLocation(clang::Stmt *Node)
        : TargetLocation(Node, TLK_TargetRegionLocation) {};
    void addCapturedVar(clang::VarDecl *Var);
    std::vector<clang::VarDecl*>::const_iterator getCapturedVarsBegin() {
        return CapturedVars.begin();
    };
    std::vector<clang::VarDecl*>::const_iterator getCapturedVarsEnd() {
        return CapturedVars.end();
    };
    clang::SourceRange getInnerRange() override;
    // llvm's RTTI replacement
    static bool classof(const TargetLocation *TL) {
        return TL->getKind() == TLK_TargetRegionLocation;
    };
};


typedef std::vector<std::shared_ptr<TargetLocation>> TargetLocationVector;


class TargetCode {
    //std::unordered_set<VarDecl*> GlobalVarialesDecl; //TODO: we will use this to avoid capturing global vars
    TargetLocationVector CodeLocations;
    clang::Rewriter &TargetCodeRewriter;
    clang::SourceManager &SM;
public:
    TargetCode(clang::Rewriter &TargetCodeRewriter)
        : TargetCodeRewriter(TargetCodeRewriter),
          SM(TargetCodeRewriter.getSourceMgr()) {};
    bool addCodeLocation(std::shared_ptr<TargetLocation> loc);
    void generateCode(llvm::raw_ostream &out);
    TargetLocationVector::const_iterator getCodeLocationsBegin() {
        return CodeLocations.begin();
    }
    TargetLocationVector::const_iterator getCodeLocationsEnd() {
        return CodeLocations.end();
    }
private:
    void generateFunctionPrologue(TargetRegionLocation *TRL,
                                  llvm::raw_ostream &ouz);
};
