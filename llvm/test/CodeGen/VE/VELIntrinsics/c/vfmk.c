#include "types.h"
#include "velintrin.h"

#define REGCALL fastcall

/// Test vector form mask intrinsic instructions
///
/// Note:
///   We test VFMK*al, VFMK*nal, VFMK*vl, VFMK*vml, PVFMK*yal, PVFMK*ynal,
///   PVFMK*vl, PVFMK*vml, PVFMK*yvl, and PVFMK*yvyl instructions.

#define VFMKATAF_TEST(INST) \
__attribute__ ((REGCALL)) \
__vm256 INST ## at_ml() { \
  return _vel_ ## INST ## at_ml(256); \
} \
__attribute__ ((REGCALL)) \
__vm256 INST ## af_ml() { \
  return _vel_ ## INST ## af_ml(256); \
}

#define VFMK_TEST(INST, COND) \
__attribute__ ((REGCALL)) \
__vm256 INST ## COND ## _mvl(__vr v) { \
  return _vel_ ## INST ## COND ##_mvl(v, 256); \
} \
__attribute__ ((REGCALL)) \
__vm256 INST ## COND ## _mvml(__vr v, __vm256 m) { \
  return _vel_ ## INST ## COND ##_mvml(v, m, 256); \
}

#define VFMKCOND_TEST(INST) \
VFMK_TEST(INST, gt) \
VFMK_TEST(INST, lt) \
VFMK_TEST(INST, ne) \
VFMK_TEST(INST, eq) \
VFMK_TEST(INST, ge) \
VFMK_TEST(INST, le) \
VFMK_TEST(INST, num) \
VFMK_TEST(INST, nan) \
VFMK_TEST(INST, gtnan) \
VFMK_TEST(INST, ltnan) \
VFMK_TEST(INST, nenan) \
VFMK_TEST(INST, eqnan) \
VFMK_TEST(INST, genan) \
VFMK_TEST(INST, lenan)

#define VFMKATAF_TEST_M(INST) \
__attribute__ ((REGCALL)) \
__vm512 INST ## at_Ml() { \
  return _vel_ ## INST ## at_Ml(256); \
} \
__attribute__ ((REGCALL)) \
__vm512 INST ## af_Ml() { \
  return _vel_ ## INST ## af_Ml(256); \
}

#define VFMK_TEST_M(INST, COND) \
__attribute__ ((REGCALL)) \
__vm512 INST ## COND ## _Mvl(__vr v) { \
  return _vel_ ## INST ## COND ##_Mvl(v, 256); \
} \
__attribute__ ((REGCALL)) \
__vm512 INST ## COND ## _MvMl(__vr v, __vm512 m) { \
  return _vel_ ## INST ## COND ##_MvMl(v, m, 256); \
}

#define VFMKCOND_TEST_M(INST) \
VFMK_TEST_M(INST, gt) \
VFMK_TEST_M(INST, lt) \
VFMK_TEST_M(INST, ne) \
VFMK_TEST_M(INST, eq) \
VFMK_TEST_M(INST, ge) \
VFMK_TEST_M(INST, le) \
VFMK_TEST_M(INST, num) \
VFMK_TEST_M(INST, nan) \
VFMK_TEST_M(INST, gtnan) \
VFMK_TEST_M(INST, ltnan) \
VFMK_TEST_M(INST, nenan) \
VFMK_TEST_M(INST, eqnan) \
VFMK_TEST_M(INST, genan) \
VFMK_TEST_M(INST, lenan)

VFMKATAF_TEST(vfmkl)
VFMKCOND_TEST(vfmkl)
VFMKCOND_TEST(vfmkw)
VFMKCOND_TEST(vfmkd)
VFMKCOND_TEST(vfmks)

VFMKATAF_TEST_M(pvfmk)
VFMKCOND_TEST(pvfmkslo)
VFMKCOND_TEST(pvfmksup)
VFMKCOND_TEST(pvfmkwlo)
VFMKCOND_TEST(pvfmkwup)
VFMKCOND_TEST_M(pvfmks)
VFMKCOND_TEST_M(pvfmkw)
