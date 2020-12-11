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

#define FP_POWF_VAR(TY) \
TY func_fp_powf_var_ ## TY(TY a, TY b) { \
  return powf(a ,b); \
}
FP_POWF_VAR(float)

#define FP_CPOWF_VAR(TY) \
TY func_fp_cpowf_var_ ## TY(TY a, TY b) { \
  return cpowf(a ,b); \
}
FP_CPOWF_VAR(fcomp)

#define FP_POW_VAR(TY) \
TY func_fp_pow_var_ ## TY(TY a, TY b) { \
  return pow(a ,b); \
}
FP_POW_VAR(double)

#define FP_CPOW_VAR(TY) \
TY func_fp_cpow_var_ ## TY(TY a, TY b) { \
  return cpow(a ,b); \
}
FP_CPOW_VAR(dcomp)

#define FP_POWL_VAR(TY) \
TY func_fp_powl_var_ ## TY(TY a, TY b) { \
  return powl(a ,b); \
}
FP_POWL_VAR(quad)

#define FP_CPOWL_VAR(TY) \
TY func_fp_cpowl_var_ ## TY(TY a, TY b) { \
  return cpowl(a ,b); \
}
FP_CPOWL_VAR(qcomp)

#define FP_POWF_ZERO_BACK(TY) \
TY func_fp_powf_zero_back_ ## TY(TY a) { \
  return  powf( a, (TY)0.0) ; \
}
FP_POWF_ZERO_BACK(float)

#define FP_CPOWF_ZERO_BACK(TY) \
TY func_fp_cpowf_zero_back_ ## TY(TY a) { \
  return  cpowf( a, (TY)0.0) ; \
}
FP_CPOWF_ZERO_BACK(fcomp)

#define FP_POW_ZERO_BACK(TY) \
TY func_fp_pow_zero_back_ ## TY(TY a) { \
  return  pow( a, (TY)0.0) ; \
}
FP_POW_ZERO_BACK(double)

#define FP_CPOW_ZERO_BACK(TY) \
TY func_fp_cpow_zero_back_ ## TY(TY a) { \
  return  cpow( a, (TY)0.0) ; \
}
FP_CPOW_ZERO_BACK(dcomp)

#define FP_POWL_ZERO_BACK(TY) \
TY func_fp_powl_zero_back_ ## TY(TY a) { \
  return  powl( a, (TY)0.0) ; \
}
FP_POWL_ZERO_BACK(quad)

#define FP_CPOWL_ZERO_BACK(TY) \
TY func_fp_cpowl_zero_back_ ## TY(TY a) { \
  return  cpowl( a, (TY)0.0) ; \
}
FP_CPOWL_ZERO_BACK(qcomp)

#define FP_POWF_ZERO_FORE(TY) \
TY func_fp_powf_zero_fore_ ## TY(TY a) { \
  return  powf((TY)0.0, a) ; \
}
FP_POWF_ZERO_FORE(float)

#define FP_CPOWF_ZERO_FORE(TY) \
TY func_fp_cpowf_zero_fore_ ## TY(TY a) { \
  return  cpowf((TY)0.0, a) ; \
}
FP_CPOWF_ZERO_FORE(fcomp)

#define FP_POW_ZERO_FORE(TY) \
TY func_fp_pow_zero_fore_ ## TY(TY a) { \
  return  pow((TY)0.0, a) ; \
}
FP_POW_ZERO_FORE(double)

#define FP_CPOW_ZERO_FORE(TY) \
TY func_fp_cpow_zero_fore_ ## TY(TY a) { \
  return  cpow((TY)0.0, a) ; \
}
FP_CPOW_ZERO_FORE(dcomp)

#define FP_POWL_ZERO_FORE(TY) \
TY func_fp_powl_zero_fore_ ## TY(TY a) { \
  return  powl((TY)0.0, a) ; \
}
FP_POWL_ZERO_FORE(quad)

#define FP_CPOWL_ZERO_FORE(TY) \
TY func_fp_cpowl_zero_fore_ ## TY(TY a) { \
  return  cpowl((TY)0.0, a) ; \
}
FP_CPOWL_ZERO_FORE(qcomp)

#define FP_POWF_CONST_BACK(TY) \
TY func_fp_powf_const_back_ ## TY(TY a) { \
  return powf(a , (TY)-2.0); \
}
FP_POWF_CONST_BACK(float)

#define FP_CPOWF_CONST_BACK(TY) \
TY func_fp_cpowf_const_back_ ## TY(TY a) { \
  return cpowf(a , (TY)-2.0); \
}
FP_CPOWF_CONST_BACK(fcomp)

#define FP_POW_CONST_BACK(TY) \
TY func_fp_pow_const_back_ ## TY(TY a) { \
  return pow(a , (TY)-2.0); \
}
FP_POW_CONST_BACK(double)

#define FP_CPOW_CONST_BACK(TY) \
TY func_fp_cpow_const_back_ ## TY(TY a) { \
  return cpow(a , (TY)-2.0); \
}
FP_CPOW_CONST_BACK(dcomp)

#define FP_POWL_CONST_BACK(TY) \
TY func_fp_powl_const_back_ ## TY(TY a) { \
  return powl(a ,(TY)-2.0); \
}
FP_POWL_CONST_BACK(quad)

#define FP_CPOWL_CONST_BACK(TY) \
TY func_fp_cpowl_const_back_ ## TY(TY a) { \
  return cpowl(a ,(TY)-2.0); \
}
FP_CPOWL_CONST_BACK(qcomp)

#define FP_POWF_CONST_FORE(TY) \
TY func_fp_powf_const_fore_ ## TY(TY a) { \
  return powf((TY)-2.0, a); \
}
FP_POWF_CONST_FORE(float)

#define FP_CPOWF_CONST_FORE(TY) \
TY func_fp_cpowf_const_fore_ ## TY(TY a) { \
  return cpowf((TY)-2.0, a); \
}
FP_CPOWF_CONST_FORE(fcomp)

#define FP_POW_CONST_FORE(TY) \
TY func_fp_pow_const_fore_ ## TY(TY a) { \
  return pow((TY)-2.0, a); \
}
FP_POW_CONST_FORE(double)

#define FP_CPOW_CONST_FORE(TY) \
TY func_fp_cpow_const_fore_ ## TY(TY a) { \
  return cpow((TY)-2.0, a); \
}
FP_CPOW_CONST_FORE(dcomp)

#define FP_POWL_CONST_FORE(TY) \
TY func_fp_powl_const_fore_ ## TY(TY a) { \
  return powl((TY)-2.0, a); \
}
FP_POWL_CONST_FORE(quad)

#define FP_CPOWL_CONST_FORE(TY) \
TY func_fp_cpowl_const_fore_ ## TY(TY a) { \
  return cpowl((TY)-2.0, a); \
}
FP_CPOWL_CONST_FORE(qcomp)
