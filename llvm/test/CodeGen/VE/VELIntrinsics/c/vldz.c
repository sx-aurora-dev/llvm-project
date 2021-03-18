#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector leading zero count intrinsic instructions
///
/// Note:
///   We test VLDZ*vl, VLDZ*vl_v, VLDZ*vml_v, PVLDZ*vl, PVLDZ*vl_v, PVLDZ*vml_v instructions.

#define VLDZ_TEST(INST)  \
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

#define PVLDZ_TEST(INST) \
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

VLDZ_TEST(vldz)
VLDZ_TEST(pvldzlo)
VLDZ_TEST(pvldzup)
PVLDZ_TEST(pvldz)
