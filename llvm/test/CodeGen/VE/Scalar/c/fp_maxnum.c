#include "types.h"

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
