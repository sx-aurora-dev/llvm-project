#include "types.h"
#include <complex.h>
#include <math.h>

/// Test ‘llvm.cos.*’ intrinsic
///
/// Syntax:
///   This is an overloaded intrinsic. You can use llvm.cos on any
///   floating-point or vector of floating-point type. Not all targets
///   support all types however.
///
/// declare float     @llvm.cos.f32(float  %Val)
/// declare double    @llvm.cos.f64(double %Val)
/// declare x86_fp80  @llvm.cos.f80(x86_fp80  %Val)
/// declare fp128     @llvm.cos.f128(fp128 %Val)
/// declare ppc_fp128 @llvm.cos.ppcf128(ppc_fp128  %Val)
///
/// Overview:
///   The ‘llvm.cos.*’ intrinsics return the cosine of the operand.
///
/// Arguments:
///   The argument and return value are floating-point numbers of the same type.
///
/// Semantics:
///   Return the same value as a corresponding libm ‘cos’ function but without
///   trapping or setting errno.
///
///   When specified with the fast-math-flag ‘afn’, the result may be
///   approximated using a less accurate calculation.
///
/// Note:
///   We test only float/double/fp128.

#define FP_FCOS_VAR(TY, FNAME) \
TY fcos_ ## TY ## _var(TY a) { \
  return FNAME(a); \
}
FP_FCOS_VAR(float, cosf)
FP_FCOS_VAR(double, cos)
FP_FCOS_VAR(quad, cosl)

#define FP_FCOS_ZERO(TY, FNAME) \
TY fcos_ ## TY ## _zero() { \
  return FNAME((TY)0.0); \
}
FP_FCOS_ZERO(float, cosf)
FP_FCOS_ZERO(double, cos)
FP_FCOS_ZERO(quad, cosl)

#define FP_FCOS_CONST(TY, FNAME) \
TY fcos_ ## TY ## _const() { \
  return FNAME((TY)-2.0); \
}
FP_FCOS_CONST(float, cosf)
FP_FCOS_CONST(double, cos)
FP_FCOS_CONST(quad, cosl)
