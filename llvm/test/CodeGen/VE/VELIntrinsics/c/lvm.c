#include "types.h"
#include "velintrin.h"

/// Test load/save vector mask intrinsic instructions
///
/// Note:
///   We test LVMir_m, LVMyir_y, SVMmi, and SVMyi instructions.

i64 lvm_mmss(i8 *p, i64 val) {
  __vr a;
  __vm m;
  m = _vel_lvm_mmss(m, 3, val);
  return _vel_svm_sms(m, 3);
}

i64 lvml_MMss(i8 *p, i64 val) {
  __vr a;
  __vm512 m;
  m = _vel_lvm_MMss(m, 5, val);
  return _vel_svm_sMs(m, 3) + _vel_svm_sMs(m, 6);
}
