#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector shuffle intrinsic instructions
///
/// Note:
///   We test VSHF*vvrl, VSHF*vvrl_v, VSHF*vvil, and VSHF*vvil_v instructions.

#define VSHF_TEST(INST, TYPE) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvsl(__vr vy, __vr vz, TYPE sy) { \
  return _vel_ ## INST ## _vvvsl(vy, vz, sy, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvsvl(__vr vy, __vr vz, TYPE sy, __vr pt) { \
  return _vel_ ## INST ## _vvvsvl(vy, vz, sy, pt, 128); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvsl_imm(__vr vy, __vr vz) { \
  return _vel_ ## INST ## _vvvsl(vy, vz, 8, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvsvl_imm(__vr vy, __vr vz, __vr pt) { \
  return _vel_ ## INST ## _vvvsvl(vy, vz, 8, pt, 128); \
}

VSHF_TEST(vshf, i64)
