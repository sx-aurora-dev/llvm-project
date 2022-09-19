#include "types.h"

/// Test ‘llvm.maxnum.*’ intrinsic
///
/// Syntax:
///   This is an overloaded intrinsic. You can use llvm.maxnum on any
///   floating-point or vector of floating-point type. Not all targets
///   support all types however.
///
/// declare float     @llvm.maxnum.f32(float  %Val0, float  %Val1)
/// declare double    @llvm.maxnum.f64(double %Val0, double %Val1)
/// declare x86_fp80  @llvm.maxnum.f80(x86_fp80  %Val0, x86_fp80  %Val1)
/// declare fp128     @llvm.maxnum.f128(fp128 %Val0, fp128 %Val1)
/// declare ppc_fp128 @llvm.maxnum.ppcf128(ppc_fp128  %Val0, ppc_fp128  %Val1)
///
/// Overview:
///   The ‘llvm.maxnum.*’ intrinsics return the maximum of the two arguments.
///
/// Arguments:
///   The arguments and return value are floating-point numbers of the same
///   type.
///
/// Semantics:
///   Follows the IEEE-754 semantics for maxNum except for the handling of
///   signaling NaNs. This matches the behavior of libm’s fmax.
///
///   If either operand is a NaN, returns the other non-NaN operand.
///   Returns NaN only if both operands are NaN. The returned NaN is
///   always quiet. If the operands compare equal, returns a value
///   that compares equal to both operands. This means that
///   fmax(+/-0.0, +/-0.0) could return either -0.0 or 0.0.
///
///   Unlike the IEEE-754 2008 behavior, this does not distinguish between
///   signaling and quiet NaN inputs. If a target’s implementation follows
///   the standard and returns a quiet NaN if either input is a signaling
///   NaN, the intrinsic lowering is responsible for quieting the inputs
///   to correctly return the non-NaN input (e.g. by using the equivalent
///   of llvm.canonicalize).
///
/// Note:
///   We test only float/double/fp128.

#define FP_FMAX_VAR(TY, NAME) \
TY func_fp_fmax_var_ ## TY(TY a, TY b) { \
  return __builtin_ ## NAME(a ,b); \
}
FP_FMAX_VAR(float, fmaxf)
FP_FMAX_VAR(double, fmax)
FP_FMAX_VAR(quad, fmaxl)

#define FP_FMAX_ZERO(TY, NAME) \
TY func_fp_fmax_zero_ ## TY(TY a) { \
  return __builtin_ ## NAME( a, (TY)0.0); \
}
FP_FMAX_ZERO(float, fmaxf)
FP_FMAX_ZERO(double, fmax)
FP_FMAX_ZERO(quad, fmaxl)

#define FP_FMAX_CONST(TY, NAME) \
TY func_fp_fmax_const_ ## TY(TY a) { \
  return __builtin_ ## NAME(a , (TY)-2.0); \
}
FP_FMAX_CONST(float, fmaxf)
FP_FMAX_CONST(double, fmax)
FP_FMAX_CONST(quad, fmaxl)
