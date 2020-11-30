#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector compare intrinsic instructions
///
/// Note:
///   We test VCMP*vvl, VCMP*vvl_v, VCMP*rvl, VCMP*rvl_v, VCMP*ivl, VCMP*ivl_v,
///   VCMP*vvml_v, VCMP*rvml_v, VCMP*ivml_v, PVCMP*vvl, PVCMP*vvl_v, PVCMP*rvl,
///   PVCMP*rvl_v, PVCMP*vvml_v, and PVCMP*rvml_v instructions.

#define VCMP_TEST(INST, TYPE) \
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
__vr INST ## _vsvl_imm(__vr r) { \
  return _vel_ ## INST ## _vsvl(8, r, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vsvvl_imm(__vr r, __vr b) { \
  return _vel_ ## INST ## _vsvvl(8, r, b, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvmvl(__vr l, __vr r, __vm256 m, __vr b) { \
  return _vel_ ## INST ## _vvvmvl(l, r, m, b, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vsvmvl(TYPE l, __vr r, __vm256 m, __vr b) { \
  return _vel_ ## INST ## _vsvmvl(l, r, m, b, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vsvmvl_imm(__vr r, __vm256 m, __vr b) { \
  return _vel_ ## INST ## _vsvmvl(8, r, m, b, 128); \
}

#define PVCMP_TEST(INST, TYPE) \
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

VCMP_TEST(vcmpul, i64)
VCMP_TEST(vcmpuw, i32)
VCMP_TEST(vcmpswsx, i32)
VCMP_TEST(vcmpswzx, i32)
VCMP_TEST(vcmpsl, i64)
PVCMP_TEST(pvcmpu, i64)
PVCMP_TEST(pvcmps, i64)
