#include "types.h"
#include "velintrin.h"

/// Test prefetch vector intrinsic instructions
///
/// Note:
///   We test LSVrr_v and LVSvr instructions.

void lsv_vvss(i8 *p, i64 val, i32 idx) {
  __vr a = _vel_vld_vssl(8, p, 256);
  a = _vel_lsv_vvss(a, idx, val);
  _vel_vst_vssl(a, 8, p, 256);
}

i64 lvsl_vssl_imm(i8 *p, i32 idx) {
  __vr a = _vel_vld_vssl(8, p, 256);
  return _vel_lvsl_svs(a, idx);
}

double lvsd_vssl_imm(i8 *p, i32 idx) {
  __vr a = _vel_vld_vssl(8, p, 256);
  return _vel_lvsd_svs(a, idx);
}

float lvss_vssl_imm(i8 *p, i32 idx) {
  __vr a = _vel_vld_vssl(8, p, 256);
  return _vel_lvss_svs(a, idx);
}
