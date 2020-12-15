#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector shift left arithmetic intrinsic instructions
///
/// Note:
///   We test VSLA*vvl, VSLA*vvl_v, VSLA*vrl, VSLA*vrl_v, VSLA*vil, VSLA*vil_v,
///   VSLA*vvml_v, VSLA*vrml_v, VSLA*viml_v, PVSLA*vvl, PVSLA*vvl_v, PVSLA*vrl,
///   PVSLA*vrl_v, PVSLA*vvml_v, and PVSLA*vrml_v instructions.

#define VSLA_TEST(INST, TYPE) \
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

#define PVSLA_TEST(INST, TYPE) \
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

VSLA_TEST(vslawsx, i32)
VSLA_TEST(vslawzx, i32)
VSLA_TEST(vslal, i64)
PVSLA_TEST(pvsla, i64)
