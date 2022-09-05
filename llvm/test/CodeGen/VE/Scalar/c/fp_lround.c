#include "types.h"

#define FP_LROUND_VAR(TY, NAME) \
i64 func_fp_lround_var_ ## TY(TY a) { \
  return __builtin_ ## NAME(a); \
}
FP_LROUND_VAR(float, lroundf)
FP_LROUND_VAR(double, lround)
FP_LROUND_VAR(quad, lroundl)

#define FP_LROUND_ZERO(TY, NAME) \
i64 func_fp_lround_zero_ ## TY() { \
  return __builtin_ ## NAME((TY)0.0); \
}
FP_LROUND_ZERO(float, lroundf)
FP_LROUND_ZERO(double, lround)
FP_LROUND_ZERO(quad, lroundl)

#define FP_LROUND_CONST(TY, NAME) \
i64 func_fp_lround_const_ ## TY() { \
  return __builtin_ ## NAME((TY)-2.0); \
}
FP_LROUND_CONST(float, lroundf)
FP_LROUND_CONST(double, lround)
FP_LROUND_CONST(quad, lroundl)
