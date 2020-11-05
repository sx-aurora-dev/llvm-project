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

#define FP_FLOORF_VAR(TY) \
TY func_fp_floorf_var_ ## TY(TY a) { \
  return floorf(a); \
}
FP_FLOORF_VAR(float)

#define FP_FLOOR_VAR(TY) \
TY func_fp_floor_var_ ## TY(TY a) { \
  return floor(a); \
}
FP_FLOOR_VAR(double)

#define FP_FLOORL_VAR(TY) \
TY func_fp_floorl_var_ ## TY(TY a) { \
  return floorl(a); \
}
FP_FLOORL_VAR(quad)

#define FP_FLOORF_ZERO(TY) \
TY func_fp_floorf_zero_ ## TY() { \
  return  floorf((TY)0.0) ; \
}
FP_FLOORF_ZERO(float)

#define FP_FLOOR_ZERO(TY) \
TY func_fp_FLOOR_zero_ ## TY() { \
  return  floor((TY)0.0) ; \
}
FP_FLOOR_ZERO(double)

#define FP_FLOORL_ZERO(TY) \
TY func_fp_floorl_zero_ ## TY() { \
  return  floorl((TY)0.0) ; \
}
FP_FLOORL_ZERO(quad)

#define FP_FLOORF_CONST(TY) \
TY func_fp_floorf_const_ ## TY() { \
  return floorf((TY)-2.0); \
}
FP_FLOORF_CONST(float)

#define FP_FLOOR_CONST(TY) \
TY func_fp_floor_const_ ## TY() { \
  return floor((TY)-2.0); \
}
FP_FLOOR_CONST(double)

#define FP_FLOORL_CONST(TY) \
TY func_fp_floorl_const_ ## TY() { \
  return floorl((TY)-2.0); \
}
FP_FLOORL_CONST(quad)
