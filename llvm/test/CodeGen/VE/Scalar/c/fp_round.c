#include "types.h"

#define FP_ROUND_VAR(TY, NAME) \
TY func_fp_round_var_ ## TY(TY a) { \
  return __builtin_ ## NAME(a); \
}
FP_ROUND_VAR(float, roundf)
FP_ROUND_VAR(double, round)
FP_ROUND_VAR(quad, roundl)

#define FP_ROUND_ZERO(TY, NAME) \
TY func_fp_round_zero_ ## TY() { \
  return __builtin_ ## NAME((TY)0.0); \
}
FP_ROUND_ZERO(float, roundf)
FP_ROUND_ZERO(double, round)
FP_ROUND_ZERO(quad, roundl)

#define FP_ROUND_CONST(TY, NAME) \
TY func_fp_round_const_ ## TY() { \
  return __builtin_ ## NAME((TY)-2.0); \
}
FP_ROUND_CONST(float, roundf)
FP_ROUND_CONST(double, round)
FP_ROUND_CONST(quad, roundl)
