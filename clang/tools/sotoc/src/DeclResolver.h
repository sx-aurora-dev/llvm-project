//===-- sotoc/src/DeclResolver.h -----------------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
///
/// \file
/// This file implements the class DeclResolver which is used to record and
/// order types and functions in the input code that are required by the target
/// regions.
///
//===----------------------------------------------------------------------===//
#pragma once

#include <map>
#include <set>
#include <stack>
#include <unordered_set>

llvm::Optional<std::string> getSystemHeaderForDecl(const clang::Decl *D);

namespace clang {
class Decl;
}

class TargetCode;

/// Records information to resolve a single declaration, including if its
/// declared in a system header and other declaration that this declaration
/// depends on
struct DeclInfo {
  /// The declarations AST node itself
  const clang::Decl *Decl;
  /// All other declaration on which this declaration depends.
  std::set<clang::Decl *> DeclDependencies;
  // std::set<clang::Decl *> ForwardDecls;  // for the moment we solve this
  // differently
  bool IsFromSystemHeader;

  DeclInfo(clang::Decl *D, bool isFromSysHeader)
      : Decl(D), IsFromSystemHeader(isFromSysHeader){};
};

using DeclMap = std::map<clang::Decl *, DeclInfo>;

//! Records, orders and finds the dependencies of Decls  (TypeDecls or
//! FunctionDecls)
class DeclResolver {
  /// Records all declarations added to the resolver.
  DeclMap AllDecls;
  /// All declarations which do not depend on other declarations.
  std::set<clang::Decl *> NonDependentDecls;
  /// When a declaration is inside a system header, that header is recorded
  /// here instead of the declaratoin
  std::set<std::string> RequiredSystemHeaders;

public:
  virtual ~DeclResolver() = 0;
  /** Records a Decl and automatically adds all Decls that this Decl depends
   * on.
   * \param D the Decl to be added to the resolver.
   */
  void addDecl(clang::Decl *D);
  /** Creates a \ref TargetCodeFragment for each recorded Decl and adds them
   * to the \ref TargetCode object in the correct order.
   * \param TC the TargetCode object, the fragments will be added to.
   */
  void orderAndAddFragments(TargetCode &TC);

protected:
  /// With this function, the resolver runs a visitor on the declaration added
  /// to find and add all declarations that the added declaration depends on
  /// and adds them to the resolver.
  virtual void runOwnVisitor(clang::Decl *D,
                             std::function<void(clang::Decl *Dep)> Fn) = 0;
  /** This function uses a visitor to find references to other declarations in
   * the declaration being added. If the declaration being added references
   * other declarations outside the standard library, we need to add those
   * declaration to the target code too.
   * \param D the declaration that was added via \ref addDecl.
   * \param UnresolvedDecls a set of declarations which D depends on and which
   * are currently unresolved.
   */
  virtual void
  findDependDecls(clang::Decl *D,
                  std::unordered_set<clang::Decl *> &UnresolvedDecls);

private:
  /** This functions does a topological sorting on the dependency graph of all
   * Decls recorded into this object by calling \ref addDecl.
   * This method uses an DFS approach to be able to deal with possible cycles.
   * \param q an queue where the ordered Decls are save to.
   */
  void topoSort(std::stack<clang::Decl *> &q);
  /// Helper function for \ref topoSort, to do an recursive DFS.
  void topoSortUtil(std::stack<clang::Decl *> &q,
                    std::map<clang::Decl *, bool> &visited, clang::Decl *D);
};

/// Implements DeclResolver for types (typedefs, structs enums) used in target
/// regions.
class TypeDeclResolver : public DeclResolver {
private:
  void runOwnVisitor(clang::Decl *D,
                     std::function<void(clang::Decl *Dep)> Fn) override;
};

/// Implements DeclResolver for functions used in target regions.
/// Does also search for additional types in the functions found and adds them
/// to a TypeDeclResolver instance.
class FunctionDeclResolver : public DeclResolver {
  TypeDeclResolver &Types;

public:
  FunctionDeclResolver(TypeDeclResolver &Types) : Types(Types){};

private:
  void runOwnVisitor(clang::Decl *D,
                     std::function<void(clang::Decl *Dep)> Fn) override;
  /// Overrides DeclResolver::findDependDecls to also find types required by
  /// this function.
  void
  findDependDecls(clang::Decl *D,
                  std::unordered_set<clang::Decl *> &UnresolvedDecls) override;
};
