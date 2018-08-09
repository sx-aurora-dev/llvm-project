//===-- sotoc/src/TargetCodeFragment.h ------------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#pragma once

#include <string>
#include <vector>

#include "clang/AST/ASTContext.h"
#include "clang/AST/OpenMPClause.h"
#include "clang/AST/PrettyPrinter.h"
#include "clang/Basic/OpenMPKinds.h"

// forward declaration of clang types
namespace clang {
class SourceLocation;
class SourceRange;
class Decl;
class VarDecl;
class CapturedStmt;
class ASTContext;
}; // namespace clang

// TODO: Put this somewhere else
clang::SourceLocation findPreviousToken(clang::SourceLocation Loc,
                                        clang::SourceManager &SM,
                                        const clang::LangOptions &LO);

// This class only really exists because we need a common base class, so we
// can keep a list of pointers of all code fragments (which cannot be
// templated)
class TargetCodeFragment {
  // Set up class for LLVM's RTTI replacement
public:
  enum TargetCodeFragmentKind {
    TCFK_TargetCodeFragment,
    TCFK_TargetCodeRegion,
    TCFK_TargetCodeDecl,
    TCFK_TargetCodeTypeDefinitionRaw,
  };

protected:
  const TargetCodeFragmentKind Kind;
  // Actual class content
public:
  bool NeedsSemicolon;                       // TODO: getter method
  clang::OpenMPDirectiveKind TargetCodeKind; // TODO: getter method
  bool HasExtraBraces; // TODO: Determine if this can be used for removing the
                       // addition scope or remove it.
  TargetCodeFragmentKind getKind() const { return Kind; };
  static bool classof(const TargetCodeFragment *TCF) {
    return TCF->getKind() == TCFK_TargetCodeFragment;
  }
  virtual clang::CapturedStmt *getNode() = 0;

protected:
  clang::ASTContext &Context;

public:
  TargetCodeFragment(clang::ASTContext &Context, TargetCodeFragmentKind Kind)
      : Context(Context), Kind(Kind), NeedsSemicolon(false),
        TargetCodeKind(clang::OpenMPDirectiveKind::OMPD_unknown),
        HasExtraBraces(false) {}

  /// Returns a pretty printed string of the code fragment and an empty string
  /// "" if no pretty printing is available.
  virtual std::string PrintPretty() = 0;
  virtual clang::SourceRange getRealRange() = 0;
  virtual clang::SourceRange getInnerRange() { return getRealRange(); }
  virtual clang::SourceLocation getStartLoc() = 0;
  virtual clang::SourceLocation getEndLoc() = 0;
};

// TargetCodeFragment which has an actual representation in source code
// (we dont have any other kind of source fragments because we handle #includes
//  differently)
template <class T> class TargetCodeSourceFragment : public TargetCodeFragment {

protected:
  T Node;
  clang::PrintingPolicy PP;

public:
  TargetCodeSourceFragment(T Node, clang::ASTContext &Context,
                           TargetCodeFragmentKind Kind)
      : TargetCodeFragment(Context, Kind), Node(Node),
        PP(Context.getLangOpts()) {
    // Set some details for the pretty printer
    PP.Indentation = 1;
    PP.SuppressSpecifiers = 0;
    PP.IncludeTagDefinition = 1;
  }
  // TODO: This is called by many declare_target* tests.
  // It really should have T as a return type. However,
  // I belive this not working, because you cant overload
  // by the return type.
  // virtual T *getNode() {return NULL;}
  virtual clang::CapturedStmt *getNode() { return NULL; }
  // TODO: Implementing PrintPretty only here would be great. However,
  // "printPretty" onl exist in Stmt, but not in Decl :-(.
  virtual std::string PrintPretty() { return ""; };
  virtual clang::SourceRange getRealRange() { return Node->getSourceRange(); }
};

// Represents one target region
class TargetCodeRegion
    : public TargetCodeSourceFragment<clang::CapturedStmt *> {
  // RTTI function
public:
  static bool classof(const TargetCodeFragment *TCF) {
    return (TCF->getKind() == TCFK_TargetCodeRegion ||
            TCF->getKind() == TCFK_TargetCodeFragment);
  }
  // actual class content
private:
  std::vector<clang::VarDecl *> CapturedVars;
  std::vector<clang::OMPClause *> OMPClauses;
  std::string ParentFuncName;
  clang::SourceLocation TargetDirectiveLocation;

public:
  TargetCodeRegion(clang::CapturedStmt *Node,
                   clang::SourceLocation TargetDirectiveLocation,
                   clang::FunctionDecl *ParentFuncDecl,
                   clang::ASTContext &Context)
      : TargetCodeSourceFragment<clang::CapturedStmt *>(Node, Context,
                                                        TCFK_TargetCodeRegion),
        ParentFuncName(ParentFuncDecl->getNameAsString()),
        TargetDirectiveLocation(TargetDirectiveLocation) {}

  void addCapturedVar(clang::VarDecl *Var);
  void addOpenMPClause(clang::OMPClause *Clause);
  virtual clang::CapturedStmt *getNode() { return Node; }
  std::vector<clang::VarDecl *>::const_iterator getCapturedVarsBegin() {
    return CapturedVars.begin();
  };
  std::vector<clang::VarDecl *>::const_iterator getCapturedVarsEnd() {
    return CapturedVars.end();
  };
  std::string PrintClauses();
  std::string PrintLocalVarsFromClauses();
  virtual std::string PrintPretty() override;
  clang::SourceRange getInnerRange() override;
  clang::SourceLocation getStartLoc() override;
  clang::SourceLocation getEndLoc() override;
  const std::string &getParentFuncName() { return ParentFuncName; }
  clang::SourceLocation getTargetDirectiveLocation() {
    return TargetDirectiveLocation;
  }
};

// Represents a Function Decl or Var Decl in 'Declare Target'
class TargetCodeDecl : public TargetCodeSourceFragment<clang::Decl *> {
public:
  static bool classof(const TargetCodeFragment *TCF) {
    return (TCF->getKind() == TCFK_TargetCodeDecl ||
            TCF->getKind() == TCFK_TargetCodeFragment);
  }

public:
  TargetCodeDecl(clang::Decl *Node)
      : TargetCodeSourceFragment<clang::Decl *>(Node, Node->getASTContext(),
                                                TCFK_TargetCodeDecl) {}
  virtual std::string PrintPretty() override;
  clang::SourceLocation getStartLoc() override;
  clang::SourceLocation getEndLoc() override;
};
