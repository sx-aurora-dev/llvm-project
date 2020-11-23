#include "types.h"
#include "velintrin.h"

/// Test vector store intrinsic instructions
///
/// Note:
///   We test VST*rrvl, VST*rrvml, VST*irvl, and VST*irvml instructions.

#define VS_TEST(INST) \
void INST ## _vssl(i8 *p, i64 idx) { \
  __vr a = _vel_vld_vssl(idx, p, 256); \
  _vel_ ## INST ## _vssl(a, idx, p, 256); \
} \
void INST ## _vssml(i8 *p, i64 idx) { \
  __vr a = _vel_vld_vssl(idx, p, 256); \
  __vm m; \
  _vel_ ## INST ## _vssml(a, idx, p, m, 256); \
} \
void INST ## _vssl_imm(i8 *p) { \
  __vr a = _vel_vld_vssl(8, p, 256); \
  _vel_ ## INST ## _vssl(a, 8, p, 256); \
} \
void INST ## _vssml_imm(i8 *p) { \
  __vr a = _vel_vld_vssl(8, p, 256); \
  __vm m; \
  _vel_ ## INST ## _vssml(a, 8, p, m, 256); \
}

VS_TEST(vst)
VS_TEST(vstnc)
VS_TEST(vstot)
VS_TEST(vstncot)
VS_TEST(vstu)
VS_TEST(vstunc)
VS_TEST(vstuot)
VS_TEST(vstuncot)
VS_TEST(vstl)
VS_TEST(vstlnc)
VS_TEST(vstlot)
VS_TEST(vstlncot)
VS_TEST(vst2d)
VS_TEST(vst2dnc)
VS_TEST(vst2dot)
VS_TEST(vst2dncot)
VS_TEST(vstu2d)
VS_TEST(vstu2dnc)
VS_TEST(vstu2dot)
VS_TEST(vstu2dncot)
VS_TEST(vstl2d)
VS_TEST(vstl2dnc)
VS_TEST(vstl2dot)
VS_TEST(vstl2dncot)
