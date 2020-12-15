#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector scatter intrinsic instructions
///
/// Note:
///   We test VSC*vrrvl, VSC*vrzvl, VSC*virvl, VSC*vizvl, VSC*vrrvml,
///   VSC*vrzvml, VSC*virvml, and VSC*vizvml instructions.

#define VSC_TEST(INST, TYPE) \
__attribute__ ((REGCALL)) \
void INST ## _vvssl(__vr vx, __vr vy, TYPE sy, TYPE sz) { \
  return _vel_ ## INST ## _vvssl(vx, vy, sy, sz, 256); \
} \
__attribute__ ((REGCALL)) \
void INST ## _vvssl_imm_1(__vr vx, __vr vy, TYPE sy) { \
  return _vel_ ## INST ## _vvssl(vx, vy, sy, 0, 256); \
} \
__attribute__ ((REGCALL)) \
void INST ## _vvssl_imm_2(__vr vx, __vr vy, TYPE sz) { \
  return _vel_ ## INST ## _vvssl(vx, vy, 8, sz, 256); \
} \
__attribute__ ((REGCALL)) \
void INST ## _vvssl_imm_3(__vr vx, __vr vy) { \
  return _vel_ ## INST ## _vvssl(vx, vy, 8, 0, 256); \
} \
__attribute__ ((REGCALL)) \
void INST ## _vvssml(__vr vx, __vr vy, TYPE sy, TYPE sz, __vm256 vm) { \
  return _vel_ ## INST ## _vvssml(vx, vy, sy, sz, vm, 256); \
} \
__attribute__ ((REGCALL)) \
void INST ## _vvssml_imm_1(__vr vx, __vr vy, TYPE sy, __vm256 vm) { \
  return _vel_ ## INST ## _vvssml(vx, vy, sy, 0, vm, 256); \
} \
__attribute__ ((REGCALL)) \
void INST ## _vvssml_imm_2(__vr vx, __vr vy, TYPE sz, __vm256 vm) { \
  return _vel_ ## INST ## _vvssml(vx, vy, 8, sz, vm, 256); \
} \
__attribute__ ((REGCALL)) \
void INST ## _vvssml_imm_3(__vr vx, __vr vy, __vm256 vm) { \
  return _vel_ ## INST ## _vvssml(vx, vy, 8, 0, vm, 256); \
} \
__attribute__ ((REGCALL)) \
void INST ## _vvssl_no_imm_1(__vr vx, __vr vy, TYPE sy) { \
  return _vel_ ## INST ## _vvssl(vx, vy, sy, 8, 256); \
}

VSC_TEST(vsc, i64)
VSC_TEST(vscnc, i64)
VSC_TEST(vscot, i64)
VSC_TEST(vscncot, i64)
VSC_TEST(vscu, i64)
VSC_TEST(vscunc, i64)
VSC_TEST(vscuot, i64)
VSC_TEST(vscuncot, i64)
VSC_TEST(vscl, i64)
VSC_TEST(vsclnc, i64)
VSC_TEST(vsclot, i64)
VSC_TEST(vsclncot, i64)
