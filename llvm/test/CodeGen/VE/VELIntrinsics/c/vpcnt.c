#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector population count intrinsic instructions
///
/// Note:
///   We test VPCNT*vl, VPCNT*vl_v, VPCNT*vml_v, PVPCNT*vl, PVPCNT*vl_v, PVPCNT*vml_v instructions.

#define VPCNT_TEST(INST)  \
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

#define PVPCNT_TEST(INST) \
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

VPCNT_TEST(vpcnt)
VPCNT_TEST(pvpcntlo)
VPCNT_TEST(pvpcntup)
PVPCNT_TEST(pvpcnt)
