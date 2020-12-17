#include "types.h"
#include <atomic>

/// Test atomic fence for all memory order

#define FENCE(NAME, ORDER) \
void atomic_fence_ ## NAME(void) { \
  std::atomic_thread_fence(ORDER); \
}
FENCE(relaxed, std::memory_order_relaxed)
FENCE(consume, std::memory_order_consume)
FENCE(acquire, std::memory_order_acquire)
FENCE(release, std::memory_order_release)
FENCE(acq_rel, std::memory_order_acq_rel)
FENCE(seq_cst, std::memory_order_seq_cst)
