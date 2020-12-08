#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector floating compare and select minimum intrinsic instructions
///
/// Note:
///   We test VFRMIN*vl and VFRMIN*vl_v instructions.

#define VFRMIN_TEST(INST) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvl(__vr v) { \
  return _vel_ ## INST ## _vvl(v, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvl(__vr v, __vr b) { \
  return _vel_ ## INST ## _vvvl(v, b, 128); \
}

VFRMIN_TEST(vfrmindfst)
VFRMIN_TEST(vfrmindlst)
VFRMIN_TEST(vfrminsfst)
VFRMIN_TEST(vfrminslst)
