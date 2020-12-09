#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test trailing one of vm intrinsic instructions
///
/// Note:
///   We test TOVM*ml instruction.

#define TOVM_TEST(INST) \
__attribute__ ((REGCALL)) \
i64 INST ## _sml(__vm256 m) { \
  return _vel_ ## INST ## _sml(m, 256); \
}

TOVM_TEST(tovm)
