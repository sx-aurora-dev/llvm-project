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

#include "Debug.h"
#include "DeclResolver.h"
#include "TargetCode.h"
#include "TargetCodeFragment.h"
#include "Visitors.h"
#include "clang/Basic/SourceManager.h"
#include "clang/Basic/FileManager.h"

static bool isHeaderOpenMPHeader(llvm::StringRef header_path) {
  if (header_path.substr(header_path.find_last_of("/\\") + 1) == "omp.h") {
    return true;
  }
  return false;
}

static bool isDeclInOpenMPHeader(clang::Decl *D) {
  // if a Decl is exposed by omp.h, that means omp.h is somewhere on the include
  // stack, we want to include omp.h and not copy any decl. This is an issue
  // because omp.h may not be a system header

  clang::SourceManager &SM = D->getASTContext().getSourceManager();
  auto IncludedFile = SM.getFileID(D->getBeginLoc());
  auto SLocEntry = SM.getSLocEntry(IncludedFile);
  if (SLocEntry.isExpansion()) {
    IncludedFile = SM.getFileID(SLocEntry.getExpansion().getSpellingLoc());
  }

  auto IncludingFile = SM.getDecomposedIncludedLoc(IncludedFile);

  DEBUGPDECL(D, "Check if is in OpenMP header: ");

  while (IncludedFile != SM.getMainFileID()) {
    if (isHeaderOpenMPHeader(SM.getFileEntryForID(IncludedFile)->getName())) {
      return true;
    }
    IncludedFile = IncludingFile.first;
    IncludingFile = SM.getDecomposedIncludedLoc(IncludedFile);
  }
  return false;
}

static llvm::Optional<std::string> getSystemHeaderForDecl(clang::Decl *D) {
  clang::SourceManager &SM = D->getASTContext().getSourceManager();

  DEBUGPDECL(D, "Get system header for Decl: ");

  if (!SM.isInSystemHeader(D->getBeginLoc())) {
    return llvm::Optional<std::string>();
  }

  // we dont want to include the original system header in which D was
  // declared, but the system header which exposes D to the user's file
  // (the last system header in the include stack)
  auto IncludedFile = SM.getFileID(D->getBeginLoc());

  // Fix for problems with math.h
  // If our declaration is really a macro expansion, we need to find the actual
  // spelling location first.
  auto SLocEntry = SM.getSLocEntry(IncludedFile);
  if (SLocEntry.isExpansion()) {
    IncludedFile = SM.getFileID(SLocEntry.getExpansion().getSpellingLoc());
  }

  auto IncludingFile = SM.getDecomposedIncludedLoc(IncludedFile);

  while (SM.isInSystemHeader(SM.getLocForStartOfFile(IncludingFile.first)) &&
         !isHeaderOpenMPHeader(SM.getFileEntryForID(IncludingFile.first)->getName())) {
    IncludedFile = IncludingFile.first;
    IncludingFile = SM.getDecomposedIncludedLoc(IncludedFile);
  }

  return llvm::Optional<std::string>(
      std::string(SM.getFilename(SM.getLocForStartOfFile(IncludedFile))));
}

DeclResolver::~DeclResolver() {}

