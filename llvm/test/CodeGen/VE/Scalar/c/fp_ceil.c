#include "types.h"

#define FP_CEIL_VAR(TY, NAME) \
TY func_fp_ceil_var_ ## TY(TY a) { \
  return __builtin_ ## NAME(a); \
}
FP_CEIL_VAR(float, ceilf)
FP_CEIL_VAR(double, ceil)
FP_CEIL_VAR(quad, ceill)

#define FP_CEIL_ZERO(TY, NAME) \
TY func_fp_ceil_zero_ ## TY() { \
  return __builtin_ ## NAME((TY)0.0); \
}
FP_CEIL_ZERO(float, ceilf)
FP_CEIL_ZERO(double, ceil)
FP_CEIL_ZERO(quad, ceill)

#define FP_CEIL_CONST(TY, NAME) \
TY func_fp_ceil_const_ ## TY() { \
  return __builtin_ ## NAME((TY)-2.0); \
}
FP_CEIL_CONST(float, ceilf)
FP_CEIL_CONST(double, ceil)
FP_CEIL_CONST(quad, ceill)
