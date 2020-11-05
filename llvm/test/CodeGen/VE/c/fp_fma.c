#include <math.h>
typedef _Bool int1_t;
typedef char int8_t;
typedef unsigned char uint8_t;
typedef short int16_t;
typedef unsigned short uint16_t;
typedef int int32_t;
typedef unsigned int uint32_t;
typedef long int64_t;
typedef unsigned long uint64_t;
typedef __int128 int128_t;
typedef unsigned __int128 uint128_t;
typedef long double quad;
typedef _Complex float fcomp;
typedef _Complex double dcomp;
typedef _Complex long double qcomp;

#define FP_FMAF_VAR(TY) \
TY func_fp_fmaf_var_ ## TY(TY a, TY b, TY c) { \
  return fmaf(a ,b, c); \
}
FP_FMAF_VAR(float)

#define FP_FMA_VAR(TY) \
TY func_fp_fma_var_ ## TY(TY a, TY b, TY c) { \
  return fma(a ,b, c); \
}
FP_FMA_VAR(double)

#define FP_FMAL_VAR(TY) \
TY func_fp_fmal_var_ ## TY(TY a, TY b, TY c) { \
  return fmal(a ,b, c); \
}
FP_FMAL_VAR(quad)

#define FP_FMAF_ZERO_FORE(TY) \
TY func_fp_fmaf_zero_fore_ ## TY(TY a, TY b) { \
  return  fmaf( a, (TY)0.0, b) ; \
}
FP_FMAF_ZERO_FORE(float)

#define FP_FMA_ZERO_FORE(TY) \
TY func_fp_fma_zero_fore_ ## TY(TY a, TY b) { \
  return  fma( a, (TY)0.0, b) ; \
}
FP_FMA_ZERO_FORE(double)

#define FP_FMAL_ZERO_FORE(TY) \
TY func_fp_fmal_zero_fore_ ## TY(TY a, TY b) { \
  return  fmal( a, (TY)0.0, b) ; \
}
FP_FMAL_ZERO_FORE(quad)

#define FP_FMAF_ZERO_BACK(TY) \
TY func_fp_fmaf_zero_back_ ## TY(TY a, TY b) { \
  return  fmaf( a, b, (TY)0.0) ; \
}
FP_FMAF_ZERO_BACK(float)

#define FP_FMA_ZERO_BACK(TY) \
TY func_fp_fma_zero_back_ ## TY(TY a, TY b) { \
  return  fma( a, b, (TY)0.0) ; \
}
FP_FMA_ZERO_BACK(double)

#define FP_FMAL_ZERO_BACK(TY) \
TY func_fp_fmal_zero_back_ ## TY(TY a, TY b) { \
  return  fmal( a, b, (TY)0.0) ; \
}
FP_FMAL_ZERO_BACK(quad)

#define FP_FMAF_CONST_FORE(TY) \
TY func_fp_fmaf_const_fore_ ## TY(TY a, TY b) { \
  return fmaf(a , (TY)-2.0, b); \
}
FP_FMAF_CONST_FORE(float)

#define FP_FMA_CONST_FORE(TY) \
TY func_fp_fma_const_fore_ ## TY(TY a, TY b) { \
  return fma(a , (TY)-2.0, b); \
}
FP_FMA_CONST_FORE(double)

#define FP_FMAL_CONST_FORE(TY) \
TY func_fp_fmal_const_fore_ ## TY(TY a, TY b) { \
  return fmal(a , (TY)-2.0, b); \
}
FP_FMAL_CONST_FORE(quad)

#define FP_FMAF_CONST_BACK(TY) \
TY func_fp_fmaf_const_back_ ## TY(TY a, TY b) { \
  return fmaf(a , b, (TY)-2.0); \
}
FP_FMAF_CONST_BACK(float)

#define FP_FMA_CONST_BACK(TY) \
TY func_fp_fma_const_back_ ## TY(TY a, TY b) { \
  return fma(a , b, (TY)-2.0); \
}
FP_FMA_CONST_BACK(double)

#define FP_FMAL_CONST_BACK(TY) \
TY func_fp_fmal_const_BACK_ ## TY(TY a, TY b) { \
  return fmal(a , b, (TY)-2.0); \
}
FP_FMAL_CONST_BACK(quad)
