; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=-packed | FileCheck %s


declare double @llvm.experimental.vector.reduce.v2.fadd.f64.v256f64(double %start_value, <256 x double> %a)

define double @vec_unordered_reduce_fadd_f64(<256 x double> %a, double %s) {
  %r = call reassoc double @llvm.experimental.vector.reduce.v2.fadd.f64.v256f64(double %s, <256 x double> %a)
  ret double %r
}

define double @vec_ordered_reduce_fadd_f64(<256 x double> %a, double %s) {
  %r = call double @llvm.experimental.vector.reduce.v2.fadd.f64.v256f64(double %s, <256 x double> %a)
  ret double %r
}

define double @vec_unordered_reduce_nostart_fadd_f64(<256 x double> %a) {
  %r = call reassoc double @llvm.experimental.vector.reduce.v2.fadd.f64.v256f64(double 0.0, <256 x double> %a)
  ret double %r
}

define double @vec_ordered_reduce_nostart_fadd_f64(<256 x double> %a) {
  %r = call double @llvm.experimental.vector.reduce.v2.fadd.f64.v256f64(double 0.0, <256 x double> %a)
  ret double %r
}


declare float @llvm.experimental.vector.reduce.v2.fadd.f32.v256f32(float %start_value, <256 x float> %a)

define float @vec_unordered_reduce_fadd_f32(<256 x float> %a, float %s) {
  %r = call reassoc float @llvm.experimental.vector.reduce.v2.fadd.f32.v256f32(float %s, <256 x float> %a)
  ret float %r
}

define float @vec_ordered_reduce_fadd_f32(<256 x float> %a, float %s) {
  %r = call float @llvm.experimental.vector.reduce.v2.fadd.f32.v256f32(float %s, <256 x float> %a)
  ret float %r
}

define float @vec_unordered_reduce_nostart_fadd_f32(<256 x float> %a) {
  %r = call reassoc float @llvm.experimental.vector.reduce.v2.fadd.f32.v256f32(float 0.0, <256 x float> %a)
  ret float %r
}

define float @vec_ordered_reduce_nostart_fadd_f32(<256 x float> %a) {
  %r = call float @llvm.experimental.vector.reduce.v2.fadd.f32.v256f32(float 0.0, <256 x float> %a)
  ret float %r
}
