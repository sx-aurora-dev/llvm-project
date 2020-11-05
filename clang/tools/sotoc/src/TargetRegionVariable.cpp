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

TargetRegionVariable::TargetRegionVariable(
    const clang::CapturedStmt::Capture *Capture,
    const std::map<clang::VarDecl *, clang::Expr *> &MappingLowerBounds)
    : Capture(Capture), Decl(Capture->getCapturedVar()),
      NumVariableArrayDims(0), OmpMappingLowerBound(MappingLowerBounds) {

  VarName = Decl->getDeclName().getAsString();

  determineShapes(Decl->getType());
}
/*
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
}*/

void TargetRegionVariable::determineShapes(const clang::QualType T) {
  if (const auto *AT = llvm::dyn_cast<clang::ArrayType>(T.getTypePtr())) {
    if (const auto *CAT = llvm::dyn_cast<clang::ConstantArrayType>(AT)) {
      Shapes.push_back(TargetRegionVariableShape(CAT));
    } else if (const auto *VAT = llvm::dyn_cast<clang::VariableArrayType>(AT)) {
      Shapes.push_back(TargetRegionVariableShape(VAT, NumVariableArrayDims));
    }
    NumVariableArrayDims++;
    return determineShapes(AT->getElementType());
  } else if (auto *PT = llvm::dyn_cast<clang::PointerType>(T.getTypePtr())) {
    Shapes.push_back(TargetRegionVariableShape());
    return determineShapes(PT->getPointeeType());
  } else {
    BaseTypeName = T.getAsString();
  }
}

bool TargetRegionVariable::isArray() const {
  if (!Shapes.empty() && Shapes[0].isArray()) {
    return true;
  }
  return false;
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
