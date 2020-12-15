#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector floating sum intrinsic instructions
///
/// Note:
///   We test VFSUM*vl and VFSUM*vml instructions.

#define VFSUM_TEST(INST) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvl(__vr v) { \
  return _vel_ ## INST ## _vvl(v, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvml(__vr v, __vm256 m) { \
  return _vel_ ## INST ## _vvml(v, m, 256); \
}

VFSUM_TEST(vfsumd)
VFSUM_TEST(vfsums)
