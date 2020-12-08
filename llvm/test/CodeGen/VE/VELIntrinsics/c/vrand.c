#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector reduction and intrinsic instructions
///
/// Note:
///   We test VRAND*vl and VRAND*vml instructions.

#define VRAND_TEST(INST) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvl(__vr v) { \
  return _vel_ ## INST ## _vvl(v, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvml(__vr v, __vm256 m) { \
  return _vel_ ## INST ## _vvml(v, m, 256); \
}

VRAND_TEST(vrand)
