#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector floating reciprocal intrinsic instructions
///
/// Note:
///   We test VRCP*vl, VRCP*vl_v, PVRCP*vl, and PVRCP*vl_v instructions.

#define VRCP_TEST(INST) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvl(__vr v) { \
  return _vel_ ## INST ## _vvl(v, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvl(__vr v, __vr b) { \
  return _vel_ ## INST ## _vvvl(v, b, 128); \
}

#define PVRCP_TEST(INST) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvl(__vr v) { \
  return _vel_ ## INST ## _vvl(v, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvl(__vr v, __vr b) { \
  return _vel_ ## INST ## _vvvl(v, b, 128); \
}

VRCP_TEST(vrcpd)
VRCP_TEST(vrcps)
PVRCP_TEST(pvrcp)
