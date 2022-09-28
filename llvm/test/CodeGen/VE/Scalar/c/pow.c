#include "types.h"

/// Test ‘llvm.pow.*’ intrinsic
///
/// Syntax:
///   This is an overloaded intrinsic. You can use llvm.pow on any
///   floating-point or vector of floating-point type. Not all targets
///   support all types however.
///
/// declare float     @llvm.pow.f32(float  %Val, float %Power)
/// declare double    @llvm.pow.f64(double %Val, double %Power)
/// declare x86_fp80  @llvm.pow.f80(x86_fp80  %Val, x86_fp80 %Power)
/// declare fp128     @llvm.pow.f128(fp128 %Val, fp128 %Power)
/// declare ppc_fp128 @llvm.pow.ppcf128(ppc_fp128  %Val, ppc_fp128 Power)
///
/// Overview:
///   The ‘llvm.pow.*’ intrinsics return the first operand raised to
///   the specified (positive or negative) power.
///
/// Arguments:
///   The arguments and return value are floating-point numbers of
///   the same type.
///
/// Note:
///   We test only float/double/fp128.

#define FP_POW_VAR(TY, NAME) \
TY func_fp_pow_var_ ## TY(TY a, TY b) { \
  return __builtin_ ## NAME(a ,b); \
}
FP_POW_VAR(float, powf)
FP_POW_VAR(double, pow)
FP_POW_VAR(quad, powl)

#define FP_POW_ZERO_BACK(TY, NAME) \
TY func_fp_pow_zero_back_ ## TY(TY a) { \
  return __builtin_ ## NAME( a, (TY)0.0); \
}
FP_POW_ZERO_BACK(float, powf)
FP_POW_ZERO_BACK(double, pow)
FP_POW_ZERO_BACK(quad, powl)

#define FP_POW_ZERO_FORE(TY, NAME) \
TY func_fp_pow_zero_fore_ ## TY(TY a) { \
  return __builtin_ ## NAME((TY)0.0, a); \
}
FP_POW_ZERO_FORE(float, powf)
FP_POW_ZERO_FORE(double, pow)
FP_POW_ZERO_FORE(quad, powl)

#define FP_POW_CONST_BACK(TY, NAME) \
TY func_fp_pow_const_back_ ## TY(TY a) { \
  return __builtin_ ## NAME(a , (TY)-2.0); \
}
FP_POW_CONST_BACK(float, powf)
FP_POW_CONST_BACK(double, pow)
FP_POW_CONST_BACK(quad, powl)

#define FP_POW_CONST_FORE(TY, NAME) \
TY func_fp_pow_const_fore_ ## TY(TY a) { \
  return __builtin_ ## NAME((TY)-2.0, a); \
}
FP_POW_CONST_FORE(float, powf)
FP_POW_CONST_FORE(double, pow)
FP_POW_CONST_FORE(quad, powl)
