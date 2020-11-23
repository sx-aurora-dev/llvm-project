#include "types.h"
#include "velintrin.h"

/// Test vector load intrinsic instructions
///
/// Note:
///   We test VLD*rrl, VLD*irl, VLD*rrl_v, and VLD*irl_v instructions.

#define VL_REL(INST) \
void INST ## _vssl(i8 *p, i64 idx) { \
  __vr a = _vel_ ## INST ## _vssl(idx, p, 256); \
  __asm volatile("vst %v0, %2, %1" :: "v"(a), "r"(p), "r"(idx)); \
} \
void INST ## _vssvl(i8 *p, i64 idx, i8 *p2) { \
  __vr a = _vel_ ## INST ## _vssl(idx, p2, 256); \
  a = _vel_ ## INST ## _vssvl(idx, p, a, 256); \
  __asm volatile("vst %v0, %2, %1" :: "v"(a), "r"(p), "r"(idx)); \
} \
void INST ## _vssl_imm(i8 *p) { \
  __vr a = _vel_ ## INST ## _vssl(8, p, 256); \
  __asm volatile("vst %v0, 8, %1" :: "v"(a), "r"(p)); \
} \
void INST ## _vssvl_imm(i8 *p, i8 *p2) { \
  __vr a = _vel_ ## INST ## _vssl(8, p2, 256); \
  a = _vel_ ## INST ## _vssvl(8, p, a, 256); \
  __asm volatile("vst %v0, 8, %1" :: "v"(a), "r"(p)); \
}

VL_REL(vld)
VL_REL(vldnc)
VL_REL(vldu)
VL_REL(vldunc)
VL_REL(vldlsx)
VL_REL(vldlsxnc)
VL_REL(vldlzx)
VL_REL(vldlzxnc)
VL_REL(vld2d)
VL_REL(vld2dnc)
VL_REL(vldu2d)
VL_REL(vldu2dnc)
VL_REL(vldl2dsx)
VL_REL(vldl2dsxnc)
VL_REL(vldl2dzx)
VL_REL(vldl2dzxnc)
