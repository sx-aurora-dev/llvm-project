//===-- sotoc/src/TypeDeclResolver.h --------------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#pragma once

#include <map>
#include <set>
#include <unordered_set>

namespace clang {
class TypeDecl;
};

class TargetCode;

/* Problem: Types (struct, enums) do not get a `declare target` attribute in
 * the AST and types like structs, enums and typedefs depend on other types
 * to be present.
 *
 * Solution: Read all types in target regions/declare target constructs, then
 * read their decl's and build a tree of used types and their dependencies.
 * Then do a topological sort on the tree to get the order of types to be
 * written as CodeFragments into the TargetCode structure.
 */

struct TypeInfoTy {
  clang::TypeDecl *Decl;
  std::set<clang::TypeDecl *> TypeDependencies;
  bool isFromSystemHeader;
  int InDegree;

  TypeInfoTy(clang::TypeDecl *D, bool isFromSystemHeader)
      : Decl(D), isFromSystemHeader(isFromSystemHeader), InDegree(0){};
};

using TypeMap = std::map<clang::TypeDecl *, TypeInfoTy>;

class TypeDeclResolver {
  TypeMap AllTypes;
  // Types that no other Type depends on
  std::set<clang::TypeDecl *> NonDependencyTypes;
  std::set<std::string> SystemHeaders;

public:
  void addTypeDecl(clang::TypeDecl *TD);
  bool orderAndWriteCodeFragments(TargetCode &TC);

private:
  void setInDegrees();
};
