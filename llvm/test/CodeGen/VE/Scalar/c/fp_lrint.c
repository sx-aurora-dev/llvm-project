#include "types.h"

#define FP_LRINT_VAR(TY, NAME) \
i64 func_fp_lrint_var_ ## TY(TY a) { \
  return __builtin_ ## NAME(a); \
}
FP_LRINT_VAR(float, lrintf)
FP_LRINT_VAR(double, lrint)
FP_LRINT_VAR(quad, lrintl)

#define FP_LRINT_ZERO(TY, NAME) \
i64 func_fp_lrint_zero_ ## TY() { \
  return __builtin_ ## NAME((TY)0.0); \
}
FP_LRINT_ZERO(float, lrintf)
FP_LRINT_ZERO(double, lrint)
FP_LRINT_ZERO(quad, lrintl)

#define FP_LRINT_CONST(TY, NAME) \
i64 func_fp_lrint_const_ ## TY() { \
  return __builtin_ ## NAME((TY)-2.0); \
}
FP_LRINT_CONST(float, lrintf)
FP_LRINT_CONST(double, lrint)
FP_LRINT_CONST(quad, lrintl)
