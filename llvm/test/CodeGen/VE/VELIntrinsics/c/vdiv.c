#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector divide intrinsic instructions
///
/// Note:
///   We test VDIV*vvl, VDIV*vvl_v, VDIV*rvl, VDIV*rvl_v, VDIV*ivl,
///   VDIV*ivl_v, VDIV*vvml_v, VDIV*rvml_v, VDIV*ivml_v, VDIV*vrl,
///   VDIV*vrl_v, VDIV*vil, VDIV*vil_v, VDIV*vrml_v, and VDIV*viml_v
///   instructions.

#define VDIV_TEST(INST, TYPE) \
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
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvsl(__vr l, TYPE r) { \
  return _vel_ ## INST ## _vvsl(l, r, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvsvl(__vr l, TYPE r, __vr b) { \
  return _vel_ ## INST ## _vvsvl(l, r, b, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvsl_imm(__vr l) { \
  return _vel_ ## INST ## _vvsl(l, 8, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvsvl_imm(__vr l, __vr b) { \
  return _vel_ ## INST ## _vvsvl(l, 8, b, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvsmvl(__vr l, TYPE r, __vm256 m, __vr b) { \
  return _vel_ ## INST ## _vvsmvl(l, r, m, b, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvsmvl_imm(__vr l, __vm256 m, __vr b) { \
  return _vel_ ## INST ## _vvsmvl(l, 8, m, b, 128); \
}

VDIV_TEST(vdivul, i64)
VDIV_TEST(vdivuw, i32)
VDIV_TEST(vdivswsx, i32)
VDIV_TEST(vdivswzx, i32)
VDIV_TEST(vdivsl, i64)
