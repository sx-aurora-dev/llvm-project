; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: nounwind readnone
define float @func_fp_roundevenf_var_float(float %0) {
; CHECK-LABEL: func_fp_roundevenf_var_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    st %s9, (, %s11)
; CHECK-NEXT:    st %s10, 8(, %s11)
; CHECK-NEXT:    st %s15, 24(, %s11)
; CHECK-NEXT:    st %s16, 32(, %s11)
; CHECK-NEXT:    or %s9, 0, %s11
; CHECK-NEXT:    lea %s13, -240
; CHECK-NEXT:    and %s13, %s13, (32)0
; CHECK-NEXT:    lea.sl %s11, -1(%s13, %s11)
; CHECK-NEXT:    brge.l.t %s11, %s8, .LBB0_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    ld %s61, 24(, %s14)
; CHECK-NEXT:    or %s62, 0, %s0
; CHECK-NEXT:    lea %s63, 315
; CHECK-NEXT:    shm.l %s63, (%s61)
; CHECK-NEXT:    shm.l %s8, 8(%s61)
; CHECK-NEXT:    shm.l %s11, 16(%s61)
; CHECK-NEXT:    monc
; CHECK-NEXT:    or %s0, 0, %s62
; CHECK-NEXT:  .LBB0_2:
; CHECK-NEXT:    lea %s1, roundevenf@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, roundevenf@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
; CHECK-NEXT:    ld %s16, 32(, %s11)
; CHECK-NEXT:    ld %s15, 24(, %s11)
; CHECK-NEXT:    ld %s10, 8(, %s11)
; CHECK-NEXT:    ld %s9, (, %s11)
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = tail call float @llvm.roundeven.f32(float %0)
  ret float %2
}

; Function Attrs: nounwind readnone speculatable willreturn
declare float @llvm.roundeven.f32(float)

; Function Attrs: nounwind readnone
define { float, float } @func_fp_roundevenf_var_fcomp(float %0, float %1) {
; CHECK-LABEL: func_fp_roundevenf_var_fcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    st %s9, (, %s11)
; CHECK-NEXT:    st %s10, 8(, %s11)
; CHECK-NEXT:    st %s15, 24(, %s11)
; CHECK-NEXT:    st %s16, 32(, %s11)
; CHECK-NEXT:    or %s9, 0, %s11
; CHECK-NEXT:    lea %s13, -240
; CHECK-NEXT:    and %s13, %s13, (32)0
; CHECK-NEXT:    lea.sl %s11, -1(%s13, %s11)
; CHECK-NEXT:    brge.l.t %s11, %s8, .LBB1_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    ld %s61, 24(, %s14)
; CHECK-NEXT:    or %s62, 0, %s0
; CHECK-NEXT:    lea %s63, 315
; CHECK-NEXT:    shm.l %s63, (%s61)
; CHECK-NEXT:    shm.l %s8, 8(%s61)
; CHECK-NEXT:    shm.l %s11, 16(%s61)
; CHECK-NEXT:    monc
; CHECK-NEXT:    or %s0, 0, %s62
; CHECK-NEXT:  .LBB1_2:
; CHECK-NEXT:    lea %s1, roundevenf@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, roundevenf@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lea.sl %s1, 0
; CHECK-NEXT:    or %s11, 0, %s9
; CHECK-NEXT:    ld %s16, 32(, %s11)
; CHECK-NEXT:    ld %s15, 24(, %s11)
; CHECK-NEXT:    ld %s10, 8(, %s11)
; CHECK-NEXT:    ld %s9, (, %s11)
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call float @llvm.roundeven.f32(float %0)
  %4 = insertvalue { float, float } undef, float %3, 0
  %5 = insertvalue { float, float } %4, float 0.000000e+00, 1
  ret { float, float } %5
}

