#include "types.h"
#include <atomic>

/// Test atomic store for all types and all memory order
///
/// Note:
///   We test i1/i8/i16/i32/i64/i128/u8/u16/u32/u64/u128.
///   We test relaxed, release, and seq_cst.

#define AS_REL(TY) \
void atomic_store_relaxed_ ## TY(std::atomic<TY>& a, TY b) { \
  a.store(b, std::memory_order_relaxed); \
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

#define AS_RELE(TY) \
void atomic_store_release_ ## TY(std::atomic<TY>& a, TY b) { \
  a.store(b, std::memory_order_release); \
}
AS_RELE(i1)
AS_RELE(i8)
AS_RELE(u8)
AS_RELE(i16)
AS_RELE(u16)
AS_RELE(i32)
AS_RELE(u32)
AS_RELE(i64)
AS_RELE(u64)
AS_RELE(i128)
AS_RELE(u128)

#define AS_CST(TY) \
void atomic_store_seq_cst_ ## TY(std::atomic<TY>& a, TY b) { \
  a.store(b, std::memory_order_seq_cst); \
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
