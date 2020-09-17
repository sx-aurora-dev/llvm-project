#include <math.h>
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

#define FP_LLRINTF_VAR(TY) \
TY func_fp_llrintf_var_ ## TY(TY a) { \
  return llrintf(a); \
}
FP_LLRINTF_VAR(float)

#define FP_LLRINT_VAR(TY) \
TY func_fp_llrint_var_ ## TY(TY a) { \
  return llrint(a); \
}
FP_LLRINT_VAR(double)

#define FP_LLRINTL_VAR(TY) \
TY func_fp_llrintl_var_ ## TY(TY a) { \
  return llrintl(a); \
}
FP_LLRINTL_VAR(quad)

#define FP_LLRINTF_ZERO(TY) \
TY func_fp_llrintf_zero_ ## TY() { \
  return  llrintf((TY)0.0) ; \
}
FP_LLRINTF_ZERO(float)

#define FP_LLRINT_ZERO(TY) \
TY func_fp_LLRINT_zero_ ## TY() { \
  return  llrint((TY)0.0) ; \
}
FP_LLRINT_ZERO(double)

#define FP_LLRINTL_ZERO(TY) \
TY func_fp_llrintl_zero_ ## TY() { \
  return  llrintl((TY)0.0) ; \
}
FP_LLRINTL_ZERO(quad)

#define FP_LLRINTF_CONST(TY) \
TY func_fp_llrintf_const_ ## TY() { \
  return llrintf((TY)-2.0); \
}
FP_LLRINTF_CONST(float)

#define FP_LLRINT_CONST(TY) \
TY func_fp_llrint_const_ ## TY() { \
  return llrint((TY)-2.0); \
}
FP_LLRINT_CONST(double)

#define FP_LLRINTL_CONST(TY) \
TY func_fp_llrintl_const_ ## TY() { \
  return llrintl((TY)-2.0); \
}
FP_LLRINTL_CONST(quad)
