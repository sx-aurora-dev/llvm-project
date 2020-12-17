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

/// Test atomic compare and exchange weak for all types and all memory order
///
/// Note:
///   - We test i1/i8/i16/i32/i64/i128/u8/u16/u32/u64/u128.
///   - We test relaxed, acquire, and seq_cst.
///   - We test only exchange with variables since VE doesn't have exchange
///     instructions with immediate values.
///   - We test against an object, a stack object, and a global variable.

#define ACS_REL(TY) \
TY atomic_cmp_swap_relaxed_ ## TY(std::atomic<TY>& a, TY& expected, TY val) { \
  return a.compare_exchange_weak(expected, val, std::memory_order_relaxed); \
}
ACS_REL(i1)
ACS_REL(i8)
ACS_REL(u8)
ACS_REL(i16)
ACS_REL(u16)
ACS_REL(i32)
ACS_REL(u32)
ACS_REL(i64)
ACS_REL(u64)
ACS_REL(i128)
ACS_REL(u128)

#define ACS_ACQ(TY) \
TY atomic_cmp_swap_acquire_ ## TY(std::atomic<TY>& a, TY& expected, TY val) { \
  return a.compare_exchange_weak(expected, val, std::memory_order_acquire); \
}
ACS_ACQ(i1)
ACS_ACQ(i8)
ACS_ACQ(u8)
ACS_ACQ(i16)
ACS_ACQ(u16)
ACS_ACQ(i32)
ACS_ACQ(u32)
ACS_ACQ(i64)
ACS_ACQ(u64)
ACS_ACQ(i128)
ACS_ACQ(u128)

#define ACS_CST(TY) \
TY atomic_cmp_swap_seq_cst_ ## TY(std::atomic<TY>& a, TY& expected, TY val) { \
  return a.compare_exchange_weak(expected, val, std::memory_order_seq_cst); \
}
ACS_CST(i1)
ACS_CST(i8)
ACS_CST(u8)
ACS_CST(i16)
ACS_CST(u16)
ACS_CST(i32)
ACS_CST(u32)
ACS_CST(i64)
ACS_CST(u64)
ACS_CST(i128)
ACS_CST(u128)

#define ACS_REL_STK(TY) \
TY atomic_cmp_swap_relaxed_stk_ ## TY(TY& expected, TY val) { \
  volatile std::atomic<TY> stk __attribute__((align(4))); \
  return stk.compare_exchange_weak(expected, val, std::memory_order_relaxed); \
}
ACS_REL_STK(i1)
ACS_REL_STK(i8)
ACS_REL_STK(u8)
ACS_REL_STK(i16)
ACS_REL_STK(u16)
ACS_REL_STK(i32)
ACS_REL_STK(u32)
ACS_REL_STK(i64)
ACS_REL_STK(u64)
ACS_REL_STK(i128)
ACS_REL_STK(u128)

#define ACS_REL_GV(TY) \
TY atomic_cmp_swap_relaxed_gv_ ## TY(TY& expected, TY val) { \
  return gv_ ## TY \
      .compare_exchange_weak(expected, val, std::memory_order_relaxed); \
}
ACS_REL_GV(i1)
ACS_REL_GV(i8)
ACS_REL_GV(u8)
ACS_REL_GV(i16)
ACS_REL_GV(u16)
ACS_REL_GV(i32)
ACS_REL_GV(u32)
ACS_REL_GV(i64)
ACS_REL_GV(u64)
ACS_REL_GV(i128)
ACS_REL_GV(u128)
