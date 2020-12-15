#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector convert to fixed point intrinsic instructions
///
/// Note:
///   We test VCVT*vl, VCVT*vl_v, VCVT*vml_v, PVCVT*vl, PVCVT*vl_v, and
///   PVCVT*vml_v instructions.

#define VCVT_TEST_1(INST) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvl(__vr v) { \
  return _vel_ ## INST ## _vvl(v, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvl(__vr v, __vr b) { \
  return _vel_ ## INST ## _vvvl(v, b, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvmvl(__vr v, __vm256 m, __vr b) { \
  return _vel_ ## INST ## _vvmvl(v, m, b, 128); \
}

#define VCVT_TEST_2(INST) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvl(__vr v) { \
  return _vel_ ## INST ## _vvl(v, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvl(__vr v, __vr b) { \
  return _vel_ ## INST ## _vvvl(v, b, 128); \
}

#define PVCVT_TEST_1(INST) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvl(__vr v) { \
  return _vel_ ## INST ## _vvl(v, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvl(__vr v, __vr b) { \
  return _vel_ ## INST ## _vvvl(v, b, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvMvl(__vr v, __vm512 m, __vr b) { \
  return _vel_ ## INST ## _vvMvl(v, m, b, 128); \
}

#define PVCVT_TEST_2(INST) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvl(__vr v) { \
  return _vel_ ## INST ## _vvl(v, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvl(__vr v, __vr b) { \
  return _vel_ ## INST ## _vvvl(v, b, 128); \
}

VCVT_TEST_1(vcvtwdsx)
VCVT_TEST_1(vcvtwdsxrz)
VCVT_TEST_1(vcvtwdzx)
VCVT_TEST_1(vcvtwdzxrz)
VCVT_TEST_1(vcvtwssx)
VCVT_TEST_1(vcvtwssxrz)
VCVT_TEST_1(vcvtwszx)
VCVT_TEST_1(vcvtwszxrz)
VCVT_TEST_1(vcvtld)
VCVT_TEST_1(vcvtldrz)
VCVT_TEST_2(vcvtdw)
VCVT_TEST_2(vcvtsw)
VCVT_TEST_2(vcvtdl)
VCVT_TEST_2(vcvtds)
VCVT_TEST_2(vcvtsd)
PVCVT_TEST_1(pvcvtws)
PVCVT_TEST_1(pvcvtwsrz)
PVCVT_TEST_2(pvcvtsw)
