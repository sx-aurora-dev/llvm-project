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

#define FP_DIV_VAR(TY, FUNC_NAME) \
TY func_fp_div_var ## FUNC_NAME(TY a, TY b) { \
  return a / b ; \
}

FP_DIV_VAR(float,  1)
FP_DIV_VAR(double, 2)
FP_DIV_VAR(quad,   3)
FP_DIV_VAR(fcomp,  4)
FP_DIV_VAR(dcomp,  5)
FP_DIV_VAR(qcomp,  6)

#define FP_DIV_ZERO(TY, FUNC_NAME) \
TY func_fp_div_zero ## FUNC_NAME(TY a) { \
  return  0.0 / a ; \
}

FP_DIV_ZERO(float,  1)
FP_DIV_ZERO(double, 2)
FP_DIV_ZERO(quad,   3)
FP_DIV_ZERO(fcomp,  4)
FP_DIV_ZERO(dcomp,  5)
FP_DIV_ZERO(qcomp,  6)


#define FP_DIV_CONST_BACK(TY, FUNC_NAME) \
TY func_fp_div_const_back ## FUNC_NAME(TY a) { \
  return a / (-2.0) ; \
}

FP_DIV_CONST_BACK(float,  1)
FP_DIV_CONST_BACK(double, 2)
FP_DIV_CONST_BACK(quad,   3)
FP_DIV_CONST_BACK(fcomp,  4)
FP_DIV_CONST_BACK(dcomp,  5)
FP_DIV_CONST_BACK(qcomp,  6)

#define FP_DIV_CONST_FORE(TY, FUNC_NAME) \
TY func_fp_div_cont_fore ## FUNC_NAME(TY a) { \
  return  -2.0 / a ; \
}

FP_DIV_CONST_FORE(float,  1)
FP_DIV_CONST_FORE(double, 2)
FP_DIV_CONST_FORE(quad,   3)
FP_DIV_CONST_FORE(fcomp,  4)
FP_DIV_CONST_FORE(dcomp,  5)
FP_DIV_CONST_FORE(qcomp,  6)