; Function Attrs: nounwind readnone
define double @func_fp_roundeven_var_double(double %0) {
; CHECK-LABEL: func_fp_roundeven_var_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    st %s9, (, %s11)
; CHECK-NEXT:    st %s10, 8(, %s11)
; CHECK-NEXT:    st %s15, 24(, %s11)
; CHECK-NEXT:    st %s16, 32(, %s11)
; CHECK-NEXT:    or %s9, 0, %s11
; CHECK-NEXT:    lea %s13, -240
; CHECK-NEXT:    and %s13, %s13, (32)0
; CHECK-NEXT:    lea.sl %s11, -1(%s13, %s11)
; CHECK-NEXT:    brge.l.t %s11, %s8, .LBB2_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    ld %s61, 24(, %s14)
; CHECK-NEXT:    or %s62, 0, %s0
; CHECK-NEXT:    lea %s63, 315
; CHECK-NEXT:    shm.l %s63, (%s61)
; CHECK-NEXT:    shm.l %s8, 8(%s61)
; CHECK-NEXT:    shm.l %s11, 16(%s61)
; CHECK-NEXT:    monc
; CHECK-NEXT:    or %s0, 0, %s62
; CHECK-NEXT:  .LBB2_2:
; CHECK-NEXT:    lea %s1, roundeven@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, roundeven@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
; CHECK-NEXT:    ld %s16, 32(, %s11)
; CHECK-NEXT:    ld %s15, 24(, %s11)
; CHECK-NEXT:    ld %s10, 8(, %s11)
; CHECK-NEXT:    ld %s9, (, %s11)
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = tail call double @llvm.roundeven.f64(double %0)
  ret double %2
}

; Function Attrs: nounwind readnone speculatable willreturn
declare double @llvm.roundeven.f64(double)

; Function Attrs: nounwind readnone
define { double, double } @func_fp_roundeven_var_dcomp(double %0, double %1) {
; CHECK-LABEL: func_fp_roundeven_var_dcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    st %s9, (, %s11)
; CHECK-NEXT:    st %s10, 8(, %s11)
; CHECK-NEXT:    st %s15, 24(, %s11)
; CHECK-NEXT:    st %s16, 32(, %s11)
; CHECK-NEXT:    or %s9, 0, %s11
; CHECK-NEXT:    lea %s13, -240
; CHECK-NEXT:    and %s13, %s13, (32)0
; CHECK-NEXT:    lea.sl %s11, -1(%s13, %s11)
; CHECK-NEXT:    brge.l.t %s11, %s8, .LBB3_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    ld %s61, 24(, %s14)
; CHECK-NEXT:    or %s62, 0, %s0
; CHECK-NEXT:    lea %s63, 315
; CHECK-NEXT:    shm.l %s63, (%s61)
; CHECK-NEXT:    shm.l %s8, 8(%s61)
; CHECK-NEXT:    shm.l %s11, 16(%s61)
; CHECK-NEXT:    monc
; CHECK-NEXT:    or %s0, 0, %s62
; CHECK-NEXT:  .LBB3_2:
; CHECK-NEXT:    lea %s1, roundeven@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, roundeven@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lea.sl %s1, 0
; CHECK-NEXT:    or %s11, 0, %s9
; CHECK-NEXT:    ld %s16, 32(, %s11)
; CHECK-NEXT:    ld %s15, 24(, %s11)
; CHECK-NEXT:    ld %s10, 8(, %s11)
; CHECK-NEXT:    ld %s9, (, %s11)
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call double @llvm.roundeven.f64(double %0)
  %4 = insertvalue { double, double } undef, double %3, 0
  %5 = insertvalue { double, double } %4, double 0.000000e+00, 1
  ret { double, double } %5
}

; Function Attrs: nounwind readnone
define fp128 @func_fp_roundevenl_var_quad(fp128 %0) {
; CHECK-LABEL: func_fp_roundevenl_var_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    st %s9, (, %s11)
; CHECK-NEXT:    st %s10, 8(, %s11)
; CHECK-NEXT:    st %s15, 24(, %s11)
; CHECK-NEXT:    st %s16, 32(, %s11)
; CHECK-NEXT:    or %s9, 0, %s11
; CHECK-NEXT:    lea %s13, -240
; CHECK-NEXT:    and %s13, %s13, (32)0
; CHECK-NEXT:    lea.sl %s11, -1(%s13, %s11)
; CHECK-NEXT:    brge.l.t %s11, %s8, .LBB4_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    ld %s61, 24(, %s14)
; CHECK-NEXT:    or %s62, 0, %s0
; CHECK-NEXT:    lea %s63, 315
; CHECK-NEXT:    shm.l %s63, (%s61)
; CHECK-NEXT:    shm.l %s8, 8(%s61)
; CHECK-NEXT:    shm.l %s11, 16(%s61)
; CHECK-NEXT:    monc
; CHECK-NEXT:    or %s0, 0, %s62
; CHECK-NEXT:  .LBB4_2:
; CHECK-NEXT:    lea %s2, roundevenl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, roundevenl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
; CHECK-NEXT:    ld %s16, 32(, %s11)
; CHECK-NEXT:    ld %s15, 24(, %s11)
; CHECK-NEXT:    ld %s10, 8(, %s11)
; CHECK-NEXT:    ld %s9, (, %s11)
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = tail call fp128 @llvm.roundeven.f128(fp128 %0)
  ret fp128 %2
}

