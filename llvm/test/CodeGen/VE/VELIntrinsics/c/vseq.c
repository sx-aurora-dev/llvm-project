#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector sequential number intrinsic instructions
///
/// Note:
///   We test VSEQ*l, VSEQ*l_v, PVSEQ*l, and PVSEQ*l_v instructions.

#define VSEQ_TEST(INST) \
__attribute__ ((REGCALL)) \
__vr INST ## _vl() { \
  return _vel_ ## INST ## _vl(256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvl(__vr l) { \
  return _vel_ ## INST ## _vvl(l, 256); \
}

#define PVSEQ_TEST(INST) \
__attribute__ ((REGCALL)) \
__vr INST ## _vl() { \
  return _vel_ ## INST ## _vl(256); \
} \
__attribute__ ((REGCALL)) \
__vr INST ## _vvl(__vr l) { \
  return _vel_ ## INST ## _vvl(l, 256); \
}

VSEQ_TEST(vseq)
PVSEQ_TEST(pvseqlo)
PVSEQ_TEST(pvsequp)
PVSEQ_TEST(pvseq)
