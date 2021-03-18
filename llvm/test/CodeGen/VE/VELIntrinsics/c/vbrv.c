#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector bit reverse intrinsic instructions
///
/// Note:
///   We test VBRV*vl, VBRV*vl_v, VBRV*vml_v, PVBRV*vl, PVBRV*vl_v, PVBRV*vml_v instructions.

#define VBRV_TEST(INST)  \
__attribute__((REGCALL)) \
__vr INST##_vvl(__vr v) { \
  return _vel_##INST##_vvl(v, 256); \
} \
__attribute__((REGCALL)) \
__vr INST##_vvvl(__vr v, __vr b) { \
  return _vel_##INST##_vvvl(v, b, 128); \
} \
__attribute__((REGCALL)) \
__vr INST##_vvmvl(__vr v, __vm256 m, __vr b) { \
  return _vel_##INST##_vvmvl(v, m, b, 128); \
}

#define PVBRV_TEST(INST) \
__attribute__((REGCALL)) \
__vr INST##_vvl(__vr v) { \
  return _vel_##INST##_vvl(v, 256); \
} \
__attribute__((REGCALL)) \
__vr INST##_vvvl(__vr v, __vr b) { \
  return _vel_##INST##_vvvl(v, b, 128); \
} \
__attribute__((REGCALL)) \
__vr INST##_vvMvl(__vr v, __vm512 m, __vr b) { \
  return _vel_##INST##_vvMvl(v, m, b, 128); \
}

VBRV_TEST(vbrv)
VBRV_TEST(pvbrvlo)
VBRV_TEST(pvbrvup)
PVBRV_TEST(pvbrv)
