#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector maximum intrinsic instructions
///
/// Note:
///   We test VRMAX*vl and VRMAX*vl_v instructions.

#define VRMAX_TEST(INST) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvl(__vr v) { \
  return _vel_ ## INST ## _vvl(v, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvl(__vr v, __vr b) { \
  return _vel_ ## INST ## _vvvl(v, b, 128); \
}

VRMAX_TEST(vrmaxswfstsx)
VRMAX_TEST(vrmaxswlstsx)
VRMAX_TEST(vrmaxswfstzx)
VRMAX_TEST(vrmaxswlstzx)
VRMAX_TEST(vrmaxslfst)
VRMAX_TEST(vrmaxsllst)
