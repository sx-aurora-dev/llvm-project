#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test leading zero of vm intrinsic instructions
///
/// Note:
///   We test LZVM*ml instruction.

#define LZVM_TEST(INST) \
__attribute__ ((REGCALL)) \
i64 INST ## _sml(__vm256 m) { \
  return _vel_ ## INST ## _sml(m, 256); \
}

LZVM_TEST(lzvm)
