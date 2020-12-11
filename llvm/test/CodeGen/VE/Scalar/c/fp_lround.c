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

#define FP_LROUNDF_VAR(TY) \
TY func_fp_lroundf_var_ ## TY(TY a) { \
  return lroundf(a); \
}
FP_LROUNDF_VAR(float)

#define FP_LROUND_VAR(TY) \
TY func_fp_lround_var_ ## TY(TY a) { \
  return lround(a); \
}
FP_LROUND_VAR(double)

#define FP_LROUNDL_VAR(TY) \
TY func_fp_lroundl_var_ ## TY(TY a) { \
  return lroundl(a); \
}
FP_LROUNDL_VAR(quad)


#define FP_LROUNDF_ZERO(TY) \
TY func_fp_lroundf_zero_ ## TY() { \
  return  lroundf((TY)0.0) ; \
}
FP_LROUNDF_ZERO(float)

#define FP_LROUND_ZERO(TY) \
TY func_fp_LROUND_zero_ ## TY() { \
  return  lround((TY)0.0) ; \
}
FP_LROUND_ZERO(double)

#define FP_LROUNDL_ZERO(TY) \
TY func_fp_lroundl_zero_ ## TY() { \
  return  lroundl((TY)0.0) ; \
}
FP_LROUNDL_ZERO(quad)

#define FP_LROUNDF_CONST(TY) \
TY func_fp_lroundf_const_ ## TY() { \
  return lroundf((TY)-2.0); \
}
FP_LROUNDF_CONST(float)

#define FP_LROUND_CONST(TY) \
TY func_fp_lround_const_ ## TY() { \
  return lround((TY)-2.0); \
}
FP_LROUND_CONST(double)

#define FP_LROUNDL_CONST(TY) \
TY func_fp_lroundl_const_ ## TY() { \
  return lroundl((TY)-2.0); \
}
FP_LROUNDL_CONST(quad)
