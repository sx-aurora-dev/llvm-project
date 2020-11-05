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

#define FP_DIV_VAR(TY) \
TY func_div_var_ ## TY(TY a, TY b) { \
  return a / b ; \
}

FP_DIV_VAR(float)
FP_DIV_VAR(double)
FP_DIV_VAR(quad)
FP_DIV_VAR(fcomp)
FP_DIV_VAR(dcomp)
FP_DIV_VAR(qcomp)

#define FP_DIV_ZERO(TY) \
TY func_div_zero_ ## TY(TY a) { \
  return  0.0 / a ; \
}

FP_DIV_ZERO(float)
FP_DIV_ZERO(double)
FP_DIV_ZERO(quad)
FP_DIV_ZERO(fcomp)
FP_DIV_ZERO(dcomp)
FP_DIV_ZERO(qcomp)


#define FP_DIV_CONST_BACK(TY) \
TY func_div_const_back_ ## TY(TY a) { \
  return a / (-2.0) ; \
}

FP_DIV_CONST_BACK(float)
FP_DIV_CONST_BACK(double)
FP_DIV_CONST_BACK(quad)
FP_DIV_CONST_BACK(fcomp)
FP_DIV_CONST_BACK(dcomp)
FP_DIV_CONST_BACK(qcomp)

#define FP_DIV_CONST_FORE(TY) \
TY func_div_cont_fore_ ## TY(TY a) { \
  return  -2.0 / a ; \
}

FP_DIV_CONST_FORE(float)
FP_DIV_CONST_FORE(double)
FP_DIV_CONST_FORE(quad)
FP_DIV_CONST_FORE(fcomp)
FP_DIV_CONST_FORE(dcomp)
FP_DIV_CONST_FORE(qcomp)
