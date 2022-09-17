#include "types.h"

/// Test ‘llvm.minnum.*’ intrinsic
///
/// Syntax:
///   This is an overloaded intrinsic. You can use llvm.minnum on any
///   floating-point or vector of floating-point type. Not all targets
///   support all types however.
///
/// declare float     @llvm.minnum.f32(float %Val0, float %Val1)
/// declare double    @llvm.minnum.f64(double %Val0, double %Val1)
/// declare x86_fp80  @llvm.minnum.f80(x86_fp80 %Val0, x86_fp80 %Val1)
/// declare fp128     @llvm.minnum.f128(fp128 %Val0, fp128 %Val1)
/// declare ppc_fp128 @llvm.minnum.ppcf128(ppc_fp128 %Val0, ppc_fp128 %Val1)
///
/// Overview:
///   The ‘llvm.minnum.*’ intrinsics return the minimum of the two arguments.
///
/// Arguments:
///   The arguments and return value are floating-point numbers of the same
///   type.
///
/// Semantics:
///   Follows the IEEE-754 semantics for minNum, except for handling of
///   signaling NaNs. This match’s the behavior of libm’s fmin.
///
///   If either operand is a NaN, returns the other non-NaN operand.
///   Returns NaN only if both operands are NaN. The returned NaN is
///   always quiet. If the operands compare equal, returns a value
///   that compares equal to both operands. This means that
///   fmin(+/-0.0, +/-0.0) could return either -0.0 or 0.0.
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

#define FP_FMIN_VAR(TY, NAME) \
TY func_fp_fmin_var_ ## TY(TY a, TY b) { \
  return __builtin_ ## NAME(a ,b); \
}
FP_FMIN_VAR(float, fminf)
FP_FMIN_VAR(double, fmin)
FP_FMIN_VAR(quad, fminl)

#define FP_FMIN_ZERO(TY, NAME) \
TY func_fp_fmin_zero_ ## TY(TY a) { \
  return __builtin_ ## NAME( a, (TY)0.0); \
}
FP_FMIN_ZERO(float, fminf)
FP_FMIN_ZERO(double, fmin)
FP_FMIN_ZERO(quad, fminl)

#define FP_FMIN_CONST(TY, NAME) \
TY func_fp_fmin_const_ ## TY(TY a) { \
  return __builtin_ ## NAME(a , (TY)-2.0); \
}
FP_FMIN_CONST(float, fminf)
FP_FMIN_CONST(double, fmin)
FP_FMIN_CONST(quad, fminl)
