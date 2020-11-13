#include "types.h"
#include "velintrin.h"

/// Test prefetch vector intrinsic instructions
///
/// Note:
///   We test PFCHVrrl, PFCHVirl, PFCHVNCrrl, and PFCHVNCirl instructions.

#define PF_TEST(INST) \
void INST ## _vssl(i8 *p, i64 idx) { \
  _vel_ ## INST ## _ssl(idx, p, 256); \
} \
void INST ## _vssl_imm(i8 *p) { \
  _vel_ ## INST ## _ssl(8, p, 256); \
}

PF_TEST(pfchv)
PF_TEST(pfchvnc)
