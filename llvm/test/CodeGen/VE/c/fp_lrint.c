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

#define FP_LRINTF_VAR(TY) \
TY func_fp_lrintf_var_ ## TY(TY a) { \
  return lrintf(a); \
}
FP_LRINTF_VAR(float)

#define FP_LRINT_VAR(TY) \
TY func_fp_lrint_var_ ## TY(TY a) { \
  return lrint(a); \
}
FP_LRINT_VAR(double)

#define FP_LRINTL_VAR(TY) \
TY func_fp_lrintl_var_ ## TY(TY a) { \
  return lrintl(a); \
}
FP_LRINTL_VAR(quad)

#define FP_LRINTF_ZERO(TY) \
TY func_fp_lrintf_zero_ ## TY() { \
  return  lrintf((TY)0.0) ; \
}
FP_LRINTF_ZERO(float)

#define FP_LRINT_ZERO(TY) \
TY func_fp_LRINT_zero_ ## TY() { \
  return  lrint((TY)0.0) ; \
}
FP_LRINT_ZERO(double)

#define FP_LRINTL_ZERO(TY) \
TY func_fp_lrintl_zero_ ## TY() { \
  return  lrintl((TY)0.0) ; \
}
FP_LRINTL_ZERO(quad)

#define FP_LRINTF_CONST(TY) \
TY func_fp_lrintf_const_ ## TY() { \
  return lrintf((TY)-2.0); \
}
FP_LRINTF_CONST(float)

#define FP_LRINT_CONST(TY) \
TY func_fp_lrint_const_ ## TY() { \
  return lrint((TY)-2.0); \
}
FP_LRINT_CONST(double)

#define FP_LRINTL_CONST(TY) \
TY func_fp_lrintl_const_ ## TY() { \
  return lrintl((TY)-2.0); \
}
FP_LRINTL_CONST(quad)
