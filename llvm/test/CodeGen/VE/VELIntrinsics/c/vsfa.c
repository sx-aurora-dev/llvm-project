#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector shift left and add intrinsic instructions
///
/// Note:
///   We test VSFA*vrrl, VSFA*vrrl_v, VSFA*virl, VSFA*virl_v, VSFA*vrrml_v, and
///   VSFA*virml_v instructions.

#define VSFA_TEST(INST, TYPE) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssl(__vr vz, TYPE sy, TYPE sz) { \
  return _vel_ ## INST ## _vvssl(vz, sy, sz, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssvl(__vr vz, TYPE sy, TYPE sz, __vr pt) { \
  return _vel_ ## INST ## _vvssvl(vz, sy, sz, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssl_imm(__vr vz, TYPE sz) { \
  return _vel_ ## INST ## _vvssl(vz, 8, sz, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssvl_imm(__vr vz, TYPE sz, __vr pt) { \
  return _vel_ ## INST ## _vvssvl(vz, 8, sz, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssmvl(__vr vz, TYPE sy, TYPE sz, __vm256 vm, __vr pt) { \
  return _vel_ ## INST ## _vvssmvl(vz, sy, sz, vm, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssmvl_imm(__vr vz, TYPE sz, __vm256 vm, __vr pt) { \
  return _vel_ ## INST ## _vvssmvl(vz, 8, sz, vm, pt, 128); \
}

VSFA_TEST(vsfa, i64)
