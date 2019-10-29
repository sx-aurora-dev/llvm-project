//===-- sotoc/src/TargetRegionVariable.cpp --------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
///
/// \file
/// This file implements the class TargetRegionVariable
///
//===----------------------------------------------------------------------===//


#include "clang/AST/Decl.h"
#include "clang/AST/Expr.h"
#include "clang/AST/Type.h"

#include "TargetRegionVariable.h"

TargetRegionVariable::TargetRegionVariable(const clang::CapturedStmt::Capture *Capture, const std::map<clang::VarDecl *, clang::Expr *> &MappingLowerBounds)
    : Capture(Capture), Decl(Capture->getCapturedVar()),
      OmpMappingLowerBound(MappingLowerBounds) {

  VarName = Decl->getDeclName().getAsString();

  auto DeclType = Decl->getType();
  // If Decl is an array: get to the base type
  if (auto *AT = llvm::dyn_cast<clang::ArrayType>(DeclType.getTypePtr())) {
    while (auto *NAT =  llvm::dyn_cast<clang::ArrayType>(AT->getElementType().getTypePtr())) {
      AT = NAT;
    }
    TypeName = AT->getElementType().getAsString();
  } else {
    TypeName = DeclType.getAsString();
  }

  if (auto ArrayType = llvm::dyn_cast<clang::ArrayType>(Decl->getType().getTypePtr())) {
    determineDimensionSizes(ArrayType, 0);
  }
}

void TargetRegionVariable::determineDimensionSizes(
    const clang::ArrayType *T, unsigned int CurrentDimension) {
  if (auto *SubArray = llvm::dyn_cast_or_null<clang::ConstantArrayType>(T)) {
    DimensionSizes.push_back(SubArray->getSize().toString(10, false));
  } else if (auto *SubArray =
                 llvm::dyn_cast_or_null<clang::VariableArrayType>(T)) {
    // For variable sized array dimension we get the size as an additonal
    // parameter to the target function.
    std::string PrettyStr = "";
    llvm::raw_string_ostream PrettyOS(PrettyStr);
    PrettyOS << "__sotoc_vla_dim" << CurrentDimension << "_" << VarName;
    DimensionSizes.push_back(PrettyOS.str());
    VarSizedDimensions.push_back(CurrentDimension);
  }

  CurrentDimension++;
  auto *NextDimensionArray = clang::dyn_cast_or_null<clang::ArrayType>(
      T->getElementType().getTypePtr());
  if (NextDimensionArray) {
    determineDimensionSizes(NextDimensionArray, CurrentDimension);
  }
}

bool TargetRegionVariable::isArray() const {
  return llvm::isa<clang::ArrayType>(Decl->getType().getTypePtr());
}

bool TargetRegionVariable::passedByPointer() const {
  if (isArray()) {
    // Arrays are always passed by pointer
    return true;
  }
  return Capture->capturesVariable();
}

llvm::Optional<clang::Expr *> TargetRegionVariable::arrayLowerBound() const {
  auto FindBound = OmpMappingLowerBound.find(Decl);
  if (FindBound != OmpMappingLowerBound.cend()) {
    return llvm::Optional<clang::Expr *>(FindBound->second);
  }
  return llvm::Optional<clang::Expr *>();
}
