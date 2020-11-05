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

#define FP_EXPF_VAR(TY) \
TY func_fp_expf_var_ ## TY(TY a) { \
  return expf(a); \
}
FP_EXPF_VAR(float)

#define FP_CEXPF_VAR(TY) \
TY func_fp_cexpf_var_ ## TY(TY a) { \
  return cexpf(a); \
}
FP_CEXPF_VAR(fcomp)

#define FP_EXP_VAR(TY) \
TY func_fp_exp_var_ ## TY(TY a) { \
  return exp(a); \
}
FP_EXP_VAR(double)

#define FP_CEXP_VAR(TY) \
TY func_fp_cexp_var_ ## TY(TY a) { \
  return cexp(a); \
}
FP_CEXP_VAR(dcomp)

#define FP_EXPL_VAR(TY) \
TY func_fp_expl_var_ ## TY(TY a) { \
  return expl(a); \
}
FP_EXPL_VAR(quad)

#define FP_CEXPL_VAR(TY) \
TY func_fp_cexpl_var_ ## TY(TY a) { \
  return cexpl(a); \
}
FP_CEXPL_VAR(qcomp)

#define FP_EXPF_ZERO(TY) \
TY func_fp_expf_zero_ ## TY() { \
  return  expf((TY)0.0) ; \
}
FP_EXPF_ZERO(float)

#define FP_CEXPF_ZERO(TY) \
TY func_fp_cexpf_zero_ ## TY() { \
  return  cexpf((TY)0.0) ; \
}
FP_CEXPF_ZERO(fcomp)

#define FP_EXP_ZERO(TY) \
TY func_fp_EXP_zero_ ## TY() { \
  return  exp((TY)0.0) ; \
}
FP_EXP_ZERO(double)

#define FP_CEXP_ZERO(TY) \
TY func_fp_cexp_zero_ ## TY() { \
  return  cexp((TY)0.0) ; \
}
FP_CEXP_ZERO(dcomp)

#define FP_EXPL_ZERO(TY) \
TY func_fp_expl_zero_ ## TY() { \
  return  expl((TY)0.0) ; \
}
FP_EXPL_ZERO(quad)

#define FP_CEXPL_ZERO(TY) \
TY func_fp_cexpl_zero_ ## TY() { \
  return  cexpl((TY)0.0) ; \
}
FP_CEXPL_ZERO(qcomp)

#define FP_EXPF_CONST(TY) \
TY func_fp_expf_const_ ## TY() { \
  return expf((TY)-2.0); \
}
FP_EXPF_CONST(float)

#define FP_CEXPF_CONST(TY) \
TY func_fp_cexpf_const_ ## TY() { \
  return cexpf((TY)-2.0); \
}
FP_CEXPF_CONST(fcomp)

#define FP_EXP_CONST(TY) \
TY func_fp_exp_const_ ## TY() { \
  return exp((TY)-2.0); \
}
FP_EXP_CONST(double)

#define FP_CEXP_CONST(TY) \
TY func_fp_cexp_const_ ## TY() { \
  return cexp((TY)-2.0); \
}
FP_CEXP_CONST(dcomp)

#define FP_EXPL_CONST(TY) \
TY func_fp_expl_const_ ## TY() { \
  return expl((TY)-2.0); \
}
FP_EXPL_CONST(quad)

#define FP_CEXPL_CONST(TY) \
TY func_fp_cexpl_const_ ## TY() { \
  return cexpl((TY)-2.0); \
}
FP_CEXPL_CONST(qcomp)
