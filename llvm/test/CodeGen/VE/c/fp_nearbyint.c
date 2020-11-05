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

#define FP_NEARBYINTF_VAR(TY) \
TY func_fp_nearbyintf_var_ ## TY(TY a) { \
  return nearbyintf(a); \
}
FP_NEARBYINTF_VAR(float)

#define FP_NEARBYINT_VAR(TY) \
TY func_fp_nearbyint_var_ ## TY(TY a) { \
  return nearbyint(a); \
}
FP_NEARBYINT_VAR(double)

#define FP_NEARBYINTL_VAR(TY) \
TY func_fp_nearbyintl_var_ ## TY(TY a) { \
  return nearbyintl(a); \
}
FP_NEARBYINTL_VAR(quad)

#define FP_NEARBYINTF_ZERO(TY) \
TY func_fp_nearbyintf_zero_ ## TY() { \
  return  nearbyintf((TY)0.0) ; \
}
FP_NEARBYINTF_ZERO(float)

#define FP_NEARBYINT_ZERO(TY) \
TY func_fp_NEARBYINT_zero_ ## TY() { \
  return  nearbyint((TY)0.0) ; \
}
FP_NEARBYINT_ZERO(double)

#define FP_NEARBYINTL_ZERO(TY) \
TY func_fp_nearbyintl_zero_ ## TY() { \
  return  nearbyintl((TY)0.0) ; \
}
FP_NEARBYINTL_ZERO(quad)

#define FP_NEARBYINTF_CONST(TY) \
TY func_fp_nearbyintf_const_ ## TY() { \
  return nearbyintf((TY)-2.0); \
}
FP_NEARBYINTF_CONST(float)

#define FP_NEARBYINT_CONST(TY) \
TY func_fp_nearbyint_const_ ## TY() { \
  return nearbyint((TY)-2.0); \
}
FP_NEARBYINT_CONST(double)

#define FP_NEARBYINTL_CONST(TY) \
TY func_fp_nearbyintl_const_ ## TY() { \
  return nearbyintl((TY)-2.0); \
}
FP_NEARBYINTL_CONST(quad)
