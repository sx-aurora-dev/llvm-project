#include "types.h"

#define FP_RINT_VAR(TY, NAME) \
TY func_fp_rint_var_ ## TY(TY a) { \
  return __builtin_ ## NAME(a); \
}
FP_RINT_VAR(float, rintf)
FP_RINT_VAR(double, rint)
FP_RINT_VAR(quad, rintl)

#define FP_RINT_ZERO(TY, NAME) \
TY func_fp_rint_zero_ ## TY() { \
  return __builtin_ ## NAME((TY)0.0); \
}
FP_RINT_ZERO(float, rintf)
FP_RINT_ZERO(double, rint)
FP_RINT_ZERO(quad, rintl)

#define FP_RINT_CONST(TY, NAME) \
TY func_fp_rint_const_ ## TY() { \
  return __builtin_ ## NAME((TY)-2.0); \
}
FP_RINT_CONST(float, rintf)
FP_RINT_CONST(double, rint)
FP_RINT_CONST(quad, rintl)
