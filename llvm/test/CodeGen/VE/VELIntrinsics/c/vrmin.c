#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector minimum intrinsic instructions
///
/// Note:
///   We test VRMIN*vl and VRMIN*vl_v instructions.

#define VRMIN_TEST(INST) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvl(__vr v) { \
  return _vel_ ## INST ## _vvl(v, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvl(__vr v, __vr b) { \
  return _vel_ ## INST ## _vvvl(v, b, 128); \
}

VRMIN_TEST(vrminswfstsx)
VRMIN_TEST(vrminswlstsx)
VRMIN_TEST(vrminswfstzx)
VRMIN_TEST(vrminswlstzx)
VRMIN_TEST(vrminslfst)
VRMIN_TEST(vrminsllst)
