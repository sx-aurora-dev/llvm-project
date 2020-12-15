#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector floating compare intrinsic instructions
///
/// Note:
///   We test VFCMP*vvl, VFCMP*vvl_v, VFCMP*rvl, VFCMP*rvl_v, VFCMP*vvml_v,
///   VFCMP*rvml_v, PVFCMP*vvl, PVFCMP*vvl_v, PVFCMP*rvl, PVFCMP*rvl_v,
///   PVFCMP*vvml_v, and PVFCMP*rvml_v instructions.

#define VFCMP_TEST(INST, TYPE) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvl(__vr l, __vr r) { \
  return _vel_ ## INST ## _vvvl(l, r, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvvl(__vr l, __vr r, __vr b) { \
  return _vel_ ## INST ## _vvvvl(l, r, b, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vsvl(TYPE l, __vr r) { \
  return _vel_ ## INST ## _vsvl(l, r, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vsvvl(TYPE l, __vr r, __vr b) { \
  return _vel_ ## INST ## _vsvvl(l, r, b, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvmvl(__vr l, __vr r, __vm256 m, __vr b) { \
  return _vel_ ## INST ## _vvvmvl(l, r, m, b, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vsvmvl(TYPE l, __vr r, __vm256 m, __vr b) { \
  return _vel_ ## INST ## _vsvmvl(l, r, m, b, 128); \
}

#define PVFCMP_TEST(INST, TYPE) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvl(__vr l, __vr r) { \
  return _vel_ ## INST ## _vvvl(l, r, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvvl(__vr l, __vr r, __vr b) { \
  return _vel_ ## INST ## _vvvvl(l, r, b, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vsvl(TYPE l, __vr r) { \
  return _vel_ ## INST ## _vsvl(l, r, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vsvvl(TYPE l, __vr r, __vr b) { \
  return _vel_ ## INST ## _vsvvl(l, r, b, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvMvl(__vr l, __vr r, __vm512 m, __vr b) { \
  return _vel_ ## INST ## _vvvMvl(l, r, m, b, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vsvMvl(TYPE l, __vr r, __vm512 m, __vr b) { \
  return _vel_ ## INST ## _vsvMvl(l, r, m, b, 128); \
}

VFCMP_TEST(vfcmpd, double)
VFCMP_TEST(vfcmps, float)
PVFCMP_TEST(pvfcmp, i64)
