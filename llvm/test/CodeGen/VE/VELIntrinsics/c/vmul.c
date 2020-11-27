#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector multiply intrinsic instructions
///
/// Note:
///   We test VMUL*vvl, VMUL*vvl_v, VMUL*rvl, VMUL*rvl_v, VMUL*ivl, VMUL*ivl_v,
///   VMUL*vvml_v, VMUL*rvml_v, and VMUL*ivml_v instructions.

#define VMUL_TEST(INST, TYPE) \
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

#define VMUL_TEST_SLW(INST, TYPE) \
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
}

VMUL_TEST(vmulul, i64)
VMUL_TEST(vmuluw, i32)
VMUL_TEST(vmulswsx, i32)
VMUL_TEST(vmulswzx, i32)
VMUL_TEST(vmulsl, i64)
VMUL_TEST_SLW(vmulslw, i32)
