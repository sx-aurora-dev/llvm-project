#include "types.h"

#define FP_LOG_VAR(TY, NAME) \
TY func_fp_log_var_ ## TY(TY a) { \
  return __builtin_ ## NAME(a); \
}
FP_LOG_VAR(float, logf)
FP_LOG_VAR(double, log)
FP_LOG_VAR(quad, logl)

#define FP_LOG_ZERO(TY, NAME) \
TY func_fp_log_zero_ ## TY() { \
  return __builtin_ ## NAME((TY)0.0); \
}
FP_LOG_ZERO(float, logf)
FP_LOG_ZERO(double, log)
FP_LOG_ZERO(quad, logl)

#define FP_LOG_CONST(TY, NAME) \
TY func_fp_log_const_ ## TY() { \
  return __builtin_ ## NAME((TY)-2.0); \
}
FP_LOG_CONST(float, logf)
FP_LOG_CONST(double, log)
FP_LOG_CONST(quad, logl)
