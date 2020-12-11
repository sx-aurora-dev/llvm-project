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

#define FP_ROUNDF_VAR(TY) \
TY func_fp_roundf_var_ ## TY(TY a) { \
  return roundf(a); \
}
FP_ROUNDF_VAR(float)

#define FP_ROUND_VAR(TY) \
TY func_fp_round_var_ ## TY(TY a) { \
  return round(a); \
}
FP_ROUND_VAR(double)

#define FP_ROUNDL_VAR(TY) \
TY func_fp_roundl_var_ ## TY(TY a) { \
  return roundl(a); \
}
FP_ROUNDL_VAR(quad)

#define FP_ROUNDF_ZERO(TY) \
TY func_fp_roundf_zero_ ## TY() { \
  return  roundf((TY)0.0) ; \
}
FP_ROUNDF_ZERO(float)

#define FP_ROUND_ZERO(TY) \
TY func_fp_ROUND_zero_ ## TY() { \
  return  round((TY)0.0) ; \
}
FP_ROUND_ZERO(double)

#define FP_ROUNDL_ZERO(TY) \
TY func_fp_roundl_zero_ ## TY() { \
  return  roundl((TY)0.0) ; \
}
FP_ROUNDL_ZERO(quad)

#define FP_ROUNDF_CONST(TY) \
TY func_fp_roundf_const_ ## TY() { \
  return roundf((TY)-2.0); \
}
FP_ROUNDF_CONST(float)

#define FP_ROUND_CONST(TY) \
TY func_fp_round_const_ ## TY() { \
  return round((TY)-2.0); \
}
FP_ROUND_CONST(double)

#define FP_ROUNDL_CONST(TY) \
TY func_fp_roundl_const_ ## TY() { \
  return roundl((TY)-2.0); \
}
FP_ROUNDL_CONST(quad)