; Function Attrs: nounwind readnone speculatable willreturn
declare fp128 @llvm.roundeven.f128(fp128)

; Function Attrs: nounwind readnone
define { fp128, fp128 } @func_fp_roundevenl_var_qcomp(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_fp_roundevenl_var_qcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    st %s9, (, %s11)
; CHECK-NEXT:    st %s10, 8(, %s11)
; CHECK-NEXT:    st %s15, 24(, %s11)
; CHECK-NEXT:    st %s16, 32(, %s11)
; CHECK-NEXT:    or %s9, 0, %s11
; CHECK-NEXT:    lea %s13, -240
; CHECK-NEXT:    and %s13, %s13, (32)0
; CHECK-NEXT:    lea.sl %s11, -1(%s13, %s11)
; CHECK-NEXT:    brge.l.t %s11, %s8, .LBB5_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    ld %s61, 24(, %s14)
; CHECK-NEXT:    or %s62, 0, %s0
; CHECK-NEXT:    lea %s63, 315
; CHECK-NEXT:    shm.l %s63, (%s61)
; CHECK-NEXT:    shm.l %s8, 8(%s61)
; CHECK-NEXT:    shm.l %s11, 16(%s61)
; CHECK-NEXT:    monc
; CHECK-NEXT:    or %s0, 0, %s62
; CHECK-NEXT:  .LBB5_2:
; CHECK-NEXT:    lea %s2, roundevenl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, roundevenl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lea %s2, .LCPI5_0@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI5_0@hi(, %s2)
; CHECK-NEXT:    ld %s2, 8(, %s4)
; CHECK-NEXT:    ld %s3, (, %s4)
; CHECK-NEXT:    or %s11, 0, %s9
; CHECK-NEXT:    ld %s16, 32(, %s11)
; CHECK-NEXT:    ld %s15, 24(, %s11)
; CHECK-NEXT:    ld %s10, 8(, %s11)
; CHECK-NEXT:    ld %s9, (, %s11)
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call fp128 @llvm.roundeven.f128(fp128 %0)
  %4 = insertvalue { fp128, fp128 } undef, fp128 %3, 0
  %5 = insertvalue { fp128, fp128 } %4, fp128 0xL00000000000000000000000000000000, 1
  ret { fp128, fp128 } %5
}

