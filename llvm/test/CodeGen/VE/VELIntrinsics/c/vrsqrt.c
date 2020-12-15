#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector floating reciprocal square root intrinsic instructions
///
/// Note:
///   We test VRSQRT*vl, VRSQRT*vl_v, PVRSQRT*vl, and PVRSQRT*vl_v
///   instructions.

#define VRSQRT_TEST(INST) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvl(__vr v) { \
  return _vel_ ## INST ## _vvl(v, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvl(__vr v, __vr b) { \
  return _vel_ ## INST ## _vvvl(v, b, 128); \
}

#define PVRSQRT_TEST(INST) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvl(__vr v) { \
  return _vel_ ## INST ## _vvl(v, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvvl(__vr v, __vr b) { \
  return _vel_ ## INST ## _vvvl(v, b, 128); \
}

VRSQRT_TEST(vrsqrtd)
VRSQRT_TEST(vrsqrts)
VRSQRT_TEST(vrsqrtdnex)
VRSQRT_TEST(vrsqrtsnex)
PVRSQRT_TEST(pvrsqrt)
PVRSQRT_TEST(pvrsqrtnex)
