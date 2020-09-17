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

#define FP_COPYSIGNF_VAR(TY) \
TY func_fp_copysignf_var_ ## TY(TY a, TY b) { \
  return copysignf(a ,b); \
}
FP_COPYSIGNF_VAR(float)

#define FP_COPYSIGN_VAR(TY) \
TY func_fp_copysign_var_ ## TY(TY a, TY b) { \
  return copysign(a ,b); \
}
FP_COPYSIGN_VAR(double)

#define FP_COPYSIGNL_VAR(TY) \
TY func_fp_copysignl_var_ ## TY(TY a, TY b) { \
  return copysignl(a ,b); \
}
FP_COPYSIGNL_VAR(quad)

#define FP_COPYSIGNF_ZERO(TY) \
TY func_fp_copysignf_zero_ ## TY(TY a) { \
  return  copysignf((TY)0.0, a) ; \
}
FP_COPYSIGNF_ZERO(float)

#define FP_COPYSIGN_ZERO(TY) \
TY func_fp_copysign_zero_ ## TY(TY a) { \
  return  copysign((TY)0.0, a) ; \
}
FP_COPYSIGN_ZERO(double)

#define FP_COPYSIGNL_ZERO(TY) \
TY func_fp_copysignl_zero_ ## TY(TY a) { \
  return  copysignl( (TY)0.0, a) ; \
}
FP_COPYSIGNL_ZERO(quad)

#define FP_COPYSIGNF_CONST(TY) \
TY func_fp_copysignf_const_ ## TY(TY a) { \
  return copysignf((TY)-2.0, a); \
}
FP_COPYSIGNF_CONST(float)

#define FP_COPYSIGN_CONST(TY) \
TY func_fp_copysign_const_ ## TY(TY a) { \
  return copysign((TY)-2.0, a); \
}
FP_COPYSIGN_CONST(double)

#define FP_COPYSIGNL_CONST(TY) \
TY func_fp_copysignl_const_ ## TY(TY a) { \
  return copysignl((TY)-2.0, a); \
}
FP_COPYSIGNL_CONST(quad)
