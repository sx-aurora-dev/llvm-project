#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector gather intrinsic instructions
///
/// Note:
///   We test VGT*vrrl, VGT*vrrl_v, VGT*vrzl, VGT*vrzl_v, VGT*virl, VGT*virl_v,
///   VGT*vizl, VGT*vizl_v, VGT*vrrml, VGT*vrrml_v, VGT*vrzml, VGT*vrzml_v,
///   VGT*virml, VGT*virml_v, VGT*vizml, and VGT*vizml_v instructions.

#define VGT_TEST(INST, TYPE) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssl(__vr vy, TYPE sy, TYPE sz) { \
  return _vel_ ## INST ## _vvssl(vy, sy, sz, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssvl(__vr vy, TYPE sy, TYPE sz, __vr pt) { \
  return _vel_ ## INST ## _vvssvl(vy, sy, sz, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssl_imm_1(__vr vy, TYPE sy) { \
  return _vel_ ## INST ## _vvssl(vy, sy, 0, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssvl_imm_1(__vr vy, TYPE sy, __vr pt) { \
  return _vel_ ## INST ## _vvssvl(vy, sy, 0, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssl_imm_2(__vr vy, TYPE sz) { \
  return _vel_ ## INST ## _vvssl(vy, 8, sz, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssvl_imm_2(__vr vy, TYPE sz, __vr pt) { \
  return _vel_ ## INST ## _vvssvl(vy, 8, sz, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssl_imm_3(__vr vy) { \
  return _vel_ ## INST ## _vvssl(vy, 8, 0, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssvl_imm_3(__vr vy, __vr pt) { \
  return _vel_ ## INST ## _vvssvl(vy, 8, 0, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssml(__vr vy, TYPE sy, TYPE sz, __vm256 vm) { \
  return _vel_ ## INST ## _vvssml(vy, sy, sz, vm, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssmvl(__vr vy, TYPE sy, TYPE sz, __vm256 vm, __vr pt) { \
  return _vel_ ## INST ## _vvssmvl(vy, sy, sz, vm, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssml_imm_1(__vr vy, TYPE sy, __vm256 vm) { \
  return _vel_ ## INST ## _vvssml(vy, sy, 0, vm, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssmvl_imm_1(__vr vy, TYPE sy, __vm256 vm, __vr pt) { \
  return _vel_ ## INST ## _vvssmvl(vy, sy, 0, vm, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssml_imm_2(__vr vy, TYPE sz, __vm256 vm) { \
  return _vel_ ## INST ## _vvssml(vy, 8, sz, vm, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssmvl_imm_2(__vr vy, TYPE sz, __vm256 vm, __vr pt) { \
  return _vel_ ## INST ## _vvssmvl(vy, 8, sz, vm, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssml_imm_3(__vr vy, __vm256 vm) { \
  return _vel_ ## INST ## _vvssml(vy, 8, 0, vm, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssmvl_imm_3(__vr vy, __vm256 vm, __vr pt) { \
  return _vel_ ## INST ## _vvssmvl(vy, 8, 0, vm, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvssl_no_imm_1(__vr vy, TYPE sy) { \
  return _vel_ ## INST ## _vvssl(vy, sy, 8, 256); \
}

VGT_TEST(vgt, i64)
VGT_TEST(vgtnc, i64)
VGT_TEST(vgtu, i64)
VGT_TEST(vgtunc, i64)
VGT_TEST(vgtlsx, i64)
VGT_TEST(vgtlsxnc, i64)
VGT_TEST(vgtlzx, i64)
VGT_TEST(vgtlzxnc, i64)
