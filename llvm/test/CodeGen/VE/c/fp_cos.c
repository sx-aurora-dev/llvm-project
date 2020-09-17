#include <complex.h>
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

#define FP_COSF_VAR(TY) \
TY func_fp_cosf_var_ ## TY(TY a) { \
  return cosf(a); \
}
FP_COSF_VAR(float)

#define FP_CCOSF_VAR(TY) \
TY func_fp_ccosf_var_ ## TY(TY a) { \
  return ccosf(a); \
}
FP_CCOSF_VAR(fcomp)

#define FP_COS_VAR(TY) \
TY func_fp_cos_var_ ## TY(TY a) { \
  return cos(a); \
}
FP_COS_VAR(double)

#define FP_CCOS_VAR(TY) \
TY func_fp_ccos_var_ ## TY(TY a) { \
  return ccos(a); \
}
FP_CCOS_VAR(dcomp)

#define FP_COSL_VAR(TY) \
TY func_fp_cosl_var_ ## TY(TY a) { \
  return cosl(a); \
}
FP_COSL_VAR(quad)

#define FP_CCOSL_VAR(TY) \
TY func_fp_Ccosl_var_ ## TY(TY a) { \
  return ccosl(a); \
}
FP_CCOSL_VAR(qcomp)

#define FP_COSF_ZERO(TY) \
TY func_fp_cosf_zero_ ## TY() { \
  return  cosf((TY)0.0) ; \
}
FP_COSF_ZERO(float)

#define FP_CCOSF_ZERO(TY) \
TY func_fp_ccosf_zero_ ## TY() { \
  return  ccosf((TY)0.0) ; \
}
FP_CCOSF_ZERO(fcomp)

#define FP_COS_ZERO(TY) \
TY func_fp_COS_zero_ ## TY() { \
  return  cos((TY)0.0) ; \
}
FP_COS_ZERO(double)

#define FP_CCOS_ZERO(TY) \
TY func_fp_CCOS_zero_ ## TY() { \
  return  ccos((TY)0.0) ; \
}
FP_CCOS_ZERO(dcomp)

#define FP_COSL_ZERO(TY) \
TY func_fp_cosl_zero_ ## TY() { \
  return  cosl((TY)0.0) ; \
}
FP_COSL_ZERO(quad)

#define FP_CCOSL_ZERO(TY) \
TY func_fp_ccosl_zero_ ## TY() { \
  return  ccosl((TY)0.0) ; \
}
FP_CCOSL_ZERO(qcomp)

#define FP_COSF_CONST(TY) \
TY func_fp_cosf_const_ ## TY() { \
  return cosf((TY)-2.0); \
}
FP_COSF_CONST(float)

#define FP_CCOSF_CONST(TY) \
TY func_fp_ccosf_const_ ## TY() { \
  return ccosf((TY)-2.0); \
}
FP_CCOSF_CONST(fcomp)

#define FP_COS_CONST(TY) \
TY func_fp_cos_const_ ## TY() { \
  return cos((TY)-2.0); \
}
FP_COS_CONST(double)

#define FP_CCOS_CONST(TY) \
TY func_fp_ccos_const_ ## TY() { \
  return ccos((TY)-2.0); \
}
FP_CCOS_CONST(dcomp)

#define FP_COSL_CONST(TY) \
TY func_fp_cosl_const_ ## TY() { \
  return cosl((TY)-2.0); \
}
FP_COSL_CONST(quad)

#define FP_CCOSL_CONST(TY) \
TY func_fp_ccosl_const_ ## TY() { \
  return ccosl((TY)-2.0); \
}
FP_CCOSL_CONST(qcomp)
