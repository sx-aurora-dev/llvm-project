#include "types.h"

#define FP_EXP2_VAR(TY, NAME) \
TY func_fp_exp2_var_ ## TY(TY a) { \
  return __builtin_ ## NAME(a); \
}
FP_EXP2_VAR(float, exp2f)
FP_EXP2_VAR(double, exp2)
FP_EXP2_VAR(quad, exp2l)

#define FP_EXP2_ZERO(TY, NAME) \
TY func_fp_exp2_zero_ ## TY() { \
  return __builtin_ ## NAME((TY)0.0); \
}
FP_EXP2_ZERO(float, exp2f)
FP_EXP2_ZERO(double, exp2)
FP_EXP2_ZERO(quad, exp2l)

#define FP_EXP2_CONST(TY, NAME) \
TY func_fp_exp2_const_ ## TY() { \
  return __builtin_ ## NAME((TY)-2.0); \
}
FP_EXP2_CONST(float, exp2f)
FP_EXP2_CONST(double, exp2)
FP_EXP2_CONST(quad, exp2l)
