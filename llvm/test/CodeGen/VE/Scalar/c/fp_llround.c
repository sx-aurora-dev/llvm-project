#include "types.h"

#define FP_LLROUND_VAR(TY, NAME) \
i64 func_fp_llround_var_ ## TY(TY a) { \
  return __builtin_ ## NAME(a); \
}
FP_LLROUND_VAR(float, llroundf)
FP_LLROUND_VAR(double, llround)
FP_LLROUND_VAR(quad, llroundl)

#define FP_LLROUND_ZERO(TY, NAME) \
i64 func_fp_llround_zero_ ## TY() { \
  return __builtin_ ## NAME((TY)0.0); \
}
FP_LLROUND_ZERO(float, llroundf)
FP_LLROUND_ZERO(double, llround)
FP_LLROUND_ZERO(quad, llroundl)

#define FP_LLROUND_CONST(TY, NAME) \
i64 func_fp_llround_const_ ## TY() { \
  return __builtin_ ## NAME((TY)-2.0); \
}
FP_LLROUND_CONST(float, llroundf)
FP_LLROUND_CONST(double, llround)
FP_LLROUND_CONST(quad, llroundl)
