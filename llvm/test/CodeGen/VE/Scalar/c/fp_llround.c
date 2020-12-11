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

#define FP_LLROUNDF_VAR(TY) \
TY func_fp_llroundf_var_ ## TY(TY a) { \
  return llroundf(a); \
}
FP_LLROUNDF_VAR(float)

#define FP_LLROUND_VAR(TY) \
TY func_fp_llround_var_ ## TY(TY a) { \
  return llround(a); \
}
FP_LLROUND_VAR(double)

#define FP_LLROUNDL_VAR(TY) \
TY func_fp_llroundl_var_ ## TY(TY a) { \
  return llroundl(a); \
}
FP_LLROUNDL_VAR(quad)

#define FP_LLROUNDF_ZERO(TY) \
TY func_fp_llroundf_zero_ ## TY() { \
  return  llroundf((TY)0.0) ; \
}
FP_LLROUNDF_ZERO(float)

#define FP_LLROUND_ZERO(TY) \
TY func_fp_LLROUND_zero_ ## TY() { \
  return  llround((TY)0.0) ; \
}
FP_LLROUND_ZERO(double)

#define FP_LLROUNDL_ZERO(TY) \
TY func_fp_llroundl_zero_ ## TY() { \
  return  llroundl((TY)0.0) ; \
}
FP_LLROUNDL_ZERO(quad)

#define FP_LLROUNDF_CONST(TY) \
TY func_fp_llroundf_const_ ## TY() { \
  return llroundf((TY)-2.0); \
}
FP_LLROUNDF_CONST(float)

#define FP_LLROUND_CONST(TY) \
TY func_fp_llround_const_ ## TY() { \
  return llround((TY)-2.0); \
}
FP_LLROUND_CONST(double)

#define FP_LLROUNDL_CONST(TY) \
TY func_fp_llroundl_const_ ## TY() { \
  return llroundl((TY)-2.0); \
}
FP_LLROUNDL_CONST(quad)
