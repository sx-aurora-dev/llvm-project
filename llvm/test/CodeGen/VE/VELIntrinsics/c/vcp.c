#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector compress intrinsic instructions
///
/// Note:
///   We test VCP*vml_v instruction.

#define VCP_TEST(INST) \
__attribute__ ((REGCALL)) \
__vr INST ## _vvmvl(__vr v, __vm256 m, __vr b) { \
  return _vel_ ## INST ## _vvmvl(v, m, b, 128); \
}

VCP_TEST(vcp)
