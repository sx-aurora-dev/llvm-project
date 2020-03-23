; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=-packed | FileCheck %s


declare double @llvm.experimental.vector.reduce.v2.fadd.f64.v256f64(double %start_value, <256 x double> %a)

define double @vec_unordered_reduce_fadd_f64(<256 x double> %a, double %s) {
; CHECK-LABEL: vec_unordered_reduce_fadd_f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vfsum.d %v0,%v0,%vm0
; CHECK-NEXT:    lvs %s1,%v0(0)
; CHECK-NEXT:    fadd.d %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = call reassoc double @llvm.experimental.vector.reduce.v2.fadd.f64.v256f64(double %s, <256 x double> %a)
  ret double %r
}

define double @vec_ordered_reduce_fadd_f64(<256 x double> %a, double %s) {
; CHECK-LABEL: vec_ordered_reduce_fadd_f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vfia.d %v0,%v0,%s0
; CHECK-NEXT:    lvs %s0,%v0(0)
; CHECK-NEXT:    or %s11, 0, %s9
  %r = call double @llvm.experimental.vector.reduce.v2.fadd.f64.v256f64(double %s, <256 x double> %a)
  ret double %r
}

define double @vec_unordered_reduce_nostart_fadd_f64(<256 x double> %a) {
; CHECK-LABEL: vec_unordered_reduce_nostart_fadd_f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfsum.d %v0,%v0,%vm0
; CHECK-NEXT:    lvs %s0,%v0(0)
; CHECK:         or %s11, 0, %s9
  %r = call reassoc double @llvm.experimental.vector.reduce.v2.fadd.f64.v256f64(double 0.0, <256 x double> %a)
  ret double %r
}

define double @vec_ordered_reduce_nostart_fadd_f64(<256 x double> %a) {
; CHECK-LABEL: vec_ordered_reduce_nostart_fadd_f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lea.sl %s1, 0
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfia.d %v0,%v0,%s1
; CHECK-NEXT:    lvs %s0,%v0(0)
; CHECK-NEXT:    or %s11, 0, %s9
  %r = call double @llvm.experimental.vector.reduce.v2.fadd.f64.v256f64(double 0.0, <256 x double> %a)
  ret double %r
}


declare float @llvm.experimental.vector.reduce.v2.fadd.f32.v256f32(float %start_value, <256 x float> %a)

define float @vec_unordered_reduce_fadd_f32(<256 x float> %a, float %s) {
; CHECK-LABEL: vec_unordered_reduce_fadd_f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vfsum.s %v0,%v0,%vm0
; CHECK-NEXT:    lvs %s1,%v0(0)
; CHECK-NEXT:    fadd.s %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = call reassoc float @llvm.experimental.vector.reduce.v2.fadd.f32.v256f32(float %s, <256 x float> %a)
  ret float %r
}

define float @vec_ordered_reduce_fadd_f32(<256 x float> %a, float %s) {
; CHECK-LABEL: vec_ordered_reduce_fadd_f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vfia.s %v0,%v0,%s0
; CHECK-NEXT:    lvs %s0,%v0(0)
; CHECK-NEXT:    or %s11, 0, %s9
  %r = call float @llvm.experimental.vector.reduce.v2.fadd.f32.v256f32(float %s, <256 x float> %a)
  ret float %r
}

define float @vec_unordered_reduce_nostart_fadd_f32(<256 x float> %a) {
; CHECK-LABEL: vec_unordered_reduce_nostart_fadd_f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfsum.s %v0,%v0,%vm0
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    lvs %s1,%v0(0)
; CHECK-NEXT:    or %s0, 0, %s0
; CHECK-NEXT:    fadd.s %s0, %s1, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = call reassoc float @llvm.experimental.vector.reduce.v2.fadd.f32.v256f32(float 0.0, <256 x float> %a)
  ret float %r
}

define float @vec_ordered_reduce_nostart_fadd_f32(<256 x float> %a) {
; CHECK-LABEL: vec_ordered_reduce_nostart_fadd_f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    or %s0, 0, %s0
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vfia.s %v0,%v0,%s0
; CHECK-NEXT:    lvs %s0,%v0(0)
; CHECK-NEXT:    or %s11, 0, %s9
  %r = call float @llvm.experimental.vector.reduce.v2.fadd.f32.v256f32(float 0.0, <256 x float> %a)
  ret float %r
}
