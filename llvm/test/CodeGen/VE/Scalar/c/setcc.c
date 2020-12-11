#include "types.h"

/// Test all combination of input type and output type among following types.
///
/// Types:
///  i1/i8/u8/i16/u16/i32/u32/i64/u64/i128/u128/float/double/fp128

#define SETCC_VAR(TY) \
_Bool setcc_ ## TY(TY a, TY b) { \
  return a == b; \
}

SETCC_VAR(i1)
SETCC_VAR(i8)
SETCC_VAR(u8)
SETCC_VAR(i16)
SETCC_VAR(u16)
SETCC_VAR(i32)
SETCC_VAR(u32)
SETCC_VAR(i64)
SETCC_VAR(u64)
SETCC_VAR(i128)
SETCC_VAR(u128)
SETCC_VAR(float)
SETCC_VAR(double)
SETCC_VAR(quad)
