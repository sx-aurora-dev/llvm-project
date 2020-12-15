#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector floating compare and select maximum intrinsic instructions
///
/// Note:
///   We test VFRMAX*vl and VFRMAX*vl_v instructions.

#define VFRMAX_TEST(INST) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvl(__vr v) { \
  return _vel_ ## INST ## _vvl(v, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvl(__vr v, __vr b) { \
  return _vel_ ## INST ## _vvvl(v, b, 128); \
}

VFRMAX_TEST(vfrmaxdfst)
VFRMAX_TEST(vfrmaxdlst)
VFRMAX_TEST(vfrmaxsfst)
VFRMAX_TEST(vfrmaxslst)
