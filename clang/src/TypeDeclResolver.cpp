#include <queue>

#include "clang/AST/Decl.h"

#include "TypeDeclResolver.h"

#include "TargetCode.h"
#include "TargetCodeFragment.h"
#include "Visitors.h"

void TypeDeclResolver::addTypeDecl(clang::TypeDecl *TD) {

  if (AllTypes.count(TD)) {
    return; // we have already resolved the type
  }

  std::unordered_set<clang::TypeDecl *> UnresolvedTypes;
  UnresolvedTypes.insert(TD);

  while (!UnresolvedTypes.empty()) {
    auto TypeElemIter = UnresolvedTypes.begin();

    auto Header = getSystemHeaderForDecl(*TypeElemIter);

    if (Header.hasValue()) {
      AllTypes.emplace(
          std::make_pair(*TypeElemIter, TypeInfoTy(*TypeElemIter, true)));
      SystemHeaders.insert(Header.getValue());
      NonDependencyTypes.insert(*TypeElemIter);
    } else {
      clang::TypeDecl *TypeElem = *TypeElemIter;

      if (!AllTypes.count(TypeElem)) {
        AllTypes.emplace(std::make_pair(TypeElem, TypeInfoTy(TypeElem, false)));
      }

      DiscoverTypesInDeclVisitor Visitor(
          [&TypeElem, &UnresolvedTypes, this](clang::TypeDecl *Dep) {
            if (!this->AllTypes.count(Dep)) {
              UnresolvedTypes.insert(Dep);
            }
            this->AllTypes.at(TypeElem).TypeDependencies.insert(Dep);
          });

      Visitor.TraverseDecl(TypeElem);
    }
    UnresolvedTypes.erase(TypeElemIter);
  }
}

void TypeDeclResolver::setInDegrees() {
  for (auto &Type : AllTypes) {
    for (auto &Dependency : Type.second.TypeDependencies) {
      AllTypes.at(Dependency).InDegree += 1;
    }
  }
}

bool TypeDeclResolver::orderAndWriteCodeFragments(TargetCode &TC) {
  // We write all code fragments to the front of TC, starting with types
  // on which no other type depends

  // merge system header sets
  for (auto &Header : SystemHeaders) {
    TC.addHeader(Header);
  }

  // We need to do topological sorting on our type tree.
  // For this we first must set the correct in degree for each type
  setInDegrees();

  std::queue<clang::TypeDecl *> OrderQueue;
  for (auto &Type : AllTypes) {
    if (Type.second.InDegree == 0) {
      OrderQueue.push(Type.first);
    }
  }

  int counter = 0; // used to check if we have a cycle

  while (!OrderQueue.empty()) {
    clang::TypeDecl *Decl = OrderQueue.front();
    OrderQueue.pop();

    if (!AllTypes.at(Decl).isFromSystemHeader) {
      auto CodeDecl = std::make_shared<TargetCodeDecl>(Decl);
      CodeDecl->NeedsSemicolon = true;
      TC.addCodeFragmentFront(CodeDecl);
    }

    for (auto &DepType : AllTypes.at(Decl).TypeDependencies) {
      AllTypes.at(DepType).InDegree -= 1;

      if (AllTypes.at(DepType).InDegree == 0) {
        OrderQueue.push(DepType);
      }
    }
    counter += 1;
  }

  if (counter != AllTypes.size()) {
    llvm::errs() << "ERROR: The Type Declaration Resolver encountered a "
                    "dependecy cylce\n";
    return false;
  }

  return true;
}
