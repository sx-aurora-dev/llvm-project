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

#define FP_ADD_VAR(TY) \
TY func_add_var_ ## TY(TY a, TY b) { \
  return a + b ; \
}

FP_ADD_VAR(float)
FP_ADD_VAR(double)
FP_ADD_VAR(quad)
FP_ADD_VAR(fcomp)
FP_ADD_VAR(dcomp)
FP_ADD_VAR(qcomp)


#define FP_ADD_ZERO(TY) \
TY func_add_zero_ ## TY(TY a) { \
  return  0.0 + a ; \
}

FP_ADD_ZERO(float)
FP_ADD_ZERO(double)
FP_ADD_ZERO(quad)
FP_ADD_ZERO(fcomp)
FP_ADD_ZERO(dcomp)
FP_ADD_ZERO(qcomp)


#define FP_ADD_CONST(TY) \
TY func_add_const_ ## TY(TY a) { \
  return a + (-2.0) ; \
}

FP_ADD_CONST(float)
FP_ADD_CONST(double)
FP_ADD_CONST(quad)
FP_ADD_CONST(fcomp)
FP_ADD_CONST(dcomp)
FP_ADD_CONST(qcomp)
