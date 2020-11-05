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
} // namespace clang

class TargetRegionVariableShape {
public:
  enum ShapeKind { Pointer, ConstantArray, VariableArray };

private:
  unsigned int VariableDimensionIndex;
  std::string ConstantDimensionExpr;
  ShapeKind Kind;

public:
  inline ShapeKind getKind() const { return Kind; }
  inline bool isVariableArray() const {
    return Kind == ShapeKind::VariableArray;
  }
  inline bool isConstantArray() const {
    return Kind == ShapeKind::ConstantArray;
  }
  inline bool isArray() const {
    return Kind == ShapeKind::VariableArray || Kind == ShapeKind::ConstantArray;
  }
  inline bool isPointer() const { return Kind == ShapeKind::Pointer; }
  inline unsigned int getVariableDimensionIndex() const {
    return VariableDimensionIndex;
  }

  inline llvm::StringRef getConstantDimensionExpr() const {
    return llvm::StringRef(ConstantDimensionExpr);
  }
  /// Construct a pointer by default
  TargetRegionVariableShape() : Kind(ShapeKind::Pointer){};
  TargetRegionVariableShape(const clang::VariableArrayType *Array,
                            unsigned int DimIndex)
      : VariableDimensionIndex(DimIndex), Kind(ShapeKind::VariableArray){};
  TargetRegionVariableShape(const clang::ConstantArrayType *Array)
      : Kind(ShapeKind::ConstantArray) {
    ConstantDimensionExpr = Array->getSize().toString(10, false);
  }
};

/// Represents a variable captured by a target region.
/// This class is an abstraction that provides information on how the variable
/// is passed to the target region, whether it is a slice or array and how it's
/// dimensionality is declared
class TargetRegionVariable {
public:
  using shape_const_iterator =
      std::vector<TargetRegionVariableShape>::const_iterator;

  using shape_const_range = llvm::iterator_range<shape_const_iterator>;

  // https://clang.llvm.org/doxygen/Redeclarable_8h_source.html#l00239
  class shape_const_kind_iterator {
  public:
    using base_iter = std::vector<TargetRegionVariableShape>::const_iterator;

    using value_type = TargetRegionVariableShape;
    using reference = const TargetRegionVariableShape &;
    using pointer = const TargetRegionVariableShape *;
    using iterator_category = std::forward_iterator_tag;
    using difference_type = std::ptrdiff_t;

    using ShapeKind = TargetRegionVariableShape::ShapeKind;

  private:
    base_iter It;
    base_iter End;
    TargetRegionVariableShape::ShapeKind Kind;

  public:
    shape_const_kind_iterator() = delete;
    explicit shape_const_kind_iterator(ShapeKind Kind, base_iter I)
        : It(I), End(I), Kind(Kind) {}
    explicit shape_const_kind_iterator(ShapeKind Kind, base_iter I,
                                       base_iter End)
        : It(I), End(End), Kind(Kind) {

      while (It->getKind() != Kind && It != End) {
        It++;
      }
    };

    shape_const_kind_iterator &operator++() {
      if (It != End) {
        It++;
      }

      while (It != End && It->getKind() != Kind) {
        It++;
      }

      return *this;
    }

    shape_const_kind_iterator operator++(int) {
      shape_const_kind_iterator tmp(*this);
      ++(*this);
      return tmp;
    }

    reference operator*() const { return *It; }

    pointer operator->() { return It.operator->(); }

    friend bool operator==(shape_const_kind_iterator X,
                           shape_const_kind_iterator Y) {
      return X.Kind == Y.Kind && X.It == Y.It;
    }

    friend bool operator!=(shape_const_kind_iterator X,
                           shape_const_kind_iterator Y) {
      return X.Kind != Y.Kind || X.It != Y.It;
    }
  };

  using shape_const_kind_range =
      llvm::iterator_range<shape_const_kind_iterator>;

private:
  const clang::CapturedStmt::Capture *Capture;
  clang::VarDecl *Decl;
  std::string VarName;
  std::string BaseTypeName;
  std::vector<TargetRegionVariableShape> Shapes;
  unsigned int NumVariableArrayDims;
  void determineShapes(clang::QualType T);
  const std::map<clang::VarDecl *, clang::Expr *> &OmpMappingLowerBound;

public:
  /// The name of the variable.
  llvm::StringRef name() const { return llvm::StringRef(VarName); };
  /// The name of the base type (stripped of all qualifiers).
  llvm::StringRef baseTypeName() const {
    return llvm::StringRef(BaseTypeName);
  };
  /// The Decl node of the variable.
  clang::VarDecl *getDecl() const { return Decl; };
  /// Wether this variable is an array or not
  bool isArray() const;
  /// Returns true if this variable is passed by pointer.
  /// This is the case for shared and first-private variables scalars and for
  /// arrays.
  /// Note that pointer types are generally passed by value and we do not
  /// generate an additional * for it.
  bool passedByPointer() const;
  /// The lower bound of an array slice in the first dimension.
  /// All other dimension can be ignored because libomptarget only transfers
  /// continuous data.
  /// In case of a scalar (or an array which is mapped completly in the first
  /// dimension) this returns 0.
  llvm::Optional<clang::Expr *> arrayLowerBound() const;

  bool operator==(const TargetRegionVariable &Other) const {
    return Decl == Other.Decl;
  }

  /// Gives a range over the shape of all dimensions
  shape_const_range shapes() const {
    return shape_const_range(Shapes.cbegin(), Shapes.cend());
  }

  /// Gives a range over those shape dimensions which are variable arrays.
  /// This is called while generating the functions argument for variable array
  /// sizes.
  shape_const_kind_range variableArrayShapes() const {
    return shape_const_kind_range(
        shape_const_kind_iterator(
            TargetRegionVariableShape::ShapeKind::VariableArray,
            Shapes.cbegin(), Shapes.cend()),
        shape_const_kind_iterator(
            TargetRegionVariableShape::ShapeKind::VariableArray, Shapes.end()));
  }

  TargetRegionVariable(
      const clang::CapturedStmt::Capture *Capture,
      const std::map<clang::VarDecl *, clang::Expr *> &MappingLowerBounds);
};
