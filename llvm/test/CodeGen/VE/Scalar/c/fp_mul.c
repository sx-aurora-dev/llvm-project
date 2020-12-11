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

#define FP_MUL_VAR(TY) \
TY func_mul_var_ ## TY(TY a, TY b) { \
  return a * b ; \
}

FP_MUL_VAR(float)
FP_MUL_VAR(double)
FP_MUL_VAR(quad)
FP_MUL_VAR(fcomp)
FP_MUL_VAR(dcomp)
FP_MUL_VAR(qcomp)


#define FP_MUL_ZERO(TY) \
TY func_mul_zero_ ## TY(TY a) { \
  return a * 0.0 ; \
}

FP_MUL_ZERO(float)
FP_MUL_ZERO(double)
FP_MUL_ZERO(quad)
FP_MUL_ZERO(fcomp)
FP_MUL_ZERO(dcomp)
FP_MUL_ZERO(qcomp)


#define FP_MUL_CONST(TY) \
TY func_mul_const_ ## TY(TY a) { \
  return a * (-2.0) ; \
}

FP_MUL_CONST(float)
FP_MUL_CONST(double)
FP_MUL_CONST(quad)
FP_MUL_CONST(fcomp)
FP_MUL_CONST(dcomp)
FP_MUL_CONST(qcomp)
