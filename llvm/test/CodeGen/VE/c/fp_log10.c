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

#define FP_LOG10F_VAR(TY) \
TY func_fp_log10f_var_ ## TY(TY a) { \
  return log10f(a); \
}
FP_LOG10F_VAR(float)

#define FP_LOG10_VAR(TY) \
TY func_fp_log10_var_ ## TY(TY a) { \
  return log10(a); \
}
FP_LOG10_VAR(double)

#define FP_LOG10L_VAR(TY) \
TY func_fp_log10l_var_ ## TY(TY a) { \
  return log10l(a); \
}
FP_LOG10L_VAR(quad)

#define FP_LOG10F_ZERO(TY) \
TY func_fp_log10f_zero_ ## TY() { \
  return  log10f((TY)0.0) ; \
}
FP_LOG10F_ZERO(float)

#define FP_LOG10_ZERO(TY) \
TY func_fp_LOG10_zero_ ## TY() { \
  return  log10((TY)0.0) ; \
}
FP_LOG10_ZERO(double)

#define FP_LOG10L_ZERO(TY) \
TY func_fp_log10l_zero_ ## TY() { \
  return  log10l((TY)0.0) ; \
}
FP_LOG10L_ZERO(quad)

#define FP_LOG10F_CONST(TY) \
TY func_fp_log10f_const_ ## TY() { \
  return log10f((TY)-2.0); \
}
FP_LOG10F_CONST(float)

#define FP_LOG10_CONST(TY) \
TY func_fp_log10_const_ ## TY() { \
  return log10((TY)-2.0); \
}
FP_LOG10_CONST(double)

#define FP_LOG10L_CONST(TY) \
TY func_fp_log10l_const_ ## TY() { \
  return log10l((TY)-2.0); \
}
FP_LOG10L_CONST(quad)
