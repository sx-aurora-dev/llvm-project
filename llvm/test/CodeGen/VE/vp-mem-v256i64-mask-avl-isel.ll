; RUN: llc -O0 --march=ve %s -o=/dev/stdout | FileCheck %s

define void @test_vp_harness(<256 x i64>* %Out, <256 x i64> %i0) {
  store <256 x i64> %i0, <256 x i64>* %Out
; CHECK: test_vp_harness:
  ret void
}

define void @test_vp_memory_i64(<256 x i64>* %VecPtr, <256 x i64*> %PtrVec, <256 x i64> %i0, <256 x i1> %m, i32 %n) {
  %r0 = call <256 x i64> @llvm.vp.load.v256i64.p0v256i64(<256 x i64>* %VecPtr, <256 x i1> %m, i32 %n)
  %r1 = call <256 x i64> @llvm.vp.gather.v256i64.v256p0i64(<256 x i64*> %PtrVec, <256 x i1> %m, i32 %n)
  call void @llvm.vp.scatter.v256i64.v256p0i64(<256 x i64> %r0, <256 x i64*> %PtrVec, <256 x i1> %m, i32 %n)
  call void @llvm.vp.store.v256i64.p0v256i64(<256 x i64> %r1, <256 x i64>* %VecPtr, <256 x i1> %m, i32 %n)
; CHECK: test_vp_memory_i64
; CHECK: vgt
; CHECK: vgt
; CHECK: vsc
; CHECK: vst
  ret void
}

define void @test_vp_memory_f64(<256 x double>* %VecPtr, <256 x double*> %PtrVec, <256 x double> %i0, <256 x i1> %m, i32 %n) {
  %r0 = call <256 x double> @llvm.vp.load.v256f64.p0v256f64(<256 x double>* %VecPtr, <256 x i1> %m, i32 %n)
  %r1 = call <256 x double> @llvm.vp.gather.v256f64.v256p0f64(<256 x double*> %PtrVec, <256 x i1> %m, i32 %n)
  call void @llvm.vp.scatter.v256f64.v256p0f64(<256 x double> %r0, <256 x double*> %PtrVec, <256 x i1> %m, i32 %n)
  call void @llvm.vp.store.v256f64.p0v256f64(<256 x double> %r1, <256 x double>* %VecPtr, <256 x i1> %m, i32 %n)
; CHECK: test_vp_memory_f64
; CHECK: vgt
; CHECK: vgt
; CHECK: vsc
; CHECK: vst
  ret void
}

; memory - i64
declare void @llvm.vp.store.v256i64.p0v256i64(<256 x i64>, <256 x i64>*, <256 x i1> mask, i32 vlen)
declare <256 x i64> @llvm.vp.load.v256i64.p0v256i64(<256 x i64>*, <256 x i1> mask, i32 vlen)
declare void @llvm.vp.scatter.v256i64.v256p0i64(<256 x i64>, <256 x i64*>, <256 x i1> mask, i32 vlen)
declare <256 x i64> @llvm.vp.gather.v256i64.v256p0i64(<256 x i64*>, <256 x i1> mask, i32 vlen)
; memory - f64
declare void @llvm.vp.store.v256f64.p0v256f64(<256 x double>, <256 x double>*, <256 x i1> mask, i32 vlen)
declare <256 x double> @llvm.vp.load.v256f64.p0v256f64(<256 x double>*, <256 x i1> mask, i32 vlen)
declare void @llvm.vp.scatter.v256f64.v256p0f64(<256 x double>, <256 x double*>, <256 x i1> mask, i32 vlen)
declare <256 x double> @llvm.vp.gather.v256f64.v256p0f64(<256 x double*>, <256 x i1> mask, i32 vlen)
