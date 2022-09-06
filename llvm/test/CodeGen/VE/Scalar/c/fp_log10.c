#include "types.h"

#define FP_LOG10_VAR(TY, NAME) \
TY func_fp_log10_var_ ## TY(TY a) { \
  return __builtin_ ## NAME(a); \
}
FP_LOG10_VAR(float, log10f)
FP_LOG10_VAR(double, log10)
FP_LOG10_VAR(quad, log10l)

#define FP_LOG10_ZERO(TY, NAME) \
TY func_fp_log10_zero_ ## TY() { \
  return __builtin_ ## NAME((TY)0.0); \
}
FP_LOG10_ZERO(float, log10f)
FP_LOG10_ZERO(double, log10)
FP_LOG10_ZERO(quad, log10l)

#define FP_LOG10_CONST(TY, NAME) \
TY func_fp_log10_const_ ## TY() { \
  return __builtin_ ## NAME((TY)-2.0); \
}
FP_LOG10_CONST(float, log10f)
FP_LOG10_CONST(double, log10)
FP_LOG10_CONST(quad, log10l)
