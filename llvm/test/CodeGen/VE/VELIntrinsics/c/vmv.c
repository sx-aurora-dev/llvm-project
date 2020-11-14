#include "types.h"
#include "velintrin.h"

/// Test vector move intrinsic instructions
///
/// Note:
///   We test VMVivl and VMVivl_v, and VMVivml_v instructions.

void vmv_vsvl(i8 *p, i64 val, i32 idx) {
  __vr a = _vel_vld_vssl(8, p, 256);
  a = _vel_vmv_vsvl(31, a, 256);
  _vel_vst_vssl(a, 8, p, 256);
}

void vmv_vsvvl(i8 *p, i32 idx) {
  __vr a = _vel_vld_vssl(8, p, 256);
  a = _vel_vmv_vsvvl(31, a, a, 128);
  _vel_vst_vssl(a, 8, p, 256);
}

void vmv_vsvmvl(i8 *p, i32 idx) {
  __vr a = _vel_vld_vssl(8, p, 256);
  __vm m;
  a = _vel_vmv_vsvmvl(31, a, m, a, 128);
  _vel_vst_vssl(a, 8, p, 256);
}
