#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector register through function calls.
///
/// Note:
///   We test v1f32 to v8f32, and v1f64 to v8f64.

#define VFADD_TEST(INST, TYPE, LEN) \
typedef TYPE __vr ## TYPE ## LEN \
    __attribute__((__vector_size__(LEN * sizeof(TYPE)))); \
__attribute__ ((REGCALL)) \
__vr ## TYPE ## LEN  INST ## LEN (__vr ## TYPE ## LEN l, __vr ## TYPE ## LEN r) { \
  return l + r; \
}

VFADD_TEST(vfaddd, double, 1)
VFADD_TEST(vfadds, float, 1)
VFADD_TEST(vfaddd, double, 2)
VFADD_TEST(vfadds, float, 2)
VFADD_TEST(vfaddd, double, 3)
VFADD_TEST(vfadds, float, 3)
VFADD_TEST(vfaddd, double, 4)
VFADD_TEST(vfadds, float, 4)
VFADD_TEST(vfaddd, double, 5)
VFADD_TEST(vfadds, float, 5)
VFADD_TEST(vfaddd, double, 6)
VFADD_TEST(vfadds, float, 6)
VFADD_TEST(vfaddd, double, 7)
VFADD_TEST(vfadds, float, 7)
VFADD_TEST(vfaddd, double, 8)
VFADD_TEST(vfadds, float, 8)