; Function Attrs: norecurse nounwind readnone
define float @func_fp_roundevenf_zero_float() {
; CHECK-LABEL: func_fp_roundevenf_zero_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    b.l.t (, %s10)
  ret float 0.000000e+00
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_fp_roundevenf_zero_fcomp() {
; CHECK-LABEL: func_fp_roundevenf_zero_fcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  ret { float, float } zeroinitializer
}

; Function Attrs: norecurse nounwind readnone
define double @func_fp_ROUND_zero_double() {
; CHECK-LABEL: func_fp_ROUND_zero_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    b.l.t (, %s10)
  ret double 0.000000e+00
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_fp_ROUND_zero_dcomp() {
; CHECK-LABEL: func_fp_ROUND_zero_dcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  ret { double, double } zeroinitializer
}

; Function Attrs: nounwind readnone
define fp128 @func_fp_roundevenl_zero_quad() {
; CHECK-LABEL: func_fp_roundevenl_zero_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    st %s9, (, %s11)
; CHECK-NEXT:    st %s10, 8(, %s11)
; CHECK-NEXT:    st %s15, 24(, %s11)
; CHECK-NEXT:    st %s16, 32(, %s11)
; CHECK-NEXT:    or %s9, 0, %s11
; CHECK-NEXT:    lea %s13, -240
; CHECK-NEXT:    and %s13, %s13, (32)0
; CHECK-NEXT:    lea.sl %s11, -1(%s13, %s11)
; CHECK-NEXT:    brge.l.t %s11, %s8, .LBB10_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    ld %s61, 24(, %s14)
; CHECK-NEXT:    or %s62, 0, %s0
; CHECK-NEXT:    lea %s63, 315
; CHECK-NEXT:    shm.l %s63, (%s61)
; CHECK-NEXT:    shm.l %s8, 8(%s61)
; CHECK-NEXT:    shm.l %s11, 16(%s61)
; CHECK-NEXT:    monc
; CHECK-NEXT:    or %s0, 0, %s62
; CHECK-NEXT:  .LBB10_2:
; CHECK-NEXT:    lea %s0, .LCPI10_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI10_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, roundevenl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, roundevenl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
; CHECK-NEXT:    ld %s16, 32(, %s11)
; CHECK-NEXT:    ld %s15, 24(, %s11)
; CHECK-NEXT:    ld %s10, 8(, %s11)
; CHECK-NEXT:    ld %s9, (, %s11)
; CHECK-NEXT:    b.l.t (, %s10)
  %1 = tail call fp128 @llvm.roundeven.f128(fp128 0xL00000000000000000000000000000000)
  ret fp128 %1
}

; Function Attrs: nounwind readnone
define { fp128, fp128 } @func_fp_roundevenl_zero_qcomp() {
; CHECK-LABEL: func_fp_roundevenl_zero_qcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    st %s9, (, %s11)
; CHECK-NEXT:    st %s10, 8(, %s11)
; CHECK-NEXT:    st %s15, 24(, %s11)
; CHECK-NEXT:    st %s16, 32(, %s11)
; CHECK-NEXT:    or %s9, 0, %s11
; CHECK-NEXT:    lea %s13, -240
; CHECK-NEXT:    and %s13, %s13, (32)0
; CHECK-NEXT:    lea.sl %s11, -1(%s13, %s11)
; CHECK-NEXT:    brge.l.t %s11, %s8, .LBB11_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    ld %s61, 24(, %s14)
; CHECK-NEXT:    or %s62, 0, %s0
; CHECK-NEXT:    lea %s63, 315
; CHECK-NEXT:    shm.l %s63, (%s61)
; CHECK-NEXT:    shm.l %s8, 8(%s61)
; CHECK-NEXT:    shm.l %s11, 16(%s61)
; CHECK-NEXT:    monc
; CHECK-NEXT:    or %s0, 0, %s62
; CHECK-NEXT:  .LBB11_2:
; CHECK-NEXT:    st %s18, 48(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    st %s19, 56(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    lea %s0, .LCPI11_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, .LCPI11_0@hi(, %s0)
; CHECK-NEXT:    ld %s18, 8(, %s0)
; CHECK-NEXT:    ld %s19, (, %s0)
; CHECK-NEXT:    lea %s0, roundevenl@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, roundevenl@hi(, %s0)
; CHECK-NEXT:    or %s0, 0, %s18
; CHECK-NEXT:    or %s1, 0, %s19
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s2, 0, %s18
; CHECK-NEXT:    or %s3, 0, %s19
; CHECK-NEXT:    ld %s19, 56(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    ld %s18, 48(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    or %s11, 0, %s9
; CHECK-NEXT:    ld %s16, 32(, %s11)
; CHECK-NEXT:    ld %s15, 24(, %s11)
; CHECK-NEXT:    ld %s10, 8(, %s11)
; CHECK-NEXT:    ld %s9, (, %s11)
; CHECK-NEXT:    b.l.t (, %s10)
  %1 = tail call fp128 @llvm.roundeven.f128(fp128 0xL00000000000000000000000000000000)
  %2 = insertvalue { fp128, fp128 } undef, fp128 %1, 0
  %3 = insertvalue { fp128, fp128 } %2, fp128 0xL00000000000000000000000000000000, 1
  ret { fp128, fp128 } %3
}

; Function Attrs: norecurse nounwind readnone
define float @func_fp_roundevenf_const_float() {
; CHECK-LABEL: func_fp_roundevenf_const_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    b.l.t (, %s10)
  ret float -2.000000e+00
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_fp_roundevenf_const_fcomp() {
; CHECK-LABEL: func_fp_roundevenf_const_fcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    lea.sl %s1, 0
; CHECK-NEXT:    b.l.t (, %s10)
  ret { float, float } { float -2.000000e+00, float 0.000000e+00 }
}

; Function Attrs: norecurse nounwind readnone
define double @func_fp_roundeven_const_double() {
; CHECK-LABEL: func_fp_roundeven_const_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    b.l.t (, %s10)
  ret double -2.000000e+00
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_fp_roundeven_const_dcomp() {
; CHECK-LABEL: func_fp_roundeven_const_dcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    lea.sl %s1, 0
; CHECK-NEXT:    b.l.t (, %s10)
  ret { double, double } { double -2.000000e+00, double 0.000000e+00 }
}

; Function Attrs: nounwind readnone
define fp128 @func_fp_roundevenl_const_quad() {
; CHECK-LABEL: func_fp_roundevenl_const_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    st %s9, (, %s11)
; CHECK-NEXT:    st %s10, 8(, %s11)
; CHECK-NEXT:    st %s15, 24(, %s11)
; CHECK-NEXT:    st %s16, 32(, %s11)
; CHECK-NEXT:    or %s9, 0, %s11
; CHECK-NEXT:    lea %s13, -240
; CHECK-NEXT:    and %s13, %s13, (32)0
; CHECK-NEXT:    lea.sl %s11, -1(%s13, %s11)
; CHECK-NEXT:    brge.l.t %s11, %s8, .LBB16_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    ld %s61, 24(, %s14)
; CHECK-NEXT:    or %s62, 0, %s0
; CHECK-NEXT:    lea %s63, 315
; CHECK-NEXT:    shm.l %s63, (%s61)
; CHECK-NEXT:    shm.l %s8, 8(%s61)
; CHECK-NEXT:    shm.l %s11, 16(%s61)
; CHECK-NEXT:    monc
; CHECK-NEXT:    or %s0, 0, %s62
; CHECK-NEXT:  .LBB16_2:
; CHECK-NEXT:    lea %s0, .LCPI16_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI16_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, roundevenl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, roundevenl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
; CHECK-NEXT:    ld %s16, 32(, %s11)
; CHECK-NEXT:    ld %s15, 24(, %s11)
; CHECK-NEXT:    ld %s10, 8(, %s11)
; CHECK-NEXT:    ld %s9, (, %s11)
; CHECK-NEXT:    b.l.t (, %s10)
  %1 = tail call fp128 @llvm.roundeven.f128(fp128 0xL0000000000000000C000000000000000)
  ret fp128 %1
}

; Function Attrs: nounwind readnone
define { fp128, fp128 } @func_fp_roundevenl_const_qcomp() {
; CHECK-LABEL: func_fp_roundevenl_const_qcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    st %s9, (, %s11)
; CHECK-NEXT:    st %s10, 8(, %s11)
; CHECK-NEXT:    st %s15, 24(, %s11)
; CHECK-NEXT:    st %s16, 32(, %s11)
; CHECK-NEXT:    or %s9, 0, %s11
; CHECK-NEXT:    lea %s13, -240
; CHECK-NEXT:    and %s13, %s13, (32)0
; CHECK-NEXT:    lea.sl %s11, -1(%s13, %s11)
; CHECK-NEXT:    brge.l.t %s11, %s8, .LBB17_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    ld %s61, 24(, %s14)
; CHECK-NEXT:    or %s62, 0, %s0
; CHECK-NEXT:    lea %s63, 315
; CHECK-NEXT:    shm.l %s63, (%s61)
; CHECK-NEXT:    shm.l %s8, 8(%s61)
; CHECK-NEXT:    shm.l %s11, 16(%s61)
; CHECK-NEXT:    monc
; CHECK-NEXT:    or %s0, 0, %s62
; CHECK-NEXT:  .LBB17_2:
; CHECK-NEXT:    lea %s0, .LCPI17_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI17_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, roundevenl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, roundevenl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lea %s2, .LCPI17_1@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI17_1@hi(, %s2)
; CHECK-NEXT:    ld %s2, 8(, %s4)
; CHECK-NEXT:    ld %s3, (, %s4)
; CHECK-NEXT:    or %s11, 0, %s9
; CHECK-NEXT:    ld %s16, 32(, %s11)
; CHECK-NEXT:    ld %s15, 24(, %s11)
; CHECK-NEXT:    ld %s10, 8(, %s11)
; CHECK-NEXT:    ld %s9, (, %s11)
; CHECK-NEXT:    b.l.t (, %s10)
  %1 = tail call fp128 @llvm.roundeven.f128(fp128 0xL0000000000000000C000000000000000)
  %2 = insertvalue { fp128, fp128 } undef, fp128 %1, 0
  %3 = insertvalue { fp128, fp128 } %2, fp128 0xL00000000000000000000000000000000, 1
  ret { fp128, fp128 } %3
}
