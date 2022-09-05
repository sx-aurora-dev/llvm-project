#include "types.h"

#define FP_LOG2_VAR(TY, NAME) \
TY func_fp_log2_var_ ## TY(TY a) { \
  return __builtin_ ## NAME(a); \
}
FP_LOG2_VAR(float, log2f)
FP_LOG2_VAR(double, log2)
FP_LOG2_VAR(quad, log2l)

#define FP_LOG2_ZERO(TY, NAME) \
TY func_fp_log2_zero_ ## TY() { \
  return __builtin_ ## NAME((TY)0.0); \
}
FP_LOG2_ZERO(float, log2f)
FP_LOG2_ZERO(double, log2)
FP_LOG2_ZERO(quad, log2l)

#define FP_LOG2_CONST(TY, NAME) \
TY func_fp_log2_const_ ## TY() { \
  return __builtin_ ## NAME((TY)-2.0); \
}
FP_LOG2_CONST(float, log2f)
FP_LOG2_CONST(double, log2)
FP_LOG2_CONST(quad, log2l)
