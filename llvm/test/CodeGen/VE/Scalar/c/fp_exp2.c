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

#define FP_EXP2F_VAR(TY) \
TY func_fp_exp2f_var_ ## TY(TY a) { \
  return exp2f(a); \
}
FP_EXP2F_VAR(float)

//#define FP_CEXP2F_VAR(TY) \
//TY func_fp_cexp2f_var_ ## TY(TY a) { \
//  return cexp2f(a); \
//}
//FP_CEXP2F_VAR(fcomp)

#define FP_EXP2_VAR(TY) \
TY func_fp_exp2_var_ ## TY(TY a) { \
  return exp2(a); \
}
FP_EXP2_VAR(double)
//FP_EXP2_VAR(dcomp)

#define FP_EXP2L_VAR(TY) \
TY func_fp_exp2l_var_ ## TY(TY a) { \
  return exp2l(a); \
}
FP_EXP2L_VAR(quad)
//FP_EXP2L_VAR(qcomp)


#define FP_EXP2F_ZERO(TY) \
TY func_fp_exp2f_zero_ ## TY() { \
  return  exp2f((TY)0.0) ; \
}
FP_EXP2F_ZERO(float)
//FP_EXP2F_ZERO(fcomp)

#define FP_EXP2_ZERO(TY) \
TY func_fp_EXP2_zero_ ## TY() { \
  return  exp2((TY)0.0) ; \
}
FP_EXP2_ZERO(double)
//FP_EXP2_ZERO(dcomp)

#define FP_EXP2L_ZERO(TY) \
TY func_fp_exp2l_zero_ ## TY() { \
  return  exp2l((TY)0.0) ; \
}
FP_EXP2L_ZERO(quad)
//FP_EXP2L_ZERO(qcomp)

#define FP_EXP2F_CONST(TY) \
TY func_fp_exp2f_const_ ## TY() { \
  return exp2f((TY)-2.0); \
}
FP_EXP2F_CONST(float)
//FP_EXP2F_CONST(fcomp)

#define FP_EXP2_CONST(TY) \
TY func_fp_exp2_const_ ## TY() { \
  return exp2((TY)-2.0); \
}
FP_EXP2_CONST(double)
//FP_EXP2_CONST(dcomp)

#define FP_EXP2L_CONST(TY) \
TY func_fp_exp2l_const_ ## TY() { \
  return exp2l((TY)-2.0); \
}
FP_EXP2L_CONST(quad)
//FP_EXP2L_CONST(qcomp)
