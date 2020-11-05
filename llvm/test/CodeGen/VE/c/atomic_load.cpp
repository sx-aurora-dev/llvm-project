#include "types.h"
#include <atomic>

/// Test atomic load for all types and all memory order
///
/// Note:
///   We test i1/i8/i16/i32/i64/i128/u8/u16/u32/u64/u128.
///   We test relaxed, acquire, and seq_cst.

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
