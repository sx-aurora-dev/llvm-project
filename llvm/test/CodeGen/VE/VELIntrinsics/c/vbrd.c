#include "types.h"
#include "velintrin.h"

/// Test vector broadcast intrinsic instructions
///
/// Note:
///   We test VLD*rrl, VLD*irl, VLD*rrl_v, and VLD*irl_v instructions.

#define VBRD_TEST(INST, TY) \
void INST ## _vsl(TY val, i8 *p) { \
  __vr a = _vel_ ## INST ## _vsl(val, 256); \
  __asm volatile("vst %v0, 8, %1" :: "v"(a), "r"(p)); \
} \
void INST ## _vsvl(TY val, i8 *p) { \
  __vr a = _vel_vld_vssl(8, p, 256); \
  a = _vel_ ## INST ## _vsvl(val, a, 256); \
  _vel_vst_vssl(a, 8, p, 256); \
} \
void INST ## _vsmvl(TY val, i8 *p) { \
  __vr a = _vel_vld_vssl(8, p, 256); \
  __vm m; \
  m = _vel_lvm_mmss(m, 3, val); \
  a = _vel_ ## INST ## _vsmvl(val, m, a, 256); \
  _vel_vst_vssl(a, 8, p, 256); \
}
#define VBRDIMM_TEST(INST, TY) \
void INST ## _imm_vsl(TY val, i8 *p) { \
  __vr a = _vel_ ## INST ## _vsl(31, 256); \
  __asm volatile("vst %v0, 8, %1" :: "v"(a), "r"(p)); \
} \
void INST ## _imm_vsvl(TY val, i8 *p) { \
  __vr a = _vel_vld_vssl(8, p, 256); \
  a = _vel_ ## INST ## _vsvl(31, a, 256); \
  _vel_vst_vssl(a, 8, p, 256); \
} \
void INST ## _imm_vsmvl(TY val, i8 *p) { \
  __vr a = _vel_vld_vssl(8, p, 256); \
  __vm m; \
  m = _vel_lvm_mmss(m, 3, val); \
  a = _vel_ ## INST ## _vsmvl(31, m, a, 256); \
  _vel_vst_vssl(a, 8, p, 256); \
}
#define PVBRD_TEST(INST, TY) \
void INST ## _vsl(TY val, i8 *p) { \
  __vr a = _vel_ ## INST ## _vsl(val, 256); \
  __asm volatile("vst %v0, 8, %1" :: "v"(a), "r"(p)); \
} \
void INST ## _vsvl(TY val, i8 *p) { \
  __vr a = _vel_vld_vssl(8, p, 256); \
  a = _vel_ ## INST ## _vsvl(val, a, 256); \
  _vel_vst_vssl(a, 8, p, 256); \
} \
void INST ## _vsMvl(TY val, i8 *p) { \
  __vr a = _vel_vld_vssl(8, p, 256); \
  __vm512 m; \
  m = _vel_lvm_MMss(m, 1, val); \
  m = _vel_lvm_MMss(m, 6, val); \
  a = _vel_ ## INST ## _vsMvl(val, m, a, 256); \
  _vel_vst_vssl(a, 8, p, 256); \
}
#if 0
#define PVBRD_TEST(INST) \
void INST ## _vsl(i8 *p, i64 idx) { \
  __vr a = _vel_ ## INST ## _vssl(idx, p, 256); \
  __asm volatile("vst %v0, %2, %1" :: "v"(a), "r"(p), "r"(idx)); \
} \
void INST ## _vsvl(i8 *p, i64 idx, i8 *p2) { \
  __vr a = _vel_ ## INST ## _vssl(idx, p2, 256); \
  a = _vel_ ## INST ## _vssvl(idx, p, a, 256); \
  __asm volatile("vst %v0, %2, %1" :: "v"(a), "r"(p), "r"(idx)); \
} \
void INST ## _vsMvl(i8 *p, i64 idx, i8 *p2) { \
  __vr a = _vel_ ## INST ## _vssl(idx, p2, 256); \
  a = _vel_ ## INST ## _vssvl(idx, p, a, 256); \
  __asm volatile("vst %v0, %2, %1" :: "v"(a), "r"(p), "r"(idx)); \
}
#endif

VBRD_TEST(vbrdd, double)
VBRD_TEST(vbrdl, i64)
VBRDIMM_TEST(vbrdl, i64)
VBRD_TEST(vbrds, float)
VBRD_TEST(vbrdw, i32)
VBRDIMM_TEST(vbrdw, i32)
PVBRD_TEST(pvbrd, i64)
