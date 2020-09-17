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

#define FP_FABSF_VAR(TY) \
TY func_fp_fabsf_var_ ## TY(TY a) { \
  return fabsf(a); \
}
FP_FABSF_VAR(float)

#define FP_CABSF_VAR(TY) \
TY func_fp_cabsf_var_ ## TY(TY a) { \
  return cabsf(a); \
}
FP_CABSF_VAR(fcomp)

#define FP_FABS_VAR(TY) \
TY func_fp_fabs_var_ ## TY(TY a) { \
  return fabs(a); \
}
FP_FABS_VAR(double)

#define FP_CABS_VAR(TY) \
TY func_fp_cabs_var_ ## TY(TY a) { \
  return cabs(a); \
}
FP_CABS_VAR(dcomp)

#define FP_FABSL_VAR(TY) \
TY func_fp_fabsl_var_ ## TY(TY a) { \
  return fabsl(a); \
}
FP_FABSL_VAR(quad)

#define FP_CABSL_VAR(TY) \
TY func_fp_cabsl_var_ ## TY(TY a) { \
  return cabsl(a); \
}
FP_CABSL_VAR(qcomp)

#define FP_FABSF_ZERO(TY) \
TY func_fp_fabsf_zero_ ## TY() { \
  return  fabsf((TY)0.0) ; \
}
FP_FABSF_ZERO(float)

#define FP_CABSF_ZERO(TY) \
TY func_fp_cabsf_zero_ ## TY() { \
  return  cabsf((TY)0.0) ; \
}
FP_CABSF_ZERO(fcomp)

#define FP_FABS_ZERO(TY) \
TY func_fp_FABS_zero_ ## TY() { \
  return  fabs((TY)0.0) ; \
}
FP_FABS_ZERO(double)

#define FP_CABS_ZERO(TY) \
TY func_fp_CABS_zero_ ## TY() { \
  return  cabs((TY)0.0) ; \
}
FP_CABS_ZERO(dcomp)

#define FP_FABSL_ZERO(TY) \
TY func_fp_fabsl_zero_ ## TY() { \
  return  fabsl((TY)0.0) ; \
}
FP_FABSL_ZERO(quad)

#define FP_CABSL_ZERO(TY) \
TY func_fp_cabsl_zero_ ## TY() { \
  return  cabsl((TY)0.0) ; \
}
FP_CABSL_ZERO(qcomp)

#define FP_FABSF_CONST(TY) \
TY func_fp_fabsf_const_ ## TY() { \
  return fabsf((TY)-2.0); \
}
FP_FABSF_CONST(float)

#define FP_CABSF_CONST(TY) \
TY func_fp_cabsf_const_ ## TY() { \
  return cabsf((TY)-2.0); \
}
FP_CABSF_CONST(fcomp)

#define FP_FABS_CONST(TY) \
TY func_fp_fabs_const_ ## TY() { \
  return fabs((TY)-2.0); \
}
FP_FABS_CONST(double)

#define FP_CABS_CONST(TY) \
TY func_fp_cabs_const_ ## TY() { \
  return cabs((TY)-2.0); \
}
FP_CABS_CONST(dcomp)

#define FP_FABSL_CONST(TY) \
TY func_fp_fabsl_const_ ## TY() { \
  return fabsl((TY)-2.0); \
}
FP_FABSL_CONST(quad)

#define FP_CABSL_CONST(TY) \
TY func_fp_cabsl_const_ ## TY() { \
  return cabsl((TY)-2.0); \
}
FP_CABSL_CONST(qcomp)
