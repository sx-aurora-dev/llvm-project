#include "types.h"
#include <math.h>

/// Test ‘fdiv’ Instruction
///
/// Syntax:
///   <result> = fdiv [fast-math flags]* <ty> <op1>, <op2> ; yields ty:result
///
/// Overview:
///   The ‘fdiv’ instruction returns the quotient of its two operands.
///
/// Arguments:
///   The two arguments to the ‘fdiv’ instruction must be floating-point or
///   vector of floating-point values. Both arguments must have identical types.
///
/// Semantics:
///   The value produced is the floating-point quotient of the two operands.
///   This instruction is assumed to execute in the default floating-point
///   environment. This instruction can also take any number of fast-math
///   flags, which are optimization hints to enable otherwise unsafe
///   floating-point optimizations:
///
/// Example:
///   <result> = fdiv float 4.0, %var ; yields float:result = 4.0 / %var
///
/// Note:
///   We test only float/double/fp128.

#define FP_FDIV_VAR(TY) \
TY fdiv_ ## TY ## _var(TY a, TY b) { \
  return a / b; \
}
FP_FDIV_VAR(float)
FP_FDIV_VAR(double)
FP_FDIV_VAR(quad)

#define FP_FDIV_ZERO_FORE(TY) \
TY fdiv_ ## TY ## _zero_fore(TY a) { \
  return  0.0 / a; \
}
FP_FDIV_ZERO_FORE(float)
FP_FDIV_ZERO_FORE(double)
FP_FDIV_ZERO_FORE(quad)

#define FP_FDIV_CONST_BACK(TY) \
TY fdiv_ ## TY ## _const_back(TY a) { \
  return a / (-2.0); \
}
FP_FDIV_CONST_BACK(float)
FP_FDIV_CONST_BACK(double)
FP_FDIV_CONST_BACK(quad)

#define FP_FDIV_CONST_FORE(TY) \
TY fdiv_ ## TY ## _cont_fore(TY a) { \
  return  -2.0 / a; \
}
FP_FDIV_CONST_FORE(float)
FP_FDIV_CONST_FORE(double)
FP_FDIV_CONST_FORE(quad)
