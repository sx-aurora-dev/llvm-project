#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test extract intrinsic instructions
///
/// Note:
///   We test extract_vm512u and extract_vm512l pseudo instructions.

#define EXTRACT_TEST(INST) \
__attribute__ ((REGCALL)) \
__vm256 INST ## _vm512u(__vm512 m) { \
  return _vel_ ## INST ## _vm512u(m); \
} \
__attribute__ ((REGCALL)) \
__vm256 INST ## _vm512l(__vm512 m) { \
  return _vel_ ## INST ## _vm512l(m); \
}

EXTRACT_TEST(extract)
