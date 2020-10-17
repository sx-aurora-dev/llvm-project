#include "types.h"

#define BR_CC_VAR(TY) \
void br_cc_ ## TY ## _var(TY a, TY b) { \
  if (a == b) \
    __asm volatile("nop"); \
}

BR_CC_VAR(i1)
BR_CC_VAR(i8)
BR_CC_VAR(u8)
BR_CC_VAR(i16)
BR_CC_VAR(u16)
BR_CC_VAR(i32)
BR_CC_VAR(u32)
BR_CC_VAR(i64)
BR_CC_VAR(u64)
BR_CC_VAR(i128)
BR_CC_VAR(u128)
BR_CC_VAR(float)
BR_CC_VAR(double)
BR_CC_VAR(quad)

#define BR_CC_IMM_VAR(TY, LHS) \
void br_cc_ ## TY ## _imm(TY a) { \
  if (LHS > a) \
    __asm volatile("nop"); \
}

BR_CC_IMM_VAR(i1, 1)
BR_CC_IMM_VAR(i8, -9)
BR_CC_IMM_VAR(u8, 9)
BR_CC_IMM_VAR(i16, 63)
BR_CC_IMM_VAR(u16, 64)
BR_CC_IMM_VAR(i32, 64)
BR_CC_IMM_VAR(u32, 64)
BR_CC_IMM_VAR(i64, 64)
BR_CC_IMM_VAR(u64, 64)
BR_CC_IMM_VAR(i128, 64)
BR_CC_IMM_VAR(u128, 64)
BR_CC_IMM_VAR(float, 0)
BR_CC_IMM_VAR(double, 0)
BR_CC_IMM_VAR(quad, 0)

#define BR_CC_VAR_IMM(TY, RHS) \
void br_cc_imm_ ## TY(TY a) { \
  if (a >= RHS) \
    __asm volatile("nop"); \
}

BR_CC_VAR_IMM(i1, 1)
BR_CC_VAR_IMM(i8, -9)
BR_CC_VAR_IMM(u8, 9)
BR_CC_VAR_IMM(i16, 63)
BR_CC_VAR_IMM(u16, 64)
BR_CC_VAR_IMM(i32, -64)
BR_CC_VAR_IMM(u32, -64)
BR_CC_VAR_IMM(i64, -64)
BR_CC_VAR_IMM(u64, -64)
BR_CC_VAR_IMM(i128, -64)
BR_CC_VAR_IMM(u128, -64)
BR_CC_VAR_IMM(float, 0)
BR_CC_VAR_IMM(double, 0)
BR_CC_VAR_IMM(quad, 0)
