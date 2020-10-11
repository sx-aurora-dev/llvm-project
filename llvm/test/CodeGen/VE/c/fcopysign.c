#include "types.h"
#include <math.h>

/// Test ‘llvm.copysign.*’ Intrinsic
///
/// Syntax:
///   This is an overloaded intrinsic. You can use llvm.copysign on any
///   floating-point or vector of floating-point type. Not all targets
///   support all types however.
///
/// declare float     @llvm.copysign.f32(float  %Mag, float  %Sgn)
/// declare double    @llvm.copysign.f64(double %Mag, double %Sgn)
/// declare x86_fp80  @llvm.copysign.f80(x86_fp80  %Mag, x86_fp80  %Sgn)
/// declare fp128     @llvm.copysign.f128(fp128 %Mag, fp128 %Sgn)
/// declare ppc_fp128 @llvm.copysign.ppcf128(ppc_fp128  %Mag, ppc_fp128  %Sgn)
///
/// Overview:
///   The ‘llvm.copysign.*’ intrinsics return a value with the magnitude of
///   the first operand and the sign of the second operand.
///
/// Arguments:
///   The arguments and return value are floating-point numbers of the same
///   type.
///
/// Semantics:
///   This function returns the same values as the libm copysign functions
///   would, and handles error conditions in the same way.
///
/// Note:
///   We test only float/double/fp128.

#define FP_COPYSIGN_VAR(TY, FNAME) \
TY copysign_ ## TY ## _var(TY a, TY b) { \
  return FNAME(a, b); \
}
FP_COPYSIGN_VAR(float, copysignf)
FP_COPYSIGN_VAR(double, copysign)
FP_COPYSIGN_VAR(quad, copysignl)

#define FP_COPYSIGN_ZERO(TY, FNAME) \
TY copysign_ ## TY ## _zero(TY a) { \
  return FNAME((TY)0.0, a); \
}
FP_COPYSIGN_ZERO(float, copysignf)
FP_COPYSIGN_ZERO(double, copysign)
FP_COPYSIGN_ZERO(quad, copysignl)

#define FP_COPYSIGN_CONST(TY, FNAME) \
TY copysign_ ## TY ## _const(TY a) { \
  return FNAME((TY)-2.0, a); \
}
FP_COPYSIGN_CONST(float, copysignf)
FP_COPYSIGN_CONST(double, copysign)
FP_COPYSIGN_CONST(quad, copysignl)
