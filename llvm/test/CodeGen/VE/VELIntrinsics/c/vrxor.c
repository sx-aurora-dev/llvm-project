#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector reduction exclusive or intrinsic instructions
///
/// Note:
///   We test VRXOR*vl and VRXOR*vml instructions.

#define VRXOR_TEST(INST) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvl(__vr v) { \
  return _vel_ ## INST ## _vvl(v, 256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvml(__vr v, __vm256 m) { \
  return _vel_ ## INST ## _vvml(v, m, 256); \
}

VRXOR_TEST(vrxor)
