#include "types.h"

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
