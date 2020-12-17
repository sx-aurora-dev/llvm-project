#include "types.h"
#include <math.h>

/// Test both ‘lshr’ and `ashr` instructions
///
/// ‘lshr’ Instruction
///
/// Syntax:
///   <result> = lshr <ty> <op1>, <op2>         ; yields ty:result
///   <result> = lshr exact <ty> <op1>, <op2>   ; yields ty:result
///
/// Overview:
///   The ‘lshr’ instruction (logical shift right) returns the first operand
///   shifted to the right a specified number of bits with zero fill.
///
/// Arguments:
///   Both arguments to the ‘lshr’ instruction must be the same integer or
///   vector of integer type. ‘op2’ is treated as an unsigned value.
///
/// Semantics:
///   This instruction always performs a logical shift right operation. The
///   most significant bits of the result will be filled with zero bits after
///   the shift. If op2 is (statically or dynamically) equal to or larger than
///   the number of bits in op1, this instruction returns a poison value. If
///   the arguments are vectors, each vector element of op1 is shifted by the
///   corresponding shift amount in op2.
///
///   If the exact keyword is present, the result value of the lshr is a
///   poison value if any of the bits shifted out are non-zero.
///
/// Example:
///   <result> = lshr i32 4, 1   ; yields i32:result = 2
///   <result> = lshr i32 4, 2   ; yields i32:result = 1
///   <result> = lshr i8  4, 3   ; yields i8:result = 0
///   <result> = lshr i8 -2, 1   ; yields i8:result = 0x7F
///   <result> = lshr i32 1, 32  ; undefined
///   <result> = lshr <2 x i32> < i32 -2, i32 4>, < i32 1, i32 2>
///                          ; yields: result=<2 x i32> < i32 0x7FFFFFFF, i32 1>
///
/// ‘ashr’ Instruction
///
/// Syntax:
///   <result> = ashr <ty> <op1>, <op2>         ; yields ty:result
///   <result> = ashr exact <ty> <op1>, <op2>   ; yields ty:result
///
/// Overview:
///   The ‘ashr’ instruction (arithmetic shift right) returns the first operand
///   shifted to the right a specified number of bits with sign extension.
///
/// Arguments:
///   Both arguments to the ‘ashr’ instruction must be the same integer or
///   vector of integer type. ‘op2’ is treated as an unsigned value.
///
/// Semantics:
///   This instruction always performs an arithmetic shift right operation, The
///   most significant bits of the result will be filled with the sign bit of
///   op1. If op2 is (statically or dynamically) equal to or larger than the
///   number of bits in op1, this instruction returns a poison value. If the
///   arguments are vectors, each vector element of op1 is shifted by the
///   corresponding shift amount in op2.
///
///   If the exact keyword is present, the result value of the ashr is a poison
///   value if any of the bits shifted out are non-zero.
///
/// Example:
///   <result> = ashr i32 4, 1   ; yields i32:result = 2
///   <result> = ashr i32 4, 2   ; yields i32:result = 1
///   <result> = ashr i8  4, 3   ; yields i8:result = 0
///   <result> = ashr i8 -2, 1   ; yields i8:result = -1
///   <result> = ashr i32 1, 32  ; undefined
///   <result> = ashr <2 x i32> < i32 -2, i32 4>, < i32 1, i32 3>
///                                  ; yields: result=<2 x i32> < i32 -1, i32 0>
///
/// Note:
///   We test only i8/i16/i32/i64/i128 and unsigned of them.

#define SHR_VAR(TY) \
TY shl_ ## TY ## _var(TY a, TY b) { \
  return a >> b; \
}
SHR_VAR(i8)
SHR_VAR(u8)
SHR_VAR(i16)
SHR_VAR(u16)
SHR_VAR(i32)
SHR_VAR(u32)
SHR_VAR(i64)
SHR_VAR(u64)
SHR_VAR(i128)
SHR_VAR(u128)

#define SHR_CONST_TY(TY, CONST) \
TY shl_const_ ## TY(TY a) { \
  return CONST >> a; \
}
SHR_CONST_TY(i8, (i8)-4)
SHR_CONST_TY(u8, (i8)-4)
SHR_CONST_TY(i16, (i16)-4)
SHR_CONST_TY(u16, (i16)-4)
SHR_CONST_TY(i32, (i32)-4)
SHR_CONST_TY(u32, (i32)-4)
SHR_CONST_TY(i64, (i64)-4)
SHR_CONST_TY(u64, (i64)-4)
SHR_CONST_TY(i128, (i128)-4)
SHR_CONST_TY(u128, (i128)-4)

#define SHR_TY_CONST(TY, CONST) \
TY shl_ ## TY ## _const(TY a) { \
  return a >> CONST; \
}
SHR_TY_CONST(i8, (i8)3)
SHR_TY_CONST(u8, (i8)3)
SHR_TY_CONST(i16, (i16)7)
SHR_TY_CONST(u16, (i16)7)
SHR_TY_CONST(i32, (i32)15)
SHR_TY_CONST(u32, (i32)15)
SHR_TY_CONST(i64, (i64)63)
SHR_TY_CONST(u64, (i64)63)
SHR_TY_CONST(i128, (i128)127)
SHR_TY_CONST(u128, (i128)127)
