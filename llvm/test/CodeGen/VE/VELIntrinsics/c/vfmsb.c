#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector floating fused multiply subtract intrinsic instructions
///
/// Note:
///   We test VFMSB*vvvl, VFMSB*vvvl_v, VFMSB*rvvl, VFMSB*rvvl_v, VFMSB*vrvl,
///   VFMSB*vrvl_v, VFMSB*vvvml_v, VFMSB*rvvml_v, VFMSB*vrvml_v, PVFMSB*vvvl,
///   PVFMSB*vvvl_v, PVFMSB*rvvl, PVFMSB*rvvl_v, PVFMSB*vrvl, PVFMSB*vrvl_v,
///   PVFMSB*vvvml_v, PVFMSB*rvvml_v, and PVFMSB*vrvml_v instructions.

#define VFMSB_TEST(INST, TYPE) \
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

#define PVFMSB_TEST(INST, TYPE) \
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

VFMSB_TEST(vfmsbd, double)
VFMSB_TEST(vfmsbs, float)
PVFMSB_TEST(pvfmsb, i64)
