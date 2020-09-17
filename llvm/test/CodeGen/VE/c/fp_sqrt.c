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

#define FP_SQRTF_VAR(TY) \
TY func_fp_sqrtf_var_ ## TY(TY a) { \
  return sqrtf(a); \
}
FP_SQRTF_VAR(float)

#define FP_SQRT_VAR(TY) \
TY func_fp_sqrt_var_ ## TY(TY a) { \
  return sqrt(a); \
}
FP_SQRT_VAR(double)

#define FP_SQRTL_VAR(TY) \
TY func_fp_sqrtl_var_ ## TY(TY a) { \
  return sqrtl(a); \
}
FP_SQRTL_VAR(quad)


#define FP_SQRTF_ZERO(TY) \
TY func_fp_sqrtf_zero_ ## TY() { \
  return  sqrtf((TY)0.0) ; \
}
FP_SQRTF_ZERO(float)

#define FP_SQRT_ZERO(TY) \
TY func_fp_SQRT_zero_ ## TY() { \
  return  sqrt((TY)0.0) ; \
}
FP_SQRT_ZERO(double)

#define FP_SQRTL_ZERO(TY) \
TY func_fp_sqrtl_zero_ ## TY() { \
  return  sqrtl((TY)0.0) ; \
}
FP_SQRTL_ZERO(quad)

#define FP_SQRTF_CONST(TY) \
TY func_fp_sqrtf_const_ ## TY() { \
  return sqrtf((TY)-2.0); \
}
FP_SQRTF_CONST(float)

#define FP_SQRT_CONST(TY) \
TY func_fp_sqrt_const_ ## TY() { \
  return sqrt((TY)-2.0); \
}
FP_SQRT_CONST(double)

#define FP_SQRTL_CONST(TY) \
TY func_fp_sqrtl_const_ ## TY() { \
  return sqrtl((TY)-2.0); \
}
FP_SQRTL_CONST(quad)
