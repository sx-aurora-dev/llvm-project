#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector merge intrinsic instructions
///
/// Note:
///   We test VMRG*vvml, VMRG*vvml_v, VMRG*rvml, VMRG*rvml_v, VMRG*ivml, and
///   VMRG*ivml_v instructions.

#define VMRG_TEST_1(INST, TYPE) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvml(__vr l, __vr r, __vm256 m) { \
  return _vel_ ## INST ## _vvvml(l, r, m, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvmvl(__vr l, __vr r, __vm256 m, __vr b) { \
  return _vel_ ## INST ## _vvvmvl(l, r, m, b, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vsvml(TYPE l, __vr r, __vm256 m) { \
  return _vel_ ## INST ## _vsvml(l, r, m, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vsvmvl(TYPE l, __vr r, __vm256 m, __vr b) { \
  return _vel_ ## INST ## _vsvmvl(l, r, m, b, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vsvml_imm(__vr r, __vm256 m) { \
  return _vel_ ## INST ## _vsvml(8, r, m, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vsvmvl_imm(__vr r, __vm256 m, __vr b) { \
  return _vel_ ## INST ## _vsvmvl(8, r, m, b, 128); \
}

#define VMRG_TEST_2(INST, TYPE) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvMl(__vr l, __vr r, __vm512 m) { \
  return _vel_ ## INST ## _vvvMl(l, r, m, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvMvl(__vr l, __vr r, __vm512 m, __vr b) { \
  return _vel_ ## INST ## _vvvMvl(l, r, m, b, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vsvMl(TYPE sy, __vr vz, __vm512 vm) { \
  return _vel_ ## INST ## _vsvMl(sy, vz, vm, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vsvMvl(TYPE sy, __vr vz, __vm512 vm, __vr pt) { \
  return _vel_ ## INST ## _vsvMvl(sy, vz, vm, pt, 128); \
}

VMRG_TEST_1(vmrg, i64)
VMRG_TEST_2(vmrgw, i32)
