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
#include <string>
#include <llvm/ADT/StringRef.h>
#include <clang/AST/TypeLoc.h>
#include <clang/AST/Stmt.h>

namespace clang {
class Expr;
class VarDecl;
class CapturedStmt;
} // namespace clang

/// Describes the shape, i.e. a variable dimension of constant or variable
/// size, or a pointer.
/// We collect this information for every parameter of a target region function
/// because the pretty printer does not support the output format for variable
/// and types (e.g. it prints 'int (*)[SIZE] a' instead of 'int (*) a[SIZE]'),
/// so we print this manually in \ref TargetCode.cpp.
/// For this we need every pointer indirection and array dimension which each
/// is saved as shapes for that variable.
class TargetRegionVariableShape {
public:
  enum ShapeKind { Pointer, Paren, ConstantArray, VariableArray };

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
  /// If the shape is a variable array, return the array dimension index, (used
  /// for generating __sotoc_vla_dimX_ parameters in which the host signals the
  /// array's size).
  inline unsigned int getVariableDimensionIndex() const {
    return VariableDimensionIndex;
  }

  /// If the shape is a constant array, it returns the rendered expression for
  /// the constant size.
  inline llvm::StringRef getConstantDimensionExpr() const {
    return llvm::StringRef(ConstantDimensionExpr);
  }
  /// Construct a pointer shape by default.
  TargetRegionVariableShape() : Kind(ShapeKind::Pointer){};
  /// Construct a parentheses shape
  TargetRegionVariableShape(const clang::ParenType *Paren)
      : Kind(ShapeKind::Paren){};
  /// Construct a shape for a variable array dimension.
  TargetRegionVariableShape(const clang::VariableArrayType *Array,
                            unsigned int DimIndex)
      : VariableDimensionIndex(DimIndex), Kind(ShapeKind::VariableArray){};
  /// Construct a shape for a constant array dimension.
  TargetRegionVariableShape(const clang::ConstantArrayType *Array)
      : Kind(ShapeKind::ConstantArray) {
    llvm::SmallString<128> Buffer;
    Array->getSize().toString(Buffer, false, false);
    ConstantDimensionExpr = (std::string) Buffer;
  }
};

/// Represents a variable captured by a target region.
/// This class is an abstraction that provides information on how the variable
/// is passed to the target region, whether it is a slice or array and how it's
/// dimensionality is declared
class TargetRegionVariable {
public:

  /// Iterator of all shapes of this variable.
  using shape_const_iterator =
      std::vector<TargetRegionVariableShape>::const_iterator;

  /// Range over all shapes of this variable.
  using shape_const_range = llvm::iterator_range<shape_const_iterator>;

  /// Iterator which acts as a filter over std::vector<TargetRegionVariableShape>::const_iterator
  /// (the base_iter) which only passes on TargetRegionVariableShape of the
  /// kind specified in #Kind.
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
    /// Explicitly constructs an iterator from the base_iter- Both the start
    /// and end of the iterator will be set to the same paramter \p I.
    /// Use this to construct an end() iterator from std::vector<>::cend().
    explicit shape_const_kind_iterator(ShapeKind Kind, base_iter I)
        : It(I), End(I), Kind(Kind) {}
    /// Explicitly constructs an iterator from cbegin() and cend() of
    /// base_iter.
    /// Use this to construct a begin() from std::vector<>::cbegin() and
    /// std::vector<>::cend(). The iterator needs to operate on the base_iter
    /// at construction to ensure that a non-empty vector which does not contain
    /// elements of the right #Kind is handled correctly.
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

  /// Range over all shapes of a certain kind of this variable.
  using shape_const_kind_range =
      llvm::iterator_range<shape_const_kind_iterator>;

private:
  const clang::CapturedStmt::Capture *Capture;
  clang::VarDecl *Decl;
  std::string VarName;
  /// This is the base type name, i.e. the name of the type without pointer or
  /// array qualifiers.
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
  /// Whether this variable's type contains an array or not
  bool containsArray() const;
  /// Whether this variable's type contains a pointer or not
  bool containsPointer() const;
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
