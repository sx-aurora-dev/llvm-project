#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector shift left logical intrinsic instructions
///
/// Note:
///   We test VSLL*vvl, VSLL*vvl_v, VSLL*vrl, VSLL*vrl_v, VSLL*vil, VSLL*vil_v,
///   VSLL*vvml_v, VSLL*vrml_v, VSLL*viml_v, PVSLL*vvl, PVSLL*vvl_v, PVSLL*vrl,
///   PVSLL*vrl_v, PVSLL*vvml_v, and PVSLL*vrml_v instructions.

#define VSLL_TEST(INST, TYPE) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvl(__vr l, __vr r) { \
  return _vel_ ## INST ## _vvvl(l, r, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvvl(__vr l, __vr r, __vr b) { \
  return _vel_ ## INST ## _vvvvl(l, r, b, 128); \
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
__vr INST ## _vvvmvl(__vr l, __vr r, __vm256 m, __vr b) { \
  return _vel_ ## INST ## _vvvmvl(l, r, m, b, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvsmvl(__vr l, TYPE r, __vm256 m, __vr b) { \
  return _vel_ ## INST ## _vvsmvl(l, r, m, b, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvsmvl_imm(__vr l, __vm256 m, __vr b) { \
  return _vel_ ## INST ## _vvsmvl(l, 8, m, b, 128); \
}

#define PVSLL_TEST(INST, TYPE) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvl(__vr l, __vr r) { \
  return _vel_ ## INST ## _vvvl(l, r, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvvl(__vr l, __vr r, __vr b) { \
  return _vel_ ## INST ## _vvvvl(l, r, b, 128); \
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
__vr INST ## _vvvMvl(__vr l, __vr r, __vm512 m, __vr b) { \
  return _vel_ ## INST ## _vvvMvl(l, r, m, b, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvsMvl(__vr l, TYPE r, __vm512 m, __vr b) { \
  return _vel_ ## INST ## _vvsMvl(l, r, m, b, 128); \
}

VSLL_TEST(vsll, i64)
PVSLL_TEST(pvsll, i64)
