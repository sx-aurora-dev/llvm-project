#include "types.h"
#include <math.h>

/// Test ‘llvm.sqrt.*’ intrinsic
///
/// Syntax:
///   This is an overloaded intrinsic. You can use llvm.sqrt on any
///   floating-point or vector of floating-point type. Not all targets
///   support all types however.
///
/// declare float     @llvm.sqrt.f32(float %Val)
/// declare double    @llvm.sqrt.f64(double %Val)
/// declare x86_fp80  @llvm.sqrt.f80(x86_fp80 %Val)
/// declare fp128     @llvm.sqrt.f128(fp128 %Val)
/// declare ppc_fp128 @llvm.sqrt.ppcf128(ppc_fp128 %Val)
///
/// Overview:
///   The ‘llvm.sqrt’ intrinsics return the square root of the specified value.
///
/// Arguments:
///   The argument and return value are floating-point numbers of the same type.
///
/// Semantics:
///   Return the same value as a corresponding libm ‘sqrt’ function but without
///   trapping or setting errno. For types specified by IEEE-754, the result
///   matches a conforming libm implementation.
///
///   When specified with the fast-math-flag ‘afn’, the result may be
///   approximated using a less accurate calculation.
///
/// Note:
///   We test only float/double/fp128.

#define FP_FSQRT_VAR(TY, FNAME) \
TY fsqrt_ ## TY ## _var(TY a) { \
  return FNAME(a); \
}
FP_FSQRT_VAR(float, sqrtf)
FP_FSQRT_VAR(double, sqrt)
FP_FSQRT_VAR(quad, sqrtl)

#define FP_FSQRT_ZERO(TY, FNAME) \
TY fsqrt_ ## TY ## _zero() { \
  return  FNAME((TY)0.0) ; \
}
FP_FSQRT_ZERO(float, sqrtf)
FP_FSQRT_ZERO(double, sqrt)
FP_FSQRT_ZERO(quad, sqrtl)

#define FP_FSQRT_CONST(TY, FNAME) \
TY fsqrt_ ## TY ## _const() { \
  return FNAME((TY)-2.0); \
}
FP_FSQRT_CONST(float, sqrtf)
FP_FSQRT_CONST(double, sqrt)
FP_FSQRT_CONST(quad, sqrtl)