void DeclResolver::addDecl(clang::Decl *D) {

  if (D->isImplicit() || AllDecls.count(D) != 0) {
    // we have already resolved this Decl
    return;
  }

  DEBUGPDECL(D, "Add declaration to resolver: ");

  std::unordered_set<clang::Decl *> UnresolvedDecls;
  UnresolvedDecls.insert(D);

  while (!UnresolvedDecls.empty()) {
    auto ResolveDeclIter = UnresolvedDecls.begin();
    clang::Decl *ResolveDecl = *ResolveDeclIter;
    auto Header = getSystemHeaderForDecl(ResolveDecl);
    if (Header.hasValue()) {
      // The Decl is inside a system header, so it does not depend on
      // any other declaration. So we add the Decl and then we are
      // finished
      AllDecls.emplace(
          std::make_pair(ResolveDecl, DeclInfo(ResolveDecl, true)));
      RequiredSystemHeaders.insert(Header.getValue());
      NonDependentDecls.insert(ResolveDecl);
    } else if (isDeclInOpenMPHeader(D)) {
      // TODO: this is basically a workaround for omp.h decls to not get copied
      AllDecls.emplace(
          std::make_pair(ResolveDecl, DeclInfo(ResolveDecl, true)));
      RequiredSystemHeaders.insert("include/omp.h");
      NonDependentDecls.insert(ResolveDecl);
    } else {

      // Add our decl if we haven't already
      if (!AllDecls.count(ResolveDecl)) {
        AllDecls.emplace(
            std::make_pair(ResolveDecl, DeclInfo(ResolveDecl, false)));
      }

      // This Decl may have other Decls that is depends on.
      // Add Decl if we haven't already
      findDependDecls(ResolveDecl, UnresolvedDecls);
    }
    UnresolvedDecls.erase(ResolveDeclIter);
  }
}

void DeclResolver::findDependDecls(
    clang::Decl *D, std::unordered_set<clang::Decl *> &UnresolvedDecls) {
  // Construct a visitor which searches through the Decl D for references to
  // other decls, because we need to add those too or our target code may not
  // compile.
  runOwnVisitor(D, [&D, &UnresolvedDecls, this](clang::Decl *Dep) {
    if (!this->AllDecls.count(Dep)) {
      DEBUGPDECL(Dep, "Found referred decl: ");
      UnresolvedDecls.insert(Dep);
    }
    // Fix for enums. TODO: find a better way to avoid duplicates
    if (D != Dep) {
      this->AllDecls.at(D).DeclDependencies.insert(Dep);
    }
  });
}

void DeclResolver::topoSortUtil(std::stack<clang::Decl *> &q,
                                std::map<clang::Decl *, bool> &visited,
                                clang::Decl *D) {

  visited[D] = true;

  for (auto DepDecl : AllDecls.at(D).DeclDependencies) {
    if (!visited[DepDecl]) {
      topoSortUtil(q, visited, DepDecl);
    }
  }
  q.push(D);
}

void DeclResolver::topoSort(std::stack<clang::Decl *> &q) {
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

void DeclResolver::orderAndAddFragments(TargetCode &TC) {

  for (auto &Header : RequiredSystemHeaders) {
    TC.addHeader(Header);
  }

  std::stack<clang::Decl *> orderStack;
  topoSort(orderStack);
  while (!orderStack.empty()) {
    if (!AllDecls.at(orderStack.top()).IsFromSystemHeader) {
      auto codeDecl = std::make_shared<TargetCodeDecl>(orderStack.top());

      DEBUGPDECL(orderStack.top(), "Generating Fragment for Decl: ");
      // TODO: this wont hurt but is not always necessary
      codeDecl->NeedsSemicolon = true;
      bool added = TC.addCodeFragmentFront(codeDecl);
      DEBUGP("Decl was a duplicate: " << !added);
    }
    orderStack.pop();
  }
}

void TypeDeclResolver::runOwnVisitor(clang::Decl *D,
                                     std::function<void(clang::Decl *Dep)> Fn) {
  DiscoverTypesInDeclVisitor Visitor(Fn);
  Visitor.TraverseDecl(D);
}

void FunctionDeclResolver::runOwnVisitor(
    clang::Decl *D, std::function<void(clang::Decl *Dep)> Fn) {
  DEBUGPDECL(D, "Searching for referred decls in function ");
  DiscoverFunctionsInDeclVisitor Visitor(Fn);
  Visitor.TraverseDecl(D);
}

void FunctionDeclResolver::findDependDecls(
    clang::Decl *D, std::unordered_set<clang::Decl *> &UnresolvedDecls) {
  this->DeclResolver::findDependDecls(D, UnresolvedDecls);
  DiscoverTypesInDeclVisitor TypesVisitor(Types);
  TypesVisitor.TraverseDecl(D);
}
