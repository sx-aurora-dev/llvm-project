; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @test(i64 %offset, float* %p) {
; CHECK-LABEL: test:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, 256
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    pfchv %s0,%s1
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %0 = bitcast float* %p to i8*
  tail call void @llvm.ve.vl.pfchv.ssl(i64 %offset, i8* %0, i32 256)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.ve.vl.pfchv.ssl(i64, i8*, i32)

