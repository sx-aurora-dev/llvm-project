#include "types.h"

#define FP_EXP_VAR(TY, NAME) \
TY func_fp_exp_var_ ## TY(TY a) { \
  return __builtin_ ## NAME(a); \
}
FP_EXP_VAR(float, expf)
FP_EXP_VAR(double, exp)
FP_EXP_VAR(quad, expl)

#define FP_EXP_ZERO(TY, NAME) \
TY func_fp_exp_zero_ ## TY() { \
  return __builtin_ ## NAME((TY)0.0); \
}
FP_EXP_ZERO(float, expf)
FP_EXP_ZERO(double, exp)
FP_EXP_ZERO(quad, expl)

#define FP_EXP_CONST(TY, NAME) \
TY func_fp_exp_const_ ## TY() { \
  return __builtin_ ## NAME((TY)-2.0); \
}
FP_EXP_CONST(float, expf)
FP_EXP_CONST(double, exp)
FP_EXP_CONST(quad, expl)
