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

#define FP_FMINF_VAR(TY) \
TY func_fp_fminf_var_ ## TY(TY a, TY b) { \
  return fminf(a ,b); \
}
FP_FMINF_VAR(float)
FP_FMINF_VAR(fcomp)

#define FP_FMIN_VAR(TY) \
TY func_fp_fmin_var_ ## TY(TY a, TY b) { \
  return fmin(a ,b); \
}
FP_FMIN_VAR(double)
FP_FMIN_VAR(dcomp)

#define FP_FMINL_VAR(TY) \
TY func_fp_fminl_var_ ## TY(TY a, TY b) { \
  return fminl(a ,b); \
}
FP_FMINL_VAR(quad)
FP_FMINL_VAR(qcomp)


#define FP_FMINF_ZERO(TY) \
TY func_fp_fminf_zero_ ## TY(TY a) { \
  return  fminf( a, (TY)0.0) ; \
}
FP_FMINF_ZERO(float)
FP_FMINF_ZERO(fcomp)

#define FP_FMIN_ZERO(TY) \
TY func_fp_fmin_zero_ ## TY(TY a) { \
  return  fmin( a, (TY)0.0) ; \
}
FP_FMIN_ZERO(double)
FP_FMIN_ZERO(dcomp)

#define FP_FMINL_ZERO(TY) \
TY func_fp_fminl_zero_ ## TY(TY a) { \
  return  fminl( a, (TY)0.0) ; \
}
FP_FMINL_ZERO(quad)
FP_FMINL_ZERO(qcomp)

#define FP_FMINF_CONST(TY) \
TY func_fp_fminf_const_ ## TY(TY a) { \
  return fminf(a , (TY)-2.0); \
}
FP_FMINF_CONST(float)
FP_FMINF_CONST(fcomp)

#define FP_FMIN_CONST(TY) \
TY func_fp_fmin_const_ ## TY(TY a) { \
  return fmin(a , (TY)-2.0); \
}
FP_FMIN_CONST(double)
FP_FMIN_CONST(dcomp)

#define FP_FMINL_CONST(TY) \
TY func_fp_fminl_const_ ## TY(TY a) { \
  return fminl(a , (TY)-2.0); \
}
FP_FMINL_CONST(quad)
FP_FMINL_CONST(qcomp)
