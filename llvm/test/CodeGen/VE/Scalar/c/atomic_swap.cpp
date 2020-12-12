#include "types.h"
#include <atomic>

std::atomic<i1> gv_i1 __attribute__((aligned(4)));
std::atomic<i8> gv_i8 __attribute__((aligned(4)));
std::atomic<u8> gv_u8 __attribute__((aligned(4)));
std::atomic<i16> gv_i16 __attribute__((aligned(4))); // Use 4 to check load+and
std::atomic<u16> gv_u16 __attribute__((aligned(4))); // combining.
std::atomic<i32> gv_i32 __attribute__((aligned(4)));
std::atomic<u32> gv_u32 __attribute__((aligned(4)));
std::atomic<i64> gv_i64 __attribute__((aligned(8)));
std::atomic<u64> gv_u64 __attribute__((aligned(8)));
std::atomic<i128> gv_i128 __attribute__((aligned(16)));
std::atomic<u128> gv_u128 __attribute__((aligned(16)));

/// Test atomic swap for all types and all memory order
///
/// Note:
///   - We test i1/i8/i16/i32/i64/i128/u8/u16/u32/u64/u128.
///   - We test relaxed, acquire, and seq_cst.
///   - We test only exchange with variables since VE doesn't have exchange
///     instructions with immediate values.
///   - We test against an object, a stack object, and a global variable.

#define AS_REL(TY) \
TY atomic_swap_relaxed_ ## TY(std::atomic<TY>& a, TY val) { \
  return a.exchange(val, std::memory_order_relaxed); \
}
AS_REL(i1)
AS_REL(i8)
AS_REL(u8)
AS_REL(i16)
AS_REL(u16)
AS_REL(i32)
AS_REL(u32)
AS_REL(i64)
AS_REL(u64)
AS_REL(i128)
AS_REL(u128)

#define AS_ACQ(TY) \
TY atomic_swap_acquire_ ## TY(std::atomic<TY>& a, TY val) { \
  return a.exchange(val, std::memory_order_acquire); \
}
AS_ACQ(i1)
AS_ACQ(i8)
AS_ACQ(u8)
AS_ACQ(i16)
AS_ACQ(u16)
AS_ACQ(i32)
AS_ACQ(u32)
AS_ACQ(i64)
AS_ACQ(u64)
AS_ACQ(i128)
AS_ACQ(u128)

#define AS_CST(TY) \
TY atomic_swap_seq_cst_ ## TY(std::atomic<TY>& a, TY val) { \
  return a.exchange(val, std::memory_order_seq_cst); \
}
AS_CST(i1)
AS_CST(i8)
AS_CST(u8)
AS_CST(i16)
AS_CST(u16)
AS_CST(i32)
AS_CST(u32)
AS_CST(i64)
AS_CST(u64)
AS_CST(i128)
AS_CST(u128)

#define AS_REL_STK(TY) \
TY atomic_swap_relaxed_stk_ ## TY(TY val) { \
  volatile std::atomic<TY> stk __attribute__((align(4))); \
  return stk.exchange(val, std::memory_order_relaxed); \
}
AS_REL_STK(i1)
AS_REL_STK(i8)
AS_REL_STK(u8)
AS_REL_STK(i16)
AS_REL_STK(u16)
AS_REL_STK(i32)
AS_REL_STK(u32)
AS_REL_STK(i64)
AS_REL_STK(u64)
AS_REL_STK(i128)
AS_REL_STK(u128)

#define AS_REL_GV(TY) \
TY atomic_swap_relaxed_gv_ ## TY(TY val) { \
  return gv_ ## TY .exchange(val, std::memory_order_relaxed); \
}
AS_REL_GV(i1)
AS_REL_GV(i8)
AS_REL_GV(u8)
AS_REL_GV(i16)
AS_REL_GV(u16)
AS_REL_GV(i32)
AS_REL_GV(u32)
AS_REL_GV(i64)
AS_REL_GV(u64)
AS_REL_GV(i128)
AS_REL_GV(u128)
