//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// VE Communication Register (CR) runtime support for std::barrier.
//
// Provides CRD allocation, CR register pool management, and barrier
// initialization using direct syscall to avoid libsysve dependency.

#ifdef __ve__

#  include <barrier>
#  include <pthread.h>
#  include <sys/syscall.h>
#  include <unistd.h>

// VE sysve constants (inlined from veos headers to avoid dependency)
static constexpr uint64_t _VE_SYS_SYSVE    = 316;
static constexpr uint64_t _VE_SYSVE_CR_CTL = 0x21;
static constexpr uint64_t _VE_CR_ALLOC     = 0x40;
static constexpr uint64_t _VE_CR_THREAD    = 1ULL << 36;

_LIBCPP_BEGIN_NAMESPACE_STD

static int __cr_crd = -1;
static pthread_once_t __cr_once = PTHREAD_ONCE_INIT;
static atomic<uint32_t> __cr_pool{0}; // 32 bits, one per CR register

static void __ve_cr_init_once() {
  long result = syscall(_VE_SYS_SYSVE, _VE_SYSVE_CR_CTL, _VE_CR_ALLOC, _VE_CR_THREAD);
  if (result >= 0) {
    __cr_crd = static_cast<int>(result);
    // Zero all 32 registers
    for (int i = 0; i < 32; i++) {
      uint64_t addr = (static_cast<uint64_t>(__cr_crd) << 5) | static_cast<uint64_t>(i);
      __builtin_ve_vl_scr_sss(0, addr, 0);
    }
  }
}

_LIBCPP_EXPORTED_FROM_ABI bool __ve_cr_init() {
  pthread_once(&__cr_once, __ve_cr_init_once);
  return __cr_crd >= 0;
}

_LIBCPP_EXPORTED_FROM_ABI int __ve_cr_alloc_reg() {
  uint32_t old_pool = __cr_pool.load(memory_order_relaxed);
  while (true) {
    if (old_pool == 0xFFFFFFFF)
      return -1; // All 32 registers in use
    int reg             = __builtin_ctz(~old_pool);
    uint32_t new_pool   = old_pool | (1u << reg);
    if (__cr_pool.compare_exchange_weak(old_pool, new_pool, memory_order_acq_rel, memory_order_relaxed))
      return reg;
  }
}

_LIBCPP_EXPORTED_FROM_ABI void __ve_cr_free_reg(int __reg) {
  __cr_pool.fetch_and(~(1u << __reg), memory_order_release);
}

_LIBCPP_EXPORTED_FROM_ABI int __ve_cr_get_crd() { return __cr_crd; }

_LIBCPP_EXPORTED_FROM_ABI void __ve_cr_barrier_init(int __reg, int __count) {
  uint64_t addr = (static_cast<uint64_t>(__cr_crd) << 5) | static_cast<uint64_t>(__reg);
  // CR register layout (VE big-endian bit numbering):
  //   bit[0]:     phase flag = 0
  //   bit[8:31]:  reset count (24 bits)
  //   bit[40:63]: current counter (24 bits)
  uint64_t val = (static_cast<uint64_t>(__count) << 32) | static_cast<uint64_t>(__count);
  __builtin_ve_vl_scr_sss(val, addr, 0);
}

_LIBCPP_END_NAMESPACE_STD

#endif // __ve__
