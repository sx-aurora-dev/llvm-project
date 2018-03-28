#pragma once

#include <string>
#include <vector>

// forward declaration of clang types
namespace clang {
class SourceLocation;
class SourceRange;
class Decl;
class VarDecl;
class CapturedStmt;
}; // namespace clang

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

private:
  const TargetCodeFragmentKind Kind;
  // Actual class content
public:
  bool NeedsSemicolon;
  TargetCodeFragmentKind getKind() const { return Kind; };
  static bool classof(const TargetCodeFragment *TCF) {
    return TCF->getKind() == TCFK_TargetCodeFragment;
  }

public:
  TargetCodeFragment(TargetCodeFragmentKind Kind)
      : Kind(Kind), NeedsSemicolon(false) {}
  virtual clang::SourceRange getRealRange() = 0;
  virtual clang::SourceRange getInnerRange() { return getRealRange(); }
};

// TargetCodeFragment which has an actual representation in source code
// (we dont have any other kind of source fragments because we handle #includes
//  differently)
template <class T> class TargetCodeSourceFragment : public TargetCodeFragment {

protected:
  T Node;

public:
  TargetCodeSourceFragment(T Node, TargetCodeFragmentKind Kind)
      : TargetCodeFragment(Kind), Node(Node) {}
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
  std::string ParentFuncName;
  clang::SourceLocation TargetDirectiveLocation;

public:
  TargetCodeRegion(clang::CapturedStmt *Node,
                   clang::SourceLocation TargetDirectiveLocation,
                   clang::FunctionDecl *ParentFuncDecl)
      : TargetCodeSourceFragment<clang::CapturedStmt *>(Node,
                                                        TCFK_TargetCodeRegion),
        ParentFuncName(ParentFuncDecl->getNameAsString()),
        TargetDirectiveLocation(TargetDirectiveLocation) {}
  void addCapturedVar(clang::VarDecl *Var);
  clang::CapturedStmt *getNode() { return Node; }
  std::vector<clang::VarDecl *>::const_iterator getCapturedVarsBegin() {
    return CapturedVars.begin();
  };
  std::vector<clang::VarDecl *>::const_iterator getCapturedVarsEnd() {
    return CapturedVars.end();
  };
  clang::SourceRange getInnerRange() override;
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
      : TargetCodeSourceFragment<clang::Decl *>(Node, TCFK_TargetCodeDecl) {}
  clang::SourceRange getInnerRange() override;
};
