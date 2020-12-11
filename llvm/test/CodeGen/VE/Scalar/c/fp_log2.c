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

#define FP_LOG2F_VAR(TY) \
TY func_fp_log2f_var_ ## TY(TY a) { \
  return log2f(a); \
}
FP_LOG2F_VAR(float)

#define FP_LOG2_VAR(TY) \
TY func_fp_log2_var_ ## TY(TY a) { \
  return log2(a); \
}
FP_LOG2_VAR(double)

#define FP_LOG2L_VAR(TY) \
TY func_fp_log2l_var_ ## TY(TY a) { \
  return log2l(a); \
}
FP_LOG2L_VAR(quad)

#define FP_LOG2F_ZERO(TY) \
TY func_fp_log2f_zero_ ## TY() { \
  return  log2f((TY)0.0) ; \
}
FP_LOG2F_ZERO(float)

#define FP_LOG2_ZERO(TY) \
TY func_fp_LOG2_zero_ ## TY() { \
  return  log2((TY)0.0) ; \
}
FP_LOG2_ZERO(double)

#define FP_LOG2L_ZERO(TY) \
TY func_fp_log2l_zero_ ## TY() { \
  return  log2l((TY)0.0) ; \
}
FP_LOG2L_ZERO(quad)

#define FP_LOG2F_CONST(TY) \
TY func_fp_log2f_const_ ## TY() { \
  return log2f((TY)-2.0); \
}
FP_LOG2F_CONST(float)

#define FP_LOG2_CONST(TY) \
TY func_fp_log2_const_ ## TY() { \
  return log2((TY)-2.0); \
}
FP_LOG2_CONST(double)

#define FP_LOG2L_CONST(TY) \
TY func_fp_log2l_const_ ## TY() { \
  return log2l((TY)-2.0); \
}
FP_LOG2L_CONST(quad)
