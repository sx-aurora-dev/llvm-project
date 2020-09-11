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

#define FP_MUL_VAR(TY, FUNC_NAME) \
TY func_fp_mul_var ## FUNC_NAME(TY a, TY b) { \
  return a * b ; \
}

FP_MUL_VAR(float,  1)
FP_MUL_VAR(double, 2)
FP_MUL_VAR(quad,   3)
FP_MUL_VAR(fcomp,  4)
FP_MUL_VAR(dcomp,  5)
FP_MUL_VAR(qcomp,  6)


#define FP_MUL_ZERO(TY, FUNC_NAME) \
TY func_fp_mul_zero ## FUNC_NAME(TY a) { \
  return a * 0.0 ; \
}

FP_MUL_ZERO(float,  1)
FP_MUL_ZERO(double, 2)
FP_MUL_ZERO(quad,   3)
FP_MUL_ZERO(fcomp,  4)
FP_MUL_ZERO(dcomp,  5)
FP_MUL_ZERO(qcomp,  6)


#define FP_MUL_CONST(TY, FUNC_NAME) \
TY func_fp_mul_const ## FUNC_NAME(TY a) { \
  return a * (-2.0) ; \
}

FP_MUL_CONST(float,  1)
FP_MUL_CONST(double, 2)
FP_MUL_CONST(quad,   3)
FP_MUL_CONST(fcomp,  4)
FP_MUL_CONST(dcomp,  5)
FP_MUL_CONST(qcomp,  6)
