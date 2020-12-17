#include "types.h"
#include <atomic>

std::atomic<i1> gv_i1 __attribute__((aligned(4)));
std::atomic<i8> gv_i8 __attribute__((aligned(4)));
std::atomic<u8> gv_u8 __attribute__((aligned(4)));
std::atomic<i16> gv_i16 __attribute__((aligned(4)));
std::atomic<u16> gv_u16 __attribute__((aligned(4)));
std::atomic<i32> gv_i32 __attribute__((aligned(4)));
std::atomic<u32> gv_u32 __attribute__((aligned(4)));
std::atomic<i64> gv_i64 __attribute__((aligned(8)));
std::atomic<u64> gv_u64 __attribute__((aligned(8)));
std::atomic<i128> gv_i128 __attribute__((aligned(16)));
std::atomic<u128> gv_u128 __attribute__((aligned(16)));

/// Test atomic load for all types and all memory order
///
/// Note:
///   We test i1/i8/i16/i32/i64/i128/u8/u16/u32/u64/u128.
///   We test relaxed, acquire, and seq_cst.
///   We test an object, a stack object, and a global variable.

#define AL_REL(TY) \
TY atomic_load_relaxed_ ## TY(std::atomic<TY>& a) { \
  return a.load(std::memory_order_relaxed); \
}
AL_REL(i1)
AL_REL(i8)
AL_REL(u8)
AL_REL(i16)
AL_REL(u16)
AL_REL(i32)
AL_REL(u32)
AL_REL(i64)
AL_REL(u64)
AL_REL(i128)
AL_REL(u128)

#define AL_ACQ(TY) \
TY atomic_load_acquire_ ## TY(std::atomic<TY>& a) { \
  return a.load(std::memory_order_acquire); \
}
AL_ACQ(i1)
AL_ACQ(i8)
AL_ACQ(u8)
AL_ACQ(i16)
AL_ACQ(u16)
AL_ACQ(i32)
AL_ACQ(u32)
AL_ACQ(i64)
AL_ACQ(u64)
AL_ACQ(i128)
AL_ACQ(u128)

#define AL_CST(TY) \
TY atomic_load_seq_cst_ ## TY(std::atomic<TY>& a) { \
  return a.load(std::memory_order_seq_cst); \
}
AL_CST(i1)
AL_CST(i8)
AL_CST(u8)
AL_CST(i16)
AL_CST(u16)
AL_CST(i32)
AL_CST(u32)
AL_CST(i64)
AL_CST(u64)
AL_CST(i128)
AL_CST(u128)

#define AL_REL_STK(TY) \
void fun_ ## TY(std::atomic<TY>&); \
TY atomic_load_relaxed_stk_ ## TY() { \
  std::atomic<TY> stk; \
  fun_ ## TY(stk); \
  return stk.load(std::memory_order_relaxed); \
}
AL_REL_STK(i1)
AL_REL_STK(i8)
AL_REL_STK(u8)
AL_REL_STK(i16)
AL_REL_STK(u16)
AL_REL_STK(i32)
AL_REL_STK(u32)
AL_REL_STK(i64)
AL_REL_STK(u64)
AL_REL_STK(i128)
AL_REL_STK(u128)

#define AL_REL_GV(TY) \
TY atomic_load_relaxed_gv_ ## TY() { \
  return gv_ ## TY .load(std::memory_order_relaxed); \
}
AL_REL_GV(i1)
AL_REL_GV(i8)
AL_REL_GV(u8)
AL_REL_GV(i16)
AL_REL_GV(u16)
AL_REL_GV(i32)
AL_REL_GV(u32)
AL_REL_GV(i64)
AL_REL_GV(u64)
AL_REL_GV(i128)
AL_REL_GV(u128)
