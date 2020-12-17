#include "types.h"
#include <complex.h>
#include <math.h>

/// Test ‘llvm.sin.*’ intrinsic
///
/// Syntax:
///   This is an overloaded intrinsic. You can use llvm.sin on any
///   floating-point or vector of floating-point type. Not all targets
///   support all types however.
///
/// declare float     @llvm.sin.f32(float  %Val)
/// declare double    @llvm.sin.f64(double %Val)
/// declare x86_fp80  @llvm.sin.f80(x86_fp80  %Val)
/// declare fp128     @llvm.sin.f128(fp128 %Val)
/// declare ppc_fp128 @llvm.sin.ppcf128(ppc_fp128  %Val)
///
/// Overview:
///   The ‘llvm.sin.*’ intrinsics return the sine of the operand.
///
/// Arguments:
///   The argument and return value are floating-point numbers of the same type.
///
/// Semantics:
///   Return the same value as a corresponding libm ‘sin’ function but without
///   trapping or setting errno.
///
///   When specified with the fast-math-flag ‘afn’, the result may be
///   approximated using a less accurate calculation.
///
/// Note:
///   We test only float/double/fp128.

#define FP_FSIN_VAR(TY, FNAME) \
TY fsin_ ## TY ## _var(TY a) { \
  return FNAME(a); \
}
FP_FSIN_VAR(float, sinf)
FP_FSIN_VAR(double, sin)
FP_FSIN_VAR(quad, sinl)

#define FP_FSIN_ZERO(TY, FNAME) \
TY fsin_ ## TY ## _zero() { \
  return FNAME((TY)0.0); \
}
FP_FSIN_ZERO(float, sinf)
FP_FSIN_ZERO(double, sin)
FP_FSIN_ZERO(quad, sinl)

#define FP_FSIN_CONST(TY, FNAME) \
TY fsin_ ## TY ## _const() { \
  return FNAME((TY)-2.0); \
}
FP_FSIN_CONST(float, sinf)
FP_FSIN_CONST(double, sin)
FP_FSIN_CONST(quad, sinl)
