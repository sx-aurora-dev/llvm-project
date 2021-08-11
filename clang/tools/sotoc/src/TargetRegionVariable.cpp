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

void TargetRegionVariable::determineShapes(const clang::QualType T) {
  // We want to determine the shapes of this variable from it's qualifiers
  if (const auto *AT = llvm::dyn_cast<clang::ArrayType>(T.getTypePtr())) {
    // We have a constant or variable length array
    if (const auto *CAT = llvm::dyn_cast<clang::ConstantArrayType>(AT)) {
      Shapes.push_back(TargetRegionVariableShape(CAT));
    } else if (const auto *VAT = llvm::dyn_cast<clang::VariableArrayType>(AT)) {
      Shapes.push_back(TargetRegionVariableShape(VAT, NumVariableArrayDims));
    }
    // The variable NumVariableArrayDims is basically stored to keep track how
    // many array dimensions there are. Each variable length array dimension we
    // record gets an index, later used to generate the __sotoc_vla_dimX
    // parameters in which the host sends the variable size to the target
    // region.
    NumVariableArrayDims++;
    return determineShapes(AT->getElementType());
  } else if (auto *PT = llvm::dyn_cast<clang::PointerType>(T.getTypePtr())) {
    // Poniters are easy: just record that we have a pointer (default constructed)
    Shapes.push_back(TargetRegionVariableShape());
    return determineShapes(PT->getPointeeType());
  } else if (auto *PT = llvm::dyn_cast<clang::ParenType>(T.getTypePtr())) {
    // Clang uses ParenType as sugar when there are parenthesis in the type
    // declaration (I hate my life). Ignore that.
    return determineShapes(PT->getInnerType());
  } else {
    // We have found the base type (without array dimensions or pointer specifiers).
    BaseTypeName = T.getAsString();
  }
}

bool TargetRegionVariable::isArray() const {
  if (!Shapes.empty() && Shapes[0].isArray()) {
    return true;
  }
  return false;
}

// get depth of point nest
int TargetRegionVariable::pointerDepth() const {
  int i = 0;
  if (!Shapes.empty()) {
    for (i; Shapes[i].isPointer(); ++i)
      ;
  }
  return i;
}

// bool TargetRegionVariable::isPointer() const {
//  if (!Shapes.empty() && Shapes[0].isPointer()) {
//    return true;
//  }
//  return false;
// }

bool TargetRegionVariable::passedByPointer() const {
  if (isArray()||isPointer()) {
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
