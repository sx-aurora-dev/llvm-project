#include "types.h"
#include "velintrin.h"

/// Test intrinsics for communication register
///
/// Note:
///   We test LCR, SCR, TSCR, and FIDCR instructions.

u64 lcr_sss(u64 sy, u64 sz) {
  return _vel_lcr_sss(sy, sz);
}

void scr_sss(u64 sx, u64 sy, u64 sz) {
  _vel_scr_sss(sx, sy, sz);
}

u64 tscr_ssss(u64 sx, u64 sy, u64 sz) {
  return _vel_tscr_ssss(sx, sy, sz);
}

#define VL_FIDCR(N) \
u64 fidcr_ss ## N(u64 sy) { \
  return _vel_fidcr_sss(sy, N); \
}

VL_FIDCR(0)
VL_FIDCR(1)
VL_FIDCR(2)
VL_FIDCR(3)
VL_FIDCR(4)
VL_FIDCR(5)
VL_FIDCR(6)
VL_FIDCR(7)
// VL_FIDCR(8)
