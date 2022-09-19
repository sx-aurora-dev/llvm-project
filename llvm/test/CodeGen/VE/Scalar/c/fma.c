#include "types.h"
#include <complex.h>
#include <math.h>

/// Test ‘llvm.fma.*’ intrinsic
///
/// Syntax:
///   This is an overloaded intrinsic. You can use llvm.fma on any
///   floating-point or vector of floating-point type. Not all targets
///   support all types however.
///
/// declare float     @llvm.fma.f32(float  %a, float  %b, float  %c)
/// declare double    @llvm.fma.f64(double %a, double %b, double %c)
/// declare x86_fp80  @llvm.fma.f80(x86_fp80 %a, x86_fp80 %b, x86_fp80 %c)
/// declare fp128     @llvm.fma.f128(fp128 %a, fp128 %b, fp128 %c)
/// declare ppc_fp128 @llvm.fma.ppcf128(ppc_fp128 %a, ppc_fp128 %b,
///                                     ppc_fp128 %c)
///
/// Overview:
///   The ‘llvm.fma.*’ intrinsics perform the fused multiply-add operation.
///
/// Arguments:
///   The arguments and return value are floating-point numbers of the same
///   type.
///
/// Semantics:
///   Return the same value as a corresponding libm ‘fma’ function but without
///   trapping or setting errno.
///
///   When specified with the fast-math-flag ‘afn’, the result may be
///   approximated using a less accurate calculation.
///
/// Note:
///   We test only float/double/fp128.

#define FP_FMA_VAR(TY, FNAME) \
TY fma_ ## TY ## _var(TY a, TY b, TY c) { \
  return FNAME(a, b, c); \
}
FP_FMA_VAR(float, fmaf)
FP_FMA_VAR(double, fma)
FP_FMA_VAR(quad, fmal)

#define FP_FMA_FORE_ZERO(TY, FNAME) \
TY fma_ ## TY ## _fore_zero(TY a, TY b) { \
  return FNAME((TY)0.0, a, b); \
}
FP_FMA_FORE_ZERO(float, fmaf)
FP_FMA_FORE_ZERO(double, fma)
FP_FMA_FORE_ZERO(quad, fmal)

#define FP_FMA_BACK_ZERO(TY, FNAME) \
TY fma_ ## TY ## _back_zero(TY a, TY b) { \
  return FNAME(a, (TY)0.0, b); \
}
FP_FMA_BACK_ZERO(float, fmaf)
FP_FMA_BACK_ZERO(double, fma)
FP_FMA_BACK_ZERO(quad, fmal)

#define FP_FMA_FORE_CONST(TY, FNAME) \
TY fma_ ## TY ## _fore_const(TY a, TY b) { \
  return FNAME((TY)-2.0, a, b); \
}
FP_FMA_FORE_CONST(float, fmaf)
FP_FMA_FORE_CONST(double, fma)
FP_FMA_FORE_CONST(quad, fmal)

#define FP_FMA_BACK_CONST(TY, FNAME) \
TY fma_ ## TY ## _back_const(TY a, TY b) { \
  return FNAME(a, (TY)-2.0, b); \
}
FP_FMA_BACK_CONST(float, fmaf)
FP_FMA_BACK_CONST(double, fma)
FP_FMA_BACK_CONST(quad, fmal)
