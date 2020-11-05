#include "types.h"

/// Test ‘select’ instruction
///
/// Syntax:
///   <result> = select [fast-math flags] selty <cond>, <ty> <val1>, <ty> <val2>
///                                             ; yields ty
///
///   selty is either i1 or {<N x i1>}
///
/// Overview:
///   The ‘select’ instruction is used to choose one value based on a condition,
///   without IR-level branching.
///
/// Arguments:
///   The ‘select’ instruction requires an ‘i1’ value or a vector of ‘i1’ values
///   indicating the condition, and two values of the same first class type.
///
///   The optional fast-math flags marker indicates that the select has one or
///   more fast-math flags. These are optimization hints to enable otherwise
///   unsafe floating-point optimizations. Fast-math flags are only valid for
///   selects that return a floating-point scalar or vector type, or an array
///   (nested to any depth) of floating-point scalar or vector types.
///
/// Semantics:
///   If the condition is an i1 and it evaluates to 1, the instruction returns
///   the first value argument; otherwise, it returns the second value argument.
///
///   If the condition is a vector of i1, then the value arguments must be
///   vectors of the same size, and the selection is done element by element.
///
///   If the condition is an i1 and the value arguments are vectors of the same
///   size, then an entire vector is selected.
///
/// Example:
///   %X = select i1 true, i8 17, i8 42 ; yields i8:17
///
/// Note:
///   We test only i1/i8/u8/i16/u16/i32/u32/i64/u64/i128/u128/float/double/fp128

#define SELECT_VAR(TY) \
TY select_ ## TY ## _var(_Bool cmp, TY a, TY b) { \
  return cmp ? a : b; \
}

SELECT_VAR(i1)
SELECT_VAR(i8)
SELECT_VAR(u8)
SELECT_VAR(i16)
SELECT_VAR(u16)
SELECT_VAR(i32)
SELECT_VAR(u32)
SELECT_VAR(i64)
SELECT_VAR(u64)
SELECT_VAR(i128)
SELECT_VAR(u128)
SELECT_VAR(float)
SELECT_VAR(double)
SELECT_VAR(quad)

#define SELECT_MIMM_VAR(TY, LHS) \
TY select_ ## TY ## _mimm(_Bool cmp, TY a) { \
  return cmp ? LHS : a; \
}

SELECT_MIMM_VAR(i1, 1)
SELECT_MIMM_VAR(i8, -128)
SELECT_MIMM_VAR(u8, 127)
SELECT_MIMM_VAR(i16, -32768)
SELECT_MIMM_VAR(u16, 32767)
SELECT_MIMM_VAR(i32, 65535)
SELECT_MIMM_VAR(u32, 65535)
SELECT_MIMM_VAR(i64, 65535)
SELECT_MIMM_VAR(u64, 65535)
SELECT_MIMM_VAR(i128, 65535)
SELECT_MIMM_VAR(u128, 65535)
SELECT_MIMM_VAR(float, -2.0e+0)
SELECT_MIMM_VAR(double, -2.0e+0)
SELECT_MIMM_VAR(quad, -2.0e+0)

#define SELECT_VAR_MIMM(TY, RHS) \
TY select_mimm_ ## TY(_Bool cmp, TY a) { \
  return cmp ? a : RHS; \
}

SELECT_VAR_MIMM(i1, 1)
SELECT_VAR_MIMM(i8, -128)
SELECT_VAR_MIMM(u8, 127)
SELECT_VAR_MIMM(i16, -32768)
SELECT_VAR_MIMM(u16, 32767)
SELECT_VAR_MIMM(i32, 65535)
SELECT_VAR_MIMM(u32, 65535)
SELECT_VAR_MIMM(i64, 65535)
SELECT_VAR_MIMM(u64, 65535)
SELECT_VAR_MIMM(i128, 65535)
SELECT_VAR_MIMM(u128, 65535)
SELECT_VAR_MIMM(float, -2.0e+0)
SELECT_VAR_MIMM(double, -2.0e+0)
SELECT_VAR_MIMM(quad, -2.0e+0)
