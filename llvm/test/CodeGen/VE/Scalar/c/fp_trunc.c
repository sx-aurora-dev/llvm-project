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

#define FP_TRUNCF_VAR(TY) \
TY func_fp_truncf_var_ ## TY(TY a) { \
  return truncf(a); \
}
FP_TRUNCF_VAR(float)

#define FP_TRUNC_VAR(TY) \
TY func_fp_trunc_var_ ## TY(TY a) { \
  return trunc(a); \
}
FP_TRUNC_VAR(double)

#define FP_TRUNCL_VAR(TY) \
TY func_fp_truncl_var_ ## TY(TY a) { \
  return truncl(a); \
}
FP_TRUNCL_VAR(quad)

#define FP_TRUNCF_ZERO(TY) \
TY func_fp_truncf_zero_ ## TY() { \
  return  truncf((TY)0.0) ; \
}
FP_TRUNCF_ZERO(float)

#define FP_TRUNC_ZERO(TY) \
TY func_fp_TRUNC_zero_ ## TY() { \
  return  trunc((TY)0.0) ; \
}
FP_TRUNC_ZERO(double)

#define FP_TRUNCL_ZERO(TY) \
TY func_fp_truncl_zero_ ## TY() { \
  return  truncl((TY)0.0) ; \
}
FP_TRUNCL_ZERO(quad)

#define FP_TRUNCF_CONST(TY) \
TY func_fp_truncf_const_ ## TY() { \
  return truncf((TY)-2.0); \
}
FP_TRUNCF_CONST(float)

#define FP_TRUNC_CONST(TY) \
TY func_fp_trunc_const_ ## TY() { \
  return trunc((TY)-2.0); \
}
FP_TRUNC_CONST(double)

#define FP_TRUNCL_CONST(TY) \
TY func_fp_truncl_const_ ## TY() { \
  return truncl((TY)-2.0); \
}
FP_TRUNCL_CONST(quad)
