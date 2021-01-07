#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test pack intrinsic instructions
///
/// Note:
///   We test pack_f32p and pack_f32a pseudo instruction.

#define PACK_TEST(INST) \
__attribute__ ((REGCALL)) \
i64 INST ## _f32p(float const *p0, float const *p1) { \
  return _vel_ ## INST ## _f32p(p0, p1); \
} \
__attribute__ ((REGCALL)) \
i64 INST ## _f32a(float const *p) { \
  return _vel_ ## INST ## _f32a(p); \
}

PACK_TEST(pack)
