#include "types.h"

/// Test ‘frem’ Instruction
///
/// Syntax:
///   <result> = frem [fast-math flags]* <ty> <op1>, <op2> ; yields ty:result
///
/// Overview:
///   The ‘frem’ instruction returns the remainder from the division of its two
///   operands.
///
/// Arguments:
///   The two arguments to the ‘frem’ instruction must be floating-point or
///   vector of floating-point values. Both arguments must have identical types.
///
/// Semantics:
///   The value produced is the floating-point remainder of the two operands.
///   This is the same output as a libm ‘fmod’ function, but without any
///   possibility of setting errno. The remainder has the same sign as the
///   dividend. This instruction is assumed to execute in the default
///   floating-point environment. This instruction can also take any number
///   of fast-math flags, which are optimization hints to enable otherwise
///   unsafe floating-point optimizations:
///
/// Example:
///
///   <result> = frem float 4.0, %var ; yields float:result = 4.0 % %var
///
/// Note:
///   We test only float/double/fp128.

#define FP_REM_VAR(TY, NAME) \
TY frem_ ## TY ## _var(TY a, TY b) { \
  return __builtin_ ## NAME(a, b); \
}
FP_REM_VAR(float, fmodf)
FP_REM_VAR(double, fmod)
FP_REM_VAR(quad, fmodl)

#define FP_REM_ZERO(TY, NAME) \
TY frem_ ## TY ## _zero(TY a) { \
  return __builtin_ ## NAME(0.0, a); \
}
FP_REM_ZERO(float, fmodf)
FP_REM_ZERO(double, fmod)
FP_REM_ZERO(quad, fmodl)

#define FP_REM_CONST(TY, NAME) \
TY frem_ ## TY ## _cont(TY a) { \
  return __builtin_ ## NAME(-2.0, a); \
}
FP_REM_CONST(float, fmodf)
FP_REM_CONST(double, fmod)
FP_REM_CONST(quad, fmodl)
