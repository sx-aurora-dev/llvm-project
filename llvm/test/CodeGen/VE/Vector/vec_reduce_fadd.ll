; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+vpu | FileCheck %s


declare double @llvm.vector.reduce.fadd.f64.v256f64(double %start_value, <256 x double> %a)

define fastcc double @vec_unordered_reduce_fadd_f64(<256 x double> %a, double %s) {
; CHECK-LABEL: vec_unordered_reduce_fadd_f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vfsum.d %v0, %v0, %vm0
; CHECK-NEXT:    lvs %s1, %v0(0)
; CHECK-NEXT:    fadd.d %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call reassoc double @llvm.vector.reduce.fadd.f64.v256f64(double %s, <256 x double> %a)
  ret double %r
}

define fastcc double @vec_ordered_reduce_fadd_f64(<256 x double> %a, double %s) {
; CHECK-LABEL: vec_ordered_reduce_fadd_f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vfia.d %v0, %v0, %s0
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call double @llvm.vector.reduce.fadd.f64.v256f64(double %s, <256 x double> %a)
  ret double %r
}

define fastcc double @vec_unordered_reduce_nostart_fadd_f64(<256 x double> %a) {
; CHECK-LABEL: vec_unordered_reduce_nostart_fadd_f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfsum.d %v0, %v0, %vm0
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    fadd.d %s0, %s0, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call reassoc double @llvm.vector.reduce.fadd.f64.v256f64(double 0.0, <256 x double> %a)
  ret double %r
}

define fastcc double @vec_ordered_reduce_nostart_fadd_f64(<256 x double> %a) {
; CHECK-LABEL: vec_ordered_reduce_nostart_fadd_f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfia.d %v0, %v0, 0
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call double @llvm.vector.reduce.fadd.f64.v256f64(double 0.0, <256 x double> %a)
  ret double %r
}


declare float @llvm.vector.reduce.fadd.f32.v256f32(float %start_value, <256 x float> %a)

define fastcc float @vec_unordered_reduce_fadd_f32(<256 x float> %a, float %s) {
; CHECK-LABEL: vec_unordered_reduce_fadd_f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vfsum.s %v0, %v0, %vm0
; CHECK-NEXT:    lvs %s1, %v0(0)
; CHECK-NEXT:    or %s1, 0, %s1
; CHECK-NEXT:    fadd.s %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call reassoc float @llvm.vector.reduce.fadd.f32.v256f32(float %s, <256 x float> %a)
  ret float %r
}

define fastcc float @vec_ordered_reduce_fadd_f32(<256 x float> %a, float %s) {
; CHECK-LABEL: vec_ordered_reduce_fadd_f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vfia.s %v0, %v0, %s0
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    or %s0, 0, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call float @llvm.vector.reduce.fadd.f32.v256f32(float %s, <256 x float> %a)
  ret float %r
}

define fastcc float @vec_unordered_reduce_nostart_fadd_f32(<256 x float> %a) {
; CHECK-LABEL: vec_unordered_reduce_nostart_fadd_f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfsum.s %v0, %v0, %vm0
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    or %s0, 0, %s0
; CHECK-NEXT:    fadd.s %s0, %s0, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call reassoc float @llvm.vector.reduce.fadd.f32.v256f32(float 0.0, <256 x float> %a)
  ret float %r
}

define fastcc float @vec_ordered_reduce_nostart_fadd_f32(<256 x float> %a) {
; CHECK-LABEL: vec_ordered_reduce_nostart_fadd_f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfia.s %v0, %v0, 0
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    or %s0, 0, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call float @llvm.vector.reduce.fadd.f32.v256f32(float 0.0, <256 x float> %a)
  ret float %r
}
