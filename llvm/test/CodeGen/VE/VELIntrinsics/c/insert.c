#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test insert intrinsic instructions
///
/// Note:
///   We test insert_vm512u and insert_vm512l pseudo instructions.

#define INSERT_TEST(INST) \
__attribute__ ((REGCALL)) \
__vm512 INST ## _vm512u(__vm512 l, __vm256 r) { \
  return _vel_ ## INST ## _vm512u(l, r); \
} \
__attribute__ ((REGCALL)) \
__vm512 INST ## _vm512l(__vm512 l, __vm256 r) { \
  return _vel_ ## INST ## _vm512l(l, r); \
}

INSERT_TEST(insert)
