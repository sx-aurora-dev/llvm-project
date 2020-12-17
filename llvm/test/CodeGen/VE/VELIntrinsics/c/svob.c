#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test set vector out-of-order memory access boundary intrinsic instructions
///
/// Note:
///   We test SVOB instruction.

#define SVOB_TEST(INST) \
__attribute__ ((REGCALL)) \
void INST ## _svob() { \
  return _vel_ ## INST(); \
}

SVOB_TEST(svob)
