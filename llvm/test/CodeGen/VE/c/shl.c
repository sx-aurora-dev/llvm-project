#include "types.h"
#include <math.h>

/// Test ‘shl’ instruction
///
/// Syntax:
///   <result> = shl <ty> <op1>, <op2>           ; yields ty:result
///   <result> = shl nuw <ty> <op1>, <op2>       ; yields ty:result
///   <result> = shl nsw <ty> <op1>, <op2>       ; yields ty:result
///   <result> = shl nuw nsw <ty> <op1>, <op2>   ; yields ty:result
///
/// Overview:
///   The ‘shl’ instruction returns the first operand shifted to the left
///   a specified number of bits.
///
/// Arguments:
///   Both arguments to the ‘shl’ instruction must be the same integer or
///   vector of integer type. ‘op2’ is treated as an unsigned value.
///
/// Semantics:
///   The value produced is op1 * 2op2 mod 2n, where n is the width of the
///   result. If op2 is (statically or dynamically) equal to or larger than
///   the number of bits in op1, this instruction returns a poison value.
///   If the arguments are vectors, each vector element of op1 is shifted by
///   the corresponding shift amount in op2.
///
///   If the nuw keyword is present, then the shift produces a poison value
///   if it shifts out any non-zero bits. If the nsw keyword is present,
///   then the shift produces a poison value if it shifts out any bits that
///   disagree with the resultant sign bit.
///
/// Example:
///   <result> = shl i32 4, %var   ; yields i32: 4 << %var
///   <result> = shl i32 4, 2      ; yields i32: 16
///   <result> = shl i32 1, 10     ; yields i32: 1024
///   <result> = shl i32 1, 32     ; undefined
///   <result> = shl <2 x i32> < i32 1, i32 1>, < i32 1, i32 2>
///                                ; yields: result=<2 x i32> < i32 2, i32 4>
///
/// Note:
///   We test only i8/i16/i32/i64/i128 and unsigned of them.

#define SHL_VAR(TY) \
TY shl_ ## TY ## _var(TY a, TY b) { \
  return a << b; \
}
SHL_VAR(i8)
SHL_VAR(u8)
SHL_VAR(i16)
SHL_VAR(u16)
SHL_VAR(i32)
SHL_VAR(u32)
SHL_VAR(i64)
SHL_VAR(u64)
SHL_VAR(i128)
SHL_VAR(u128)

#define SHL_CONST_TY(TY, CONST) \
TY shl_const_ ## TY(TY a) { \
  return CONST << a; \
}
SHL_CONST_TY(i8, (i8)-4)
SHL_CONST_TY(u8, (i8)-4)
SHL_CONST_TY(i16, (i16)-4)
SHL_CONST_TY(u16, (i16)-4)
SHL_CONST_TY(i32, (i32)-4)
SHL_CONST_TY(u32, (i32)-4)
SHL_CONST_TY(i64, (i64)-4)
SHL_CONST_TY(u64, (i64)-4)
SHL_CONST_TY(i128, (i128)-4)
SHL_CONST_TY(u128, (i128)-4)

#define SHL_TY_CONST(TY, CONST) \
TY shl_ ## TY ## _const(TY a) { \
  return a << CONST; \
}
SHL_TY_CONST(i8, (i8)3)
SHL_TY_CONST(u8, (i8)3)
SHL_TY_CONST(i16, (i16)7)
SHL_TY_CONST(u16, (i16)7)
SHL_TY_CONST(i32, (i32)15)
SHL_TY_CONST(u32, (i32)15)
SHL_TY_CONST(i64, (i64)63)
SHL_TY_CONST(u64, (i64)63)
SHL_TY_CONST(i128, (i128)127)
SHL_TY_CONST(u128, (i128)127)
