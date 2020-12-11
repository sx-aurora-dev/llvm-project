#include "types.h"
#include <math.h>

/// Test ‘llvm.fabs.*’ Intrinsic
///
/// Syntax:
///   This is an overloaded intrinsic. You can use llvm.fabs on any
///   floating-point or vector of floating-point type. Not all targets
///   support all types however.
///
/// declare float     @llvm.fabs.f32(float  %Val)
/// declare double    @llvm.fabs.f64(double %Val)
/// declare x86_fp80  @llvm.fabs.f80(x86_fp80 %Val)
/// declare fp128     @llvm.fabs.f128(fp128 %Val)
/// declare ppc_fp128 @llvm.fabs.ppcf128(ppc_fp128 %Val)
///
/// Overview:
///   The ‘llvm.fabs.*’ intrinsics return the absolute value of the operand.
///
/// Arguments:
///   The argument and return value are floating-point numbers of the same
///   type.
///
/// Semantics:
///   This function returns the same values as the libm fabs functions would,
///   and handles error conditions in the same way.
///
/// Note:
///   We test only float/double/fp128.

#define FP_FABS_VAR(TY, FNAME) \
TY fabs_ ## TY ## _var(TY a) { \
  return FNAME(a); \
}
FP_FABS_VAR(float, fabsf)
FP_FABS_VAR(double, fabs)
FP_FABS_VAR(quad, fabsl)

#define FP_FABS_ZERO(TY, FNAME) \
TY fabs_ ## TY ## _zero() { \
  return FNAME((TY)0.0); \
}
FP_FABS_ZERO(float, fabsf)
FP_FABS_ZERO(double, fabs)
FP_FABS_ZERO(quad, fabsl)

#define FP_FABS_CONST(TY, FNAME) \
TY fabs_ ## TY ## _const() { \
  return FNAME((TY)-2.0); \
}
FP_FABS_CONST(float, fabsf)
FP_FABS_CONST(double, fabs)
FP_FABS_CONST(quad, fabsl)
