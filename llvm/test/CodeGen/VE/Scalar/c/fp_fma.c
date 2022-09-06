#include "types.h"

#define FP_FMA_VAR(TY, NAME) \
TY func_fp_fma_var_ ## TY(TY a, TY b, TY c) { \
  return __builtin_ ## NAME(a ,b, c); \
}
FP_FMA_VAR(float, fmaf)
FP_FMA_VAR(double, fma)
FP_FMA_VAR(quad, fmal)

#define FP_FMA_ZERO_FORE(TY, NAME) \
TY func_fp_fma_zero_fore_ ## TY(TY a, TY b) { \
  return __builtin_ ## NAME( a, (TY)0.0, b); \
}
FP_FMA_ZERO_FORE(float, fmaf)
FP_FMA_ZERO_FORE(double, fma)
FP_FMA_ZERO_FORE(quad, fmal)

#define FP_FMA_ZERO_BACK(TY, NAME) \
TY func_fp_fma_zero_back_ ## TY(TY a, TY b) { \
  return __builtin_ ## NAME( a, b, (TY)0.0); \
}
FP_FMA_ZERO_BACK(float, fmaf)
FP_FMA_ZERO_BACK(double, fma)
FP_FMA_ZERO_BACK(quad, fmal)

#define FP_FMA_CONST_FORE(TY, NAME) \
TY func_fp_fma_const_fore_ ## TY(TY a, TY b) { \
  return __builtin_ ## NAME(a , (TY)-2.0, b); \
}
FP_FMA_CONST_FORE(float, fmaf)
FP_FMA_CONST_FORE(double, fma)
FP_FMA_CONST_FORE(quad, fmal)

#define FP_FMA_CONST_BACK(TY, NAME) \
TY func_fp_fma_const_back_ ## TY(TY a, TY b) { \
  return __builtin_ ## NAME(a , b, (TY)-2.0); \
}
FP_FMA_CONST_BACK(float, fmaf)
FP_FMA_CONST_BACK(double, fma)
FP_FMA_CONST_BACK(quad, fmal)
