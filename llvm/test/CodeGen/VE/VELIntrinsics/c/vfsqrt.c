#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector floating square root intrinsic instructions
///
/// Note:
///   We test VFSQRT*vl and VFSQRT*vl_v instructions.

#define VFSQRT_TEST(INST) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvl(__vr v) { \
  return _vel_ ## INST ## _vvl(v, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvl(__vr v, __vr b) { \
  return _vel_ ## INST ## _vvvl(v, b, 128); \
}

VFSQRT_TEST(vfsqrtd)
VFSQRT_TEST(vfsqrts)
