#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector floating fused negative multiply add intrinsic instructions
///
/// Note:
///   We test VFNMAD*vvvl, VFNMAD*vvvl_v, VFNMAD*rvvl, VFNMAD*rvvl_v,
///   VFNMAD*vrvl, VFNMAD*vrvl_v, VFNMAD*vvvml_v, VFNMAD*rvvml_v,
///   VFNMAD*vrvml_v, PVFNMAD*vvvl, PVFNMAD*vvvl_v, PVFNMAD*rvvl,
///   PVFNMAD*rvvl_v, PVFNMAD*vrvl, PVFNMAD*vrvl_v, PVFNMAD*vvvml_v,
///   PVFNMAD*rvvml_v, and PVFNMAD*vrvml_v instructions.

#define VFNMAD_TEST(INST, TYPE) \
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

#define PVFNMAD_TEST(INST, TYPE) \
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

VFNMAD_TEST(vfnmadd, double)
VFNMAD_TEST(vfnmads, float)
PVFNMAD_TEST(pvfnmad, i64)
