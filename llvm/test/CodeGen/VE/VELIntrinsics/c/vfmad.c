#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector floating fused multiply add intrinsic instructions
///
/// Note:
///   We test VFMAD*vvvl, VFMAD*vvvl_v, VFMAD*rvvl, VFMAD*rvvl_v, VFMAD*vrvl,
///   VFMAD*vrvl_v, VFMAD*vvvml_v, VFMAD*rvvml_v, VFMAD*vrvml_v, PVFMAD*vvvl,
///   PVFMAD*vvvl_v, PVFMAD*rvvl, PVFMAD*rvvl_v, PVFMAD*vrvl, PVFMAD*vrvl_v,
///   PVFMAD*vvvml_v, PVFMAD*rvvml_v, and PVFMAD*vrvml_v instructions.

#define VFMAD_TEST(INST, TYPE) \
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

#define PVFMAD_TEST(INST, TYPE) \
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

VFMAD_TEST(vfmadd, double)
VFMAD_TEST(vfmads, float)
PVFMAD_TEST(pvfmad, i64)
