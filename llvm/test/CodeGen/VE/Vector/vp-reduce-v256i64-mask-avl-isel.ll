; RUN: llc -O0 --march=ve %s -o=/dev/stdout | FileCheck %s

define void @test_vp_harness(<256 x i64>* %Out, <256 x i64> %i0) {
  store <256 x i64> %i0, <256 x i64>* %Out
; CHECK: test_vp_harness:
  ret void
}

define double @test_reduce_fp(<256 x double> %v, <256 x i1> %m, i32 %n) {
  %r0 = call double @llvm.vp.reduce.fadd.v256f64(double 0.0, <256 x double> %v, <256 x i1> %m, i32 %n)
  ; %r1 = call double @llvm.vp.reduce.fmul.v256f64(double 42.0, <256 x double> %v, <256 x i1> %m, i32 %n)
  ; %r2 = call double @llvm.vp.reduce.fmin.v256f64(<256 x double> %v, <256 x i1> %m, i32 %n)
  ; %r3 = call double @llvm.vp.reduce.fmax.v256f64(<256 x double> %v, <256 x i1> %m, i32 %n)
  %s0 = fadd double %r0, 0.0 ; %r1
  %s1 = fadd double %s0, 0.0 ; %r2
  %s2 = fadd double %s1, 0.0 ; %r3
  ret double %s2
}

define i64 @test_reduce_int(<256 x i64> %v, <256 x i1> %m, i32 %n) {
  %r0 = call i64 @llvm.vp.reduce.add.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  ; %r1 = call i64 @llvm.vp.reduce.mul.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  %r2 = call i64 @llvm.vp.reduce.and.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  %r3 = call i64 @llvm.vp.reduce.xor.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  %r4 = call i64 @llvm.vp.reduce.or.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  ; %r5 = call i64 @llvm.vp.reduce.smin.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  ; %r6 = call i64 @llvm.vp.reduce.smax.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  ; %r7 = call i64 @llvm.vp.reduce.umin.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  ; %r8 = call i64 @llvm.vp.reduce.umax.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  %s0 = add i64 %r0, 0 ; %r1
  %s1 = add i64 %r2, %r3
  %s2 = add i64 %r4, 0 ; %r5
  %s3 = add i64 0, 0 ; %r6, %r7
  %s4 = add i64 %s0, %s1
  %s5 = add i64 %s2, %s3
  %s6 = add i64 %s4, 0 ; %r5
  %s7 = add i64 %s6, 0 ; %r8
  ret i64 %s7
}

declare double @llvm.vp.reduce.fadd.v256f64(double, <256 x double>, <256 x i1> mask, i32 vlen) 
declare double @llvm.vp.reduce.fmul.v256f64(double, <256 x double>, <256 x i1> mask, i32 vlen)
declare double @llvm.vp.reduce.fmin.v256f64(<256 x double>, <256 x i1> mask, i32 vlen)
declare double @llvm.vp.reduce.fmax.v256f64(<256 x double>, <256 x i1> mask, i32 vlen)
declare i64 @llvm.vp.reduce.add.v256i64(<256 x i64>, <256 x i1> mask, i32 vlen)
declare i64 @llvm.vp.reduce.mul.v256i64(<256 x i64>, <256 x i1> mask, i32 vlen)
declare i64 @llvm.vp.reduce.and.v256i64(<256 x i64>, <256 x i1> mask, i32 vlen)
declare i64 @llvm.vp.reduce.xor.v256i64(<256 x i64>, <256 x i1> mask, i32 vlen)
declare i64 @llvm.vp.reduce.or.v256i64(<256 x i64>, <256 x i1> mask, i32 vlen)
declare i64 @llvm.vp.reduce.smax.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
declare i64 @llvm.vp.reduce.smin.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
declare i64 @llvm.vp.reduce.umax.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
declare i64 @llvm.vp.reduce.umin.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)

