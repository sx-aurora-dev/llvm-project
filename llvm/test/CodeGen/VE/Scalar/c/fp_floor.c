#include "types.h"

#define FP_FLOOR_VAR(TY, NAME) \
TY func_fp_floor_var_ ## TY(TY a) { \
  return __builtin_ ## NAME(a); \
}
FP_FLOOR_VAR(float, floorf)
FP_FLOOR_VAR(double, floor)
FP_FLOOR_VAR(quad, floorl)

#define FP_FLOOR_ZERO(TY, NAME) \
TY func_fp_floor_zero_ ## TY() { \
  return __builtin_ ## NAME((TY)0.0); \
}
FP_FLOOR_ZERO(float, floorf)
FP_FLOOR_ZERO(double, floor)
FP_FLOOR_ZERO(quad, floorl)

#define FP_FLOOR_CONST(TY, NAME) \
TY func_fp_floor_const_ ## TY() { \
  return __builtin_ ## NAME((TY)-2.0); \
}
FP_FLOOR_CONST(float, floorf)
FP_FLOOR_CONST(double, floor)
FP_FLOOR_CONST(quad, floorl)
