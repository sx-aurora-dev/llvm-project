//===-- sotoc/src/TargetDeclResolver.cpp ----------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
///
/// \file
/// This file implements the class DeclResolver.
///
//===----------------------------------------------------------------------===//

#include <memory>

#include "clang/AST/Decl.h"

#include "DeclResolver.h"
#include "TargetCode.h"
#include "TargetCodeFragment.h"
#include "Visitors.h"


template <class VisitorClass>
void DeclResolver<VisitorClass>::addDecl(clang::Decl *D) {

  if (AllDecls.count(D) != 0) {
    // we have already resolved this Decl
    return;
  }

  std::unordered_set<clang::Decl *> UnresolvedDecls;
  UnresolvedDecls.insert(D);

  while (!UnresolvedDecls.empty()) {
    auto ResolveDeclIter = UnresolvedDecls.begin();
    auto ResolveDecl = *ResolveDeclIter;
    auto Header = getSystemHeaderForDecl(ResolveDecl);

    if (Header.hasValue()) {
      // The Decl is inside a system header, so it does not depend on
      // any other declaration. So we add the Decl and then we are
      // finished
      AllDecls.emplace(
          std::make_pair(ResolveDecl, DeclInfo(ResolveDecl, true)));
    } else {
      // This Decl may have other Decls that is depends on.

      // Add Decl if we haven't already
      if (!AllDecls.count(ResolveDecl)) {
        AllDecls.emplace(
            std::make_pair(ResolveDecl, DeclInfo(ResolveDecl, false)));
      }

      VisitorClass Visitor([&D, &UnresolvedDecls, this](clang::Decl *Dep) {
        if (!this->AllDecls.count(Dep)) {
          UnresolvedDecls.insert(Dep);
        }
        // Fix for enums. TODO: find a better way to avoid duplicates
        if (D != Dep) {
          this->AllDecls.at(D).DeclDependencies.insert(Dep);
        }
      });

      Visitor.TraverseDecl(D);
      onNewUserDecl(ResolveDecl);
    }
    UnresolvedDecls.erase(ResolveDeclIter);
  }
}

template <class VisitorClass>
void DeclResolver<VisitorClass>::topoSortUtil(
    std::stack<clang::Decl *> &q, std::map<clang::Decl *, bool> &visited,
    clang::Decl *D) {

  visited[D] = true;

  for (auto DepDecl : AllDecls.at(D).DeclDependencies) {
    if (!visited[DepDecl]) {
      topoSortUtil(q, visited, DepDecl);
    }
  }
  q.push(D);
}

template <class VisitorClass>
void DeclResolver<VisitorClass>::topoSort(std::stack<clang::Decl *> &q) {
  // Previously we used Kuhn's algorithm to make the topo sort. However,
  // since we now also need to do the same thing for functions, and not just
  // for types anymore, and functions can be forward-declared, we may need
  // to deal with cycles in our dependency graph.

  // the default constructor value for bool is 'false' (TIL), so we can
  // safely use operator[] on `visited`
  std::map<clang::Decl *, bool> visited;

  for (auto &DeclEntry : AllDecls) {
    if (!visited[DeclEntry.first]) {
      topoSortUtil(q, visited, DeclEntry.first);
    }
  }
}

template <class VisitorClass>
void DeclResolver<VisitorClass>::orderAndAddFragments(TargetCode &TC) {

  for (auto &Header : RequiredSystemHeaders) {
    TC.addHeader(Header);
  }

  std::stack<clang::Decl *> orderStack;
  while (!orderStack.empty()) {
    auto codeDecl = std::make_shared<TargetCodeDecl>(orderStack.top());
    orderStack.pop();

    // TODO: this wont hurt but is not always necessary
    codeDecl->NeedsSemicolon = true;
    TC.addCodeFragmentFront(codeDecl);
  }
}

template class DeclResolver<DiscoverTypesInDeclVisitor>;
