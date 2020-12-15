#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test population count of vm intrinsic instructions
///
/// Note:
///   We test PCVM*ml instruction.

#define PCVM_TEST(INST) \
__attribute__ ((REGCALL)) \
i64 INST ## _sml(__vm256 m) { \
  return _vel_ ## INST ## _sml(m, 256); \
}

PCVM_TEST(pcvm)
