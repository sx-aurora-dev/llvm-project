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
#include "clang/AST/StmtOpenMP.h"
#include "clang/Basic/OpenMPKinds.h"

#include "TargetRegionVariable.h"

// forward declaration of clang types
namespace clang {
class SourceLocation;
class SourceRange;
class Decl;
class VarDecl;
class CapturedStmt;
} // namespace clang

/// An abstract base class for all fragments of the original code (except header
/// includes) that need to be copied to our generated source code. This includes
/// target regions as well as functions, global variables and types used by
/// target regions (as far as we can detect that) as well as functions and
/// variables that are flagged with the 'omp declare target' pragma.
class TargetCodeFragment {
public:
  /// Enum for LLVMs RTTI
  enum TargetCodeFragmentKind {
    TCFK_TargetCodeFragment,
    TCFK_TargetCodeRegion,
    TCFK_TargetCodeDecl,
  };

protected:
  /// Variable for LLVMs RTTI
  const TargetCodeFragmentKind Kind;

public:
  /// Accessor for LLVMs RTTI
  TargetCodeFragmentKind getKind() const { return Kind; };
  static bool classof(const TargetCodeFragment *TCF) {
    return TCF->getKind() == TCFK_TargetCodeFragment;
  }

  /// Does the source code generation need to add a semicolon to this fragment.
  bool NeedsSemicolon;
  /// What kind of code are we copying. TODO: this can create problems with non
  /// annotated function?
  clang::OpenMPDirectiveKind TargetCodeKind;
  bool HasExtraBraces;

protected:
  clang::ASTContext &Context;
  clang::PrintingPolicy PP;

public:
  TargetCodeFragment(clang::ASTContext &Context, TargetCodeFragmentKind Kind)
      : Kind(Kind), NeedsSemicolon(false),
        TargetCodeKind(clang::OpenMPDirectiveKind::OMPD_unknown),
        HasExtraBraces(false), Context(Context), PP(Context.getLangOpts()) {
    PP.Indentation = 1;
    PP.SuppressSpecifiers = 0;
    PP.IncludeTagDefinition = 0;
  };

  virtual ~TargetCodeFragment() = 0;

  /// Tries to use Clang's PrettyPrinter when possible (this is currently only
  /// for target regions).
  virtual std::string PrintPretty() = 0;
  /// Get the source range of the fragment.
  virtual clang::SourceRange getRealRange() = 0;
  /// Gets the 'inner' source range. This can differ for target regions from the
  /// source range.
  virtual clang::SourceRange getInnerRange() { return getRealRange(); };
  /// Get the spelling source range. That is the range without macro
  /// expansions.
  virtual clang::SourceRange getSpellingRange() = 0;
  /// Accessor to TargetCodeKind
  clang::OpenMPDirectiveKind getTargetCodeKind() { return TargetCodeKind; };
  /// Accessor to lang opts of the current context
  const clang::LangOptions &GetLangOpts() { return Context.getLangOpts(); }
  clang::PrintingPolicy getPP() { return PP; };
};

/// Represents one target region.
class TargetCodeRegion : public TargetCodeFragment {
public:
  static bool classof(const TargetCodeFragment *TCF) {
    return (TCF->getKind() == TCFK_TargetCodeRegion ||
            TCF->getKind() == TCFK_TargetCodeFragment);
  };

private:
  /// The AST node for the captured statement of the target region.
  clang::CapturedStmt *CapturedStmtNode;
  /// AST node for the target directive
  clang::OMPExecutableDirective *TargetDirective;
  /// Declaration of the function this region is declared in. Necessary to
  /// compose the function name of this region in the generated code.
  clang::FunctionDecl *ParentFunctionDecl;
  /// All variable captured by this target region. We will need to generated
  /// pointers to them as arguments to the generated functions and copy the
  /// variables into scope.
  std::vector<TargetRegionVariable> CapturedVars;
  /// All omp clauses relevant to the execution of the region.
  std::vector<clang::OMPClause *> OMPClauses;
  /// The variables which are parameters for top level OpenMP clauses.
  /// These are not captured but still needs passed as (first private) arguments
  /// to the target region.
  std::vector<clang::VarDecl *> OMPClausesParams;
  /// All private variables in a Target Region i.e. all variables that are not
  /// passed as arguments into the region.
  /// For these, we need to generate declarations inside the target region.
  std::set<clang::VarDecl *> PrivateVars;

public:
  TargetCodeRegion(clang::CapturedStmt *CapturedStmtNode,
                   clang::OMPExecutableDirective *TargetDirective,
                   clang::FunctionDecl *ParentFunctionDecl,
                   clang::ASTContext &Context)
      : TargetCodeFragment(Context, TCFK_TargetCodeRegion),
        CapturedStmtNode(CapturedStmtNode), TargetDirective(TargetDirective),
        ParentFunctionDecl(ParentFunctionDecl){};

