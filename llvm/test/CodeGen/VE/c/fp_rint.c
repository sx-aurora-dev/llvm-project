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

#define FP_RINTF_VAR(TY) \
TY func_fp_rintf_var_ ## TY(TY a) { \
  return rintf(a); \
}
FP_RINTF_VAR(float)

#define FP_RINT_VAR(TY) \
TY func_fp_rint_var_ ## TY(TY a) { \
  return rint(a); \
}
FP_RINT_VAR(double)

#define FP_RINTL_VAR(TY) \
TY func_fp_rintl_var_ ## TY(TY a) { \
  return rintl(a); \
}
FP_RINTL_VAR(quad)

#define FP_RINTF_ZERO(TY) \
TY func_fp_rintf_zero_ ## TY() { \
  return  rintf((TY)0.0) ; \
}
FP_RINTF_ZERO(float)

#define FP_RINT_ZERO(TY) \
TY func_fp_RINT_zero_ ## TY() { \
  return  rint((TY)0.0) ; \
}
FP_RINT_ZERO(double)

#define FP_RINTL_ZERO(TY) \
TY func_fp_rintl_zero_ ## TY() { \
  return  rintl((TY)0.0) ; \
}
FP_RINTL_ZERO(quad)

#define FP_RINTF_CONST(TY) \
TY func_fp_rintf_const_ ## TY() { \
  return rintf((TY)-2.0); \
}
FP_RINTF_CONST(float)

#define FP_RINT_CONST(TY) \
TY func_fp_rint_const_ ## TY() { \
  return rint((TY)-2.0); \
}
FP_RINT_CONST(double)

#define FP_RINTL_CONST(TY) \
TY func_fp_rintl_const_ ## TY() { \
  return rintl((TY)-2.0); \
}
FP_RINTL_CONST(quad)
