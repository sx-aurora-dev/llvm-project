#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector floating square root intrinsic instructions
///
/// Note:
///   We test VFSQRT*vl and VFSQRT*vl_v instructions.

#define VFSQRT_TEST(INST) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvl(__vr l) { \
  return _vel_ ## INST ## _vvl(l, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvl(__vr l, __vr r) { \
  return _vel_ ## INST ## _vvvl(l, r, 256); \
}

VFSQRT_TEST(vfsqrtd)
VFSQRT_TEST(vfsqrts)
