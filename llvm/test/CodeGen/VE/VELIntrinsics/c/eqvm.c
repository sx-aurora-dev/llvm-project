#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test equivalence vm intrinsic instructions
///
/// Note:
///   We test EQVM*mm and EQVM*yy instructions.

#define EQVM_TEST(INST) \
__attribute__ ((REGCALL)) \
__vm256 INST ## _mmm(__vm256 l, __vm256 r) { \
  return _vel_ ## INST ## _mmm(l, r); \
} \
__attribute__ ((REGCALL)) \
__vm512 INST ## _MMM(__vm512 l, __vm512 r) { \
  return _vel_ ## INST ## _MMM(l, r); \
}

EQVM_TEST(eqvm)
