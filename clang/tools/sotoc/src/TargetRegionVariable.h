//===-- sotoc/src/TargetRegionVariable.h ----------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#pragma once

#include <map>
#include <vector>

namespace clang {
  class Expr;
  class VarDecl;
  class CapturedStmt;
}

/// Represents a variable captured by a target region.
/// This class is an abstraction that provides information on how the variable
/// is passed to the target region, whether it is a slice or array and how it's
/// dimensionality is declared
class TargetRegionVariable {

  const clang::CapturedStmt::Capture *Capture;
  clang::VarDecl *Decl;
  std::string VarName;
  std::string TypeName;
  std::vector<std::string> DimensionSizes;
  std::vector<unsigned int> VarSizedDimensions;
  void determineDimensionSizes(const clang::ArrayType *T,
                               unsigned int CurrentDimension);

public:
  /// Const range over strings that specify the size of each dimension of an
  /// array.
  using const_dimension_sizes_range =
      llvm::iterator_range<std::vector<std::string>::const_iterator>;
  /// Const size over indices of variable sized dimensions.
  using variable_sized_dimensions_range =
      llvm::iterator_range<std::vector<unsigned int>::const_iterator>;

private:
  const std::map<clang::VarDecl *, clang::Expr *> &OmpMappingLowerBound;

public:
  /// The name of the variable.
  llvm::StringRef name() const {
    return llvm::StringRef(VarName);
  };
  /// The name of the type variable.
  llvm::StringRef typeName() const {
    return llvm::StringRef(TypeName);
  };
  /// The Decl node of the variable.
  clang::VarDecl *getDecl() const {
    return Decl;
  };
  /// Wether this variable is an array or not
  bool isArray() const;
  /// Returns true if this variable is passed by pointer.
  /// This is the case for shared and first-private variables scalars and for
  /// arrays.
  bool passedByPointer() const;
  /// Returns the (ordered) indices of the array dimensions which are variable
  /// (i.e. non-constants).
  /// Does not yield any values if the variable is a scalar.
  variable_sized_dimensions_range variabledSizedArrayDimensions() const {
    return variable_sized_dimensions_range(VarSizedDimensions.cbegin(),
                                           VarSizedDimensions.cend());
  }
  /// The lower bound of an array slice in the first dimension.
  /// All other dimension can be ignored because libomptarget only transfers
  /// continuous data.
  /// In case of a scalar (or an array which is mapped completly in the first
  /// dimension) this returns 0.
  llvm::Optional<clang::Expr *> arrayLowerBound() const;
  /// Returns the size of each dimension of an array, as strings taken from the
  /// declaration.
  /// Because these sizes are only used when printing them back into the target
  /// code, strings are returned.
  /// When the class represents a scalar, then there are no elements to iterate
  /// over. When the size of a dimension is not declared, then an empty string
  /// is returned.
  const_dimension_sizes_range arrayDimensionSizes() const {
    return const_dimension_sizes_range(DimensionSizes.cbegin(),
                                       DimensionSizes.cend());
  }

  bool operator==(const TargetRegionVariable &Other) const {
    return Decl == Other.Decl;
  }

  TargetRegionVariable(const clang::CapturedStmt::Capture* Capture, const std::map<clang::VarDecl *, clang::Expr *> &MappingLowerBounds);
};
