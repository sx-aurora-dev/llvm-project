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

#define FP_SUB_VAR(TY, FUNC_NAME) \
TY func_fp_sub_var ## FUNC_NAME(TY a, TY b) { \
  return a - b ; \
}

FP_SUB_VAR(float,  1)
FP_SUB_VAR(double, 2)
FP_SUB_VAR(quad,   3)
FP_SUB_VAR(fcomp,  4)
FP_SUB_VAR(dcomp,  5)
FP_SUB_VAR(qcomp,  6)


#define FP_SUB_ZERO_BACK(TY, FUNC_NAME) \
TY func_fp_sub_zero_back ## FUNC_NAME(TY a) { \
  return a - 0.0 ; \
}

FP_SUB_ZERO_BACK(float,  1)
FP_SUB_ZERO_BACK(double, 2)
FP_SUB_ZERO_BACK(quad,   3)
FP_SUB_ZERO_BACK(fcomp,  4)
FP_SUB_ZERO_BACK(dcomp,  5)
FP_SUB_ZERO_BACK(qcomp,  6)

#define FP_SUB_ZERO_FORE(TY, FUNC_NAME) \
TY func_fp_sub_zero_fore ## FUNC_NAME(TY a) { \
  return  0.0 - a ; \
}

FP_SUB_ZERO_FORE(float,  1)
FP_SUB_ZERO_FORE(double, 2)
FP_SUB_ZERO_FORE(quad,   3)
FP_SUB_ZERO_FORE(fcomp,  4)
FP_SUB_ZERO_FORE(dcomp,  5)
FP_SUB_ZERO_FORE(qcomp,  6)


#define FP_SUB_CONST_BACK(TY, FUNC_NAME) \
TY func_fp_sub_const_back ## FUNC_NAME(TY a) { \
  return a - (-2.0) ; \
}

FP_SUB_CONST_BACK(float,  1)
FP_SUB_CONST_BACK(double, 2)
FP_SUB_CONST_BACK(quad,   3)
FP_SUB_CONST_BACK(fcomp,  4)
FP_SUB_CONST_BACK(dcomp,  5)
FP_SUB_CONST_BACK(qcomp,  6)

#define FP_SUB_CONST_FORE(TY, FUNC_NAME) \
TY func_fp_sub_const_fore ## FUNC_NAME(TY a) { \
  return  -2.0 - a ; \
}

FP_SUB_CONST_FORE(float,  1)
FP_SUB_CONST_FORE(double, 2)
FP_SUB_CONST_FORE(quad,   3)
FP_SUB_CONST_FORE(fcomp,  4)
FP_SUB_CONST_FORE(dcomp,  5)
FP_SUB_CONST_FORE(qcomp,  6)
