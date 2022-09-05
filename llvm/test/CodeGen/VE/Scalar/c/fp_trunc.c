#include "types.h"

#define FP_TRUNC_VAR(TY, NAME) \
TY func_fp_trunc_var_ ## TY(TY a) { \
  return __builtin_ ## NAME(a); \
}
FP_TRUNC_VAR(float, truncf)
FP_TRUNC_VAR(double, trunc)
FP_TRUNC_VAR(quad, truncl)

#define FP_TRUNC_ZERO(TY, NAME) \
TY func_fp_trunc_zero_ ## TY() { \
  return __builtin_ ## NAME((TY)0.0); \
}
FP_TRUNC_ZERO(float, truncf)
FP_TRUNC_ZERO(double, trunc)
FP_TRUNC_ZERO(quad, truncl)

#define FP_TRUNC_CONST(TY, NAME) \
TY func_fp_trunc_const_ ## TY() { \
  return __builtin_ ## NAME((TY)-2.0); \
}
FP_TRUNC_CONST(float, truncf)
FP_TRUNC_CONST(double, trunc)
FP_TRUNC_CONST(quad, truncl)
