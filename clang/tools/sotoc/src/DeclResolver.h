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

namespace clang {
class Decl;
}

class TargetCode;

struct DeclInfo {
  clang::Decl *Decl;
  std::set<clang::Decl *> DeclDependencies;
  std::set<clang::Decl *> ForwardDecls;
  bool IsFromSystemHeader;

  DeclInfo(clang::Decl *D, bool isFromSysHeader)
      : Decl(D), IsFromSystemHeader(isFromSysHeader){};
};

using DeclMap = std::map<clang::Decl *, DeclInfo>;

//! Records, orders and finds the dependencies of Decls  (TypeDecls or
//! FunctionDecls)
template <class VisitorClass> class DeclResolver {
  DeclMap AllDecls;
  std::set<clang::Decl *> NonDependentDecls;
  std::set<std::string> RequiredSystemHeaders;
  std::function<void(clang::Decl *)> onNewUserDecl;

public:
  DeclResolver(std::function<void(clang::Decl *)> onNewUserDecl)
      : onNewUserDecl(onNewUserDecl){};
  DeclResolver() {
    onNewUserDecl = [](clang::Decl *) {};
  };
  /** Records a Decl and automatically adds all Decls that this Decl depends
   * on.
   * \param D the Decl to be added to the resolver.
   */
  void addDecl(clang::Decl *D);
  /** Creates a \ref TargetCodeFragment for each recorded Decl and adds them
   * to the \ref TargetCode object in the correct order.
   * \param TC the TargetCode object, the fragments will be added to.
   */
  bool orderAndAddFragments(TargetCode &TC);

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
