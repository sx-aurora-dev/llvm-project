#include "types.h"

#define FP_NEARBYINT_VAR(TY, NAME) \
TY func_fp_nearbyint_var_ ## TY(TY a) { \
  return __builtin_ ## NAME(a); \
}
FP_NEARBYINT_VAR(float, nearbyintf)
FP_NEARBYINT_VAR(double, nearbyint)
FP_NEARBYINT_VAR(quad, nearbyintl)

#define FP_NEARBYINT_ZERO(TY, NAME) \
TY func_fp_nearbyint_zero_ ## TY() { \
  return __builtin_ ## NAME((TY)0.0); \
}
FP_NEARBYINT_ZERO(float, nearbyintf)
FP_NEARBYINT_ZERO(double, nearbyint)
FP_NEARBYINT_ZERO(quad, nearbyintl)

#define FP_NEARBYINT_CONST(TY, NAME) \
TY func_fp_nearbyint_const_ ## TY() { \
  return __builtin_ ## NAME((TY)-2.0); \
}
FP_NEARBYINT_CONST(float, nearbyintf)
FP_NEARBYINT_CONST(double, nearbyint)
FP_NEARBYINT_CONST(quad, nearbyintl)
