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

#define FP_FMAXF_VAR(TY) \
TY func_fp_fmaxf_var_ ## TY(TY a, TY b) { \
  return fmaxf(a ,b); \
}
FP_FMAXF_VAR(float)

#define FP_FMAX_VAR(TY) \
TY func_fp_fmax_var_ ## TY(TY a, TY b) { \
  return fmax(a ,b); \
}
FP_FMAX_VAR(double)

#define FP_FMAXL_VAR(TY) \
TY func_fp_fmaxl_var_ ## TY(TY a, TY b) { \
  return fmaxl(a ,b); \
}
FP_FMAXL_VAR(quad)

#define FP_FMAXF_ZERO(TY) \
TY func_fp_fmaxf_zero_ ## TY(TY a) { \
  return  fmaxf( a, (TY)0.0) ; \
}
FP_FMAXF_ZERO(float)

#define FP_FMAX_ZERO(TY) \
TY func_fp_fmax_zero_ ## TY(TY a) { \
  return  fmax( a, (TY)0.0) ; \
}
FP_FMAX_ZERO(double)

#define FP_FMAXL_ZERO(TY) \
TY func_fp_fmaxl_zero_ ## TY(TY a) { \
  return  fmaxl( a, (TY)0.0) ; \
}
FP_FMAXL_ZERO(quad)

#define FP_FMAXF_CONST(TY) \
TY func_fp_fmaxf_const_ ## TY(TY a) { \
  return fmaxf(a , (TY)-2.0); \
}
FP_FMAXF_CONST(float)

#define FP_FMAX_CONST(TY) \
TY func_fp_fmax_const_ ## TY(TY a) { \
  return fmax(a , (TY)-2.0); \
}
FP_FMAX_CONST(double)

#define FP_FMAXL_CONST(TY) \
TY func_fp_fmaxl_const_ ## TY(TY a) { \
  return fmaxl(a , (TY)-2.0); \
}
FP_FMAXL_CONST(quad)
