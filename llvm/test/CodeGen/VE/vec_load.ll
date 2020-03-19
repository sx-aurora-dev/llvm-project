; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=-packed | FileCheck %s

; Function Attrs: nounwind
define <1 x double> @vec_load_v1f64(<1 x double>* %P) {
; CHECK-LABEL: vec_load_v1f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s0, (,%s0)
; CHECK-NEXT:    or %s11, 0, %s9
  %r = load <1 x double>, <1 x double>* %P, align 8
  ret <1 x double> %r
}

; Function Attrs: nounwind
define x86_regcallcc <17 x double> @vec_load_v17f64(<17 x double>* %P) {
; CHECK-LABEL: vec_load_v17f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 17, (0)1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0,8,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = load <17 x double>, <17 x double>* %P, align 8
  ret <17 x double> %r
}

declare <256 x double> @llvm.masked.load.v256f64.p0v256f64(<256 x double>* %0, i32 immarg %1, <256 x i1> %2, <256 x double> %3) #0
declare <128 x double> @llvm.masked.load.v128f64.p0v128f64(<128 x double>* %0, i32 immarg %1, <128 x i1> %2, <128 x double> %3) #0

; Function Attrs: nounwind
define x86_regcallcc <128 x double> @vec_mload_v128f64(<128 x double>* %P, <128 x i1> %M) {
; CHECK-LABEL: vec_mload_v128f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 128
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vseq %v0
; CHECK-NEXT:    vmulu.l %v0,8,%v0,%vm1
; CHECK-NEXT:    vaddu.l %v0,%s0,%v0,%vm1
; CHECK-NEXT:    vgt %v0,%v0,0,0,%vm1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = call <128 x double> @llvm.masked.load.v128f64.p0v128f64(<128 x double>* %P, i32 16, <128 x i1> %M, <128 x double> undef)
  ret <128 x double> %r
}

; Function Attrs: nounwind
define <256 x double> @vec_mload_v256f64(<256 x double>* %P, <256 x i1> %M) {
; CHECK-LABEL: vec_mload_v256f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vseq %v0
; CHECK-NEXT:    vmulu.l %v0,8,%v0,%vm1
; CHECK-NEXT:    vaddu.l %v0,%s0,%v0,%vm1
; CHECK-NEXT:    vgt %v0,%v0,0,0,%vm1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = call <256 x double> @llvm.masked.load.v256f64.p0v256f64(<256 x double>* %P, i32 16, <256 x i1> %M, <256 x double> undef)
  ret <256 x double> %r
}

declare <256 x double> @llvm.masked.gather.v256f64.v256p0f64(<256 x double*> %0, i32 immarg %1, <256 x i1> %2, <256 x double> %3) #0
declare <128 x double> @llvm.masked.gather.v128f64.v128p0f64(<128 x double*> %0, i32 immarg %1, <128 x i1> %2, <128 x double> %3) #0

; Function Attrs: nounwind
define x86_regcallcc <128 x double> @vec_gather_v128f64(<128 x double*> %P, <128 x i1> %M) {
; CHECK-LABEL: vec_gather_v128f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vgt %v0,%v0,0,0,%vm1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = call <128 x double> @llvm.masked.gather.v128f64.v128p0f64(<128 x double*> %P, i32 16, <128 x i1> %M, <128 x double> undef)
  ret <128 x double> %r
}

; Function Attrs: nounwind
define <256 x double> @vec_gather_v256f64(<256 x double*> %P, <256 x i1> %M) {
; CHECK-LABEL: vec_gather_v256f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vgt %v0,%v0,0,0,%vm1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = call <256 x double> @llvm.masked.gather.v256f64.v256p0f64(<256 x double*> %P, i32 16, <256 x i1> %M, <256 x double> undef)
  ret <256 x double> %r
}

attributes #0 = { argmemonly nounwind readonly willreturn }
