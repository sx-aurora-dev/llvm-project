; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=-packed | FileCheck %s

; Function Attrs: nounwind
define void @vec_store_v1f64(<1 x double>* %P, <1 x double> %V) {
; CHECK-LABEL: vec_store_v1f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    st %s1, (, %s0)
; CHECK-NEXT:    or %s11, 0, %s9
  store <1 x double> %V, <1 x double>* %P, align 8
  ret void
}

; Function Attrs: nounwind
define void @vec_store_v17f64(<17 x double>* %P, <17 x double> %V) {
; CHECK-LABEL: vec_store_v17f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lvs %s1,%v0(16)
; CHECK-NEXT:    st %s1, 128(, %s0)
; CHECK-NEXT:    lvs %s1,%v0(15)
; CHECK-NEXT:    st %s1, 120(, %s0)
; CHECK-NEXT:    lvs %s1,%v0(14)
; CHECK-NEXT:    st %s1, 112(, %s0)
; CHECK-NEXT:    lvs %s1,%v0(13)
; CHECK-NEXT:    st %s1, 104(, %s0)
; CHECK-NEXT:    lvs %s1,%v0(12)
; CHECK-NEXT:    st %s1, 96(, %s0)
; CHECK-NEXT:    lvs %s1,%v0(11)
; CHECK-NEXT:    st %s1, 88(, %s0)
; CHECK-NEXT:    lvs %s1,%v0(10)
; CHECK-NEXT:    st %s1, 80(, %s0)
; CHECK-NEXT:    lvs %s1,%v0(9)
; CHECK-NEXT:    st %s1, 72(, %s0)
; CHECK-NEXT:    lvs %s1,%v0(8)
; CHECK-NEXT:    st %s1, 64(, %s0)
; CHECK-NEXT:    lvs %s1,%v0(7)
; CHECK-NEXT:    st %s1, 56(, %s0)
; CHECK-NEXT:    lvs %s1,%v0(6)
; CHECK-NEXT:    st %s1, 48(, %s0)
; CHECK-NEXT:    lvs %s1,%v0(5)
; CHECK-NEXT:    st %s1, 40(, %s0)
; CHECK-NEXT:    lvs %s1,%v0(4)
; CHECK-NEXT:    st %s1, 32(, %s0)
; CHECK-NEXT:    lvs %s1,%v0(3)
; CHECK-NEXT:    st %s1, 24(, %s0)
; CHECK-NEXT:    lvs %s1,%v0(2)
; CHECK-NEXT:    st %s1, 16(, %s0)
; CHECK-NEXT:    lvs %s1,%v0(1)
; CHECK-NEXT:    st %s1, 8(, %s0)
; CHECK-NEXT:    lvs %s1,%v0(0)
; CHECK-NEXT:    st %s1, (, %s0)
; CHECK-NEXT:    or %s11, 0, %s9
  store <17 x double> %V, <17 x double>* %P, align 8
  ret void
}

declare void @llvm.masked.store.v256f64.p0v256f64(<256 x double>, <256 x double>*, i32 immarg, <256 x i1>)
declare void @llvm.masked.store.v128f64.p0v128f64(<128 x double>, <128 x double>*, i32 immarg, <128 x i1>)

; Function Attrs: nounwind
define void @vec_mstore_v128f64(<128 x double>* %P, <128 x double> %V, <128 x i1> %M) {
; CHECK-LABEL: vec_mstore_v128f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 128
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vst %v0,8,%s0,%vm1
; CHECK-NEXT:    or %s11, 0, %s9
  call void @llvm.masked.store.v128f64.p0v128f64(<128 x double> %V, <128 x double>* %P, i32 16, <128 x i1> %M)
  ret void
}

define void @vec_mstore_v256f64(<256 x double>* %P, <256 x double> %V, <256 x i1> %M) {
; CHECK-LABEL: vec_mstore_v256f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vst %v0,8,%s0,%vm1
; CHECK-NEXT:    or %s11, 0, %s9
  call void @llvm.masked.store.v256f64.p0v256f64(<256 x double> %V, <256 x double>* %P, i32 16, <256 x i1> %M)
  ret void
}

declare void @llvm.masked.scatter.v256f64.v256p0f64(<256 x double>, <256 x double*>, i32 immarg, <256 x i1>)
declare void @llvm.masked.scatter.v128f64.v128p0f64(<128 x double>, <128 x double*>, i32 immarg, <128 x i1>)

define void @vec_scatter_v128f64(<128 x double*> %P, <128 x double> %V, <128 x i1> %M) {
; CHECK-LABEL: vec_scatter_v128f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vsc %v1,%v0,0,0,%vm1
; CHECK-NEXT:    or %s11, 0, %s9
  call void @llvm.masked.scatter.v128f64.v128p0f64(<128 x double> %V, <128 x double*> %P, i32 16, <128 x i1> %M)
  ret void
}

define void @vec_scatter_v256f64(<256 x double*> %P, <256 x double> %V, <256 x i1> %M) {
; CHECK-LABEL: vec_scatter_v256f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vsc %v1,%v0,0,0,%vm1
; CHECK-NEXT:    or %s11, 0, %s9
  call void @llvm.masked.scatter.v256f64.v256p0f64(<256 x double> %V, <256 x double*> %P, i32 16, <256 x i1> %M)
  ret void
}
