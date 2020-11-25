#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector subtract intrinsic instructions
///
/// Note:
///   We test VSUB*vvl, VSUB*vvl_v, VSUB*rvl, VSUB*rvl_v, VSUB*ivl, VSUB*ivl_v,
///   VSUB*vvml_v, VSUB*rvml_v, VSUB*ivml_v, PVSUB*vvl, PVSUB*vvl_v, PVSUB*rvl,
///   PVSUB*rvl_v, PVSUB*vvml_v, and PVSUB*rvml_v instructions.

#define VSUB_TEST(INST, TYPE) \
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

#define PVSUB_TEST(INST, TYPE) \
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

VSUB_TEST(vsubul, i64)
VSUB_TEST(vsubuw, i32)
VSUB_TEST(vsubswsx, i32)
VSUB_TEST(vsubswzx, i32)
VSUB_TEST(vsubsl, i64)
PVSUB_TEST(pvsubu, i64)
PVSUB_TEST(pvsubs, i64)
