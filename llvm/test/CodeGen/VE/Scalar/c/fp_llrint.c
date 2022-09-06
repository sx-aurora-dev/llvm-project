#include "types.h"

#define FP_LLRINT_VAR(TY, NAME) \
i64 func_fp_llrint_var_ ## TY(TY a) { \
  return __builtin_ ## NAME(a); \
}
FP_LLRINT_VAR(float, llrintf)
FP_LLRINT_VAR(double, llrint)
FP_LLRINT_VAR(quad, llrintl)

#define FP_LLRINT_ZERO(TY, NAME) \
i64 func_fp_llrint_zero_ ## TY() { \
  return __builtin_ ## NAME((TY)0.0); \
}
FP_LLRINT_ZERO(float, llrintf)
FP_LLRINT_ZERO(double, llrint)
FP_LLRINT_ZERO(quad, llrintl)

#define FP_LLRINT_CONST(TY, NAME) \
i64 func_fp_llrint_const_ ## TY() { \
  return __builtin_ ## NAME((TY)-2.0); \
}
FP_LLRINT_CONST(float, llrintf)
FP_LLRINT_CONST(double, llrint)
FP_LLRINT_CONST(quad, llrintl)
