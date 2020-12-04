#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector floating fused negative multiply subtract intrinsic instructions
///
/// Note:
///   We test VFNMSB*vvvl, VFNMSB*vvvl_v, VFNMSB*rvvl, VFNMSB*rvvl_v,
///   VFNMSB*vrvl, VFNMSB*vrvl_v, VFNMSB*vvvml_v, VFNMSB*rvvml_v,
///   VFNMSB*vrvml_v, PVFNMSB*vvvl, PVFNMSB*vvvl_v, PVFNMSB*rvvl,
///   PVFNMSB*rvvl_v, PVFNMSB*vrvl, PVFNMSB*vrvl_v, PVFNMSB*vvvml_v,
///   PVFNMSB*rvvml_v, and PVFNMSB*vrvml_v instructions.

#define VFNMSB_TEST(INST, TYPE) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvvl(__vr vy, __vr vz, __vr vw) { \
  return _vel_ ## INST ## _vvvvl(vy, vz, vw, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvvvl(__vr vy, __vr vz, __vr vw, __vr pt) { \
  return _vel_ ## INST ## _vvvvvl(vy, vz, vw, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vsvvl(TYPE sy, __vr vz, __vr vw) { \
  return _vel_ ## INST ## _vsvvl(sy, vz, vw, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vsvvvl(TYPE sy, __vr vz, __vr vw, __vr pt) { \
  return _vel_ ## INST ## _vsvvvl(sy, vz, vw, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvsvl(__vr vy, TYPE sy, __vr vw) { \
  return _vel_ ## INST ## _vvsvl(vy, sy, vw, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvsvvl(__vr vy, TYPE sy, __vr vw, __vr pt) { \
  return _vel_ ## INST ## _vvsvvl(vy, sy, vw, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvvmvl(__vr vy, __vr vz, __vr vw, __vm256 vm, __vr pt) { \
  return _vel_ ## INST ## _vvvvmvl(vy, vz, vw, vm, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vsvvmvl(TYPE sy, __vr vz, __vr vw, __vm256 vm, __vr pt) { \
  return _vel_ ## INST ## _vsvvmvl(sy, vz, vw, vm, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvsvmvl(__vr vy, TYPE sy, __vr vw, __vm256 vm, __vr pt) { \
  return _vel_ ## INST ## _vvsvmvl(vy, sy, vw, vm, pt, 128); \
}

#define PVFNMSB_TEST(INST, TYPE) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvvl(__vr vy, __vr vz, __vr vw) { \
  return _vel_ ## INST ## _vvvvl(vy, vz, vw, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvvvl(__vr vy, __vr vz, __vr vw, __vr pt) { \
  return _vel_ ## INST ## _vvvvvl(vy, vz, vw, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vsvvl(TYPE sy, __vr vz, __vr vw) { \
  return _vel_ ## INST ## _vsvvl(sy, vz, vw, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vsvvvl(TYPE sy, __vr vz, __vr vw, __vr pt) { \
  return _vel_ ## INST ## _vsvvvl(sy, vz, vw, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvsvl(__vr vy, TYPE sy, __vr vw) { \
  return _vel_ ## INST ## _vvsvl(vy, sy, vw, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvsvvl(__vr vy, TYPE sy, __vr vw, __vr pt) { \
  return _vel_ ## INST ## _vvsvvl(vy, sy, vw, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvvMvl(__vr vy, __vr vz, __vr vw, __vm512 vm, __vr pt) { \
  return _vel_ ## INST ## _vvvvMvl(vy, vz, vw, vm, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vsvvMvl(TYPE sy, __vr vz, __vr vw, __vm512 vm, __vr pt) { \
  return _vel_ ## INST ## _vsvvMvl(sy, vz, vw, vm, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvsvMvl(__vr vy, TYPE sy, __vr vw, __vm512 vm, __vr pt) { \
  return _vel_ ## INST ## _vvsvMvl(vy, sy, vw, vm, pt, 128); \
}

VFNMSB_TEST(vfnmsbd, double)
VFNMSB_TEST(vfnmsbs, float)
PVFNMSB_TEST(pvfnmsb, i64)
