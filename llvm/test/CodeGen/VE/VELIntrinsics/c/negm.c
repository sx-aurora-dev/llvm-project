#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test negate vm intrinsic instructions
///
/// Note:
///   We test NEGM*m and NEGM*y instructions.

#define NEGM_TEST(INST) \
__attribute__ ((REGCALL)) \
__vm256 INST ## _mm(__vm256 m) { \
  return _vel_ ## INST ## _mm(m); \
} \
__attribute__ ((REGCALL)) \
__vm512 INST ## _MM(__vm512 m) { \
  return _vel_ ## INST ## _MM(m); \
}

NEGM_TEST(negm)
