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

#define FP_SUB_VAR(TY) \
TY func_sub_var_ ## TY(TY a, TY b) { \
  return a - b ; \
}

FP_SUB_VAR(float)
FP_SUB_VAR(double)
FP_SUB_VAR(quad)
FP_SUB_VAR(fcomp)
FP_SUB_VAR(dcomp)
FP_SUB_VAR(qcomp)


#define FP_SUB_ZERO_BACK(TY) \
TY func_sub_zero_back_ ## TY(TY a) { \
  return a - 0.0 ; \
}

FP_SUB_ZERO_BACK(float)
FP_SUB_ZERO_BACK(double)
FP_SUB_ZERO_BACK(quad)
FP_SUB_ZERO_BACK(fcomp)
FP_SUB_ZERO_BACK(dcomp)
FP_SUB_ZERO_BACK(qcomp)

#define FP_SUB_ZERO_FORE(TY) \
TY func_sub_zero_fore_ ## TY(TY a) { \
  return  0.0 - a ; \
}

FP_SUB_ZERO_FORE(float)
FP_SUB_ZERO_FORE(double)
FP_SUB_ZERO_FORE(quad)
FP_SUB_ZERO_FORE(fcomp)
FP_SUB_ZERO_FORE(dcomp)
FP_SUB_ZERO_FORE(qcomp)


#define FP_SUB_CONST_BACK(TY) \
TY func_sub_const_back_ ## TY(TY a) { \
  return a - (-2.0) ; \
}

FP_SUB_CONST_BACK(float)
FP_SUB_CONST_BACK(double)
FP_SUB_CONST_BACK(quad)
FP_SUB_CONST_BACK(fcomp)
FP_SUB_CONST_BACK(dcomp)
FP_SUB_CONST_BACK(qcomp)

#define FP_SUB_CONST_FORE(TY) \
TY func__const_fore_ ## TY(TY a) { \
  return  -2.0 - a ; \
}

FP_SUB_CONST_FORE(float)
FP_SUB_CONST_FORE(double)
FP_SUB_CONST_FORE(quad)
FP_SUB_CONST_FORE(fcomp)
FP_SUB_CONST_FORE(dcomp)
FP_SUB_CONST_FORE(qcomp)