  using captured_vars_const_iterator = std::vector<TargetRegionVariable>::const_iterator;
  using captured_vars_const_range = llvm::iterator_range<captured_vars_const_iterator>;
  using private_vars_const_iterator = std::set<clang::VarDecl *>::const_iterator;
  using private_vars_const_range = llvm::iterator_range<private_vars_const_iterator>;
  using ompclauses_params_const_iterator = std::vector<clang::VarDecl *>::const_iterator;
  using ompclauses_params_const_range = llvm::iterator_range<ompclauses_params_const_iterator>;

  /// Add a captured variable of the target region.
  /// This will automatically create and save a \ref TargetRegionVariable
  /// which holds all information to generate parameters for the generated
  /// target region function.
  void addCapture(const clang::CapturedStmt::Capture *Capture);
  captured_vars_const_iterator getCapturedVarsBegin() {
    return CapturedVars.begin();
  };
  captured_vars_const_iterator getCapturedVarsEnd() {
    return CapturedVars.end();
  };
  captured_vars_const_range capturedVars() {
    return captured_vars_const_range(getCapturedVarsBegin(), getCapturedVarsEnd());
  };
  /// Adds a (top level) OpenMP clause for the target region.
  /// These clauses are later used to determine which OpenMP #pragma needs to be
  /// generated at the top level of the target region function.
  void addOMPClause(clang::OMPClause *Clause);
  const std::vector<clang::OMPClause *> &getOMPClauses() const {
    return OMPClauses;
  };
  /// Sets the private variables of this target region.
  void setPrivateVars(const std::set<clang::VarDecl *> &VarSet) {
    PrivateVars = VarSet;
  };
  /// Returns a range over the private variables of this region.
  private_vars_const_range privateVars() {
    return private_vars_const_range(PrivateVars.cbegin(), PrivateVars.cend());
  };
  /// Returns a range over the parameters to the top level OpenMP clauses.
  ompclauses_params_const_range ompClausesParams() {
    return ompclauses_params_const_range(OMPClausesParams.cbegin(), OMPClausesParams.cend());
  };
  /// Adds a parameter of a top level OpenMP clause to the target regions
  /// function as a function parameter.
  void addOMPClauseParam(clang::VarDecl *Param);
  bool hasCombineConstruct() {
    return TargetCodeKind != clang::OpenMPDirectiveKind::OMPD_target;
  }
  virtual std::string PrintPretty() override;
  clang::SourceRange getRealRange() override;
  clang::SourceRange getInnerRange() override;
  clang::SourceRange getSpellingRange() override;
  /// Returns a source location at the start of a pragma in the captured
  /// statment.
  clang::SourceLocation getStartLoc();
  clang::SourceLocation getEndLoc();
  /// Returns the name of the function in which the target region is declared.
  const std::string getParentFuncName();
  /// Returns the SourceLocation for the target directive (we need the source
  /// location of the first pragma of the target region to compose the name of
  ///  the function generated for that region)
  clang::SourceLocation getTargetDirectiveLocation();
  /// Lower bounds of mapped array slices (if lower then 0).
  /// If the captured variable is an array, of which only a slice is mapped
  /// (by a map() clause), the incoming pointer argument will need to be
  /// shifted to the right if the lower bound of that slice is not 0.
  /// If this is the case, the lower bound is saved into this map.
  std::map<clang::VarDecl *, clang::Expr *> CapturedLowerBounds;
};

/// This class represents a declaration, i.e. a function, global varialbe, or
/// type declaration that need to be copied from the input source code to the
/// generated source code.
class TargetCodeDecl : public TargetCodeFragment {
public:
  static bool classof(const TargetCodeFragment *TCF) {
    return (TCF->getKind() == TCFK_TargetCodeDecl ||
            TCF->getKind() == TCFK_TargetCodeFragment);
  };

private:
  /// The AST node for the declaration.
  clang::Decl *DeclNode;

public:
  TargetCodeDecl(clang::Decl *Node)
      : TargetCodeFragment(Node->getASTContext(), TCFK_TargetCodeDecl),
        DeclNode(Node){};

  virtual std::string PrintPretty() override;
  clang::SourceRange getRealRange() override;
  clang::SourceRange getSpellingRange() override;
};
