#include <math.h>
#include <complex.h>
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
typedef float complex fcomp;

#define FP_SINF_VAR(TY) \
TY func_fp_sinf_var_ ## TY(TY a) { \
  return sinf(a); \
}
FP_SINF_VAR(float)

#define FP_CSINF_VAR(TY) \
TY func_fp_csinf_var_ ## TY(TY a) { \
  return csinf(a); \
}
FP_CSINF_VAR(fcomp)

#define FP_SIN_VAR(TY) \
TY func_fp_sin_var_ ## TY(TY a) { \
  return sin(a); \
}
FP_SIN_VAR(double)

#define FP_CSIN_VAR(TY) \
TY func_fp_csin_var_ ## TY(TY a) { \
  return csin(a); \
}
FP_CSIN_VAR(dcomp)

#define FP_SINL_VAR(TY) \
TY func_fp_sinl_var_ ## TY(TY a) { \
  return sinl(a); \
}
FP_SINL_VAR(quad)

#define FP_CSINL_VAR(TY) \
TY func_fp_csinl_var_ ## TY(TY a) { \
  return csinl(a); \
}
FP_CSINL_VAR(qcomp)

#define FP_SINF_ZERO(TY) \
TY func_fp_sinf_zero_ ## TY() { \
  return sinf((TY)0.0) ; \
}
FP_SINF_ZERO(float)

#define FP_CSINF_ZERO(TY) \
TY func_fp_csinf_zero_ ## TY() { \
  return csinf((TY)0.0) ; \
}
FP_CSINF_ZERO(fcomp)

#define FP_SIN_ZERO(TY) \
TY func_fp_SIN_zero_ ## TY() { \
  return sin((TY)0.0) ; \
}
FP_SIN_ZERO(double)

#define FP_CSIN_ZERO(TY) \
TY func_fp_CSIN_zero_ ## TY() { \
  return csin((TY)0.0) ; \
}
FP_CSIN_ZERO(dcomp)

#define FP_SINL_ZERO(TY) \
TY func_fp_sinl_zero_ ## TY() { \
  return sinl((TY)0.0) ; \
}
FP_SINL_ZERO(quad)

#define FP_CSINL_ZERO(TY) \
TY func_fp_csinl_zero_ ## TY() { \
  return csinl((TY)0.0) ; \
}
FP_CSINL_ZERO(qcomp)

#define FP_SINF_CONST(TY) \
TY func_fp_sinf_const_ ## TY() { \
  return sinf((TY)-2.0); \
}
FP_SINF_CONST(float)

#define FP_CSINF_CONST(TY) \
TY func_fp_csinf_const_ ## TY() { \
  return csinf((TY)-2.0); \
}
FP_CSINF_CONST(fcomp)

#define FP_SIN_CONST(TY) \
TY func_fp_sin_const_ ## TY() { \
  return sin((TY)-2.0); \
}
FP_SIN_CONST(double)

#define FP_CSIN_CONST(TY) \
TY func_fp_csin_const_ ## TY() { \
  return csin((TY)-2.0); \
}
FP_CSIN_CONST(dcomp)

#define FP_SINL_CONST(TY) \
TY func_fp_sinl_const_ ## TY() { \
  return sinl((TY)-2.0); \
}
FP_SINL_CONST(quad)

#define FP_CSINL_CONST(TY) \
TY func_fp_csinl_const_ ## TY() { \
  return csinl((TY)-2.0); \
}
FP_CSINL_CONST(qcomp)
