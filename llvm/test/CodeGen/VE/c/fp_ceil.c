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

#define FP_CEILF_VAR(TY) \
TY func_fp_ceilf_var_ ## TY(TY a) { \
  return ceilf(a); \
}
FP_CEILF_VAR(float)

#define FP_CEIL_VAR(TY) \
TY func_fp_ceil_var_ ## TY(TY a) { \
  return ceil(a); \
}
FP_CEIL_VAR(double)

#define FP_CEILL_VAR(TY) \
TY func_fp_ceill_var_ ## TY(TY a) { \
  return ceill(a); \
}
FP_CEILL_VAR(quad)


#define FP_CEILF_ZERO(TY) \
TY func_fp_ceilf_zero_ ## TY() { \
  return  ceilf((TY)0.0) ; \
}
FP_CEILF_ZERO(float)

#define FP_CEIL_ZERO(TY) \
TY func_fp_CEIL_zero_ ## TY() { \
  return  ceil((TY)0.0) ; \
}
FP_CEIL_ZERO(double)

#define FP_CEILL_ZERO(TY) \
TY func_fp_ceill_zero_ ## TY() { \
  return  ceill((TY)0.0) ; \
}
FP_CEILL_ZERO(quad)

#define FP_CEILF_CONST(TY) \
TY func_fp_ceilf_const_ ## TY() { \
  return ceilf((TY)-2.0); \
}
FP_CEILF_CONST(float)

#define FP_CEIL_CONST(TY) \
TY func_fp_ceil_const_ ## TY() { \
  return ceil((TY)-2.0); \
}
FP_CEIL_CONST(double)

#define FP_CEILL_CONST(TY) \
TY func_fp_ceill_const_ ## TY() { \
  return ceill((TY)-2.0); \
}
FP_CEILL_CONST(quad)
