; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @test(i64 %offset, float* %p) {
; CHECK-LABEL: test
; CHECK: .LBB0_2
; CHECK:        pfchv %s0,%s1
entry:
  %0 = bitcast float* %p to i8*
  tail call void @llvm.ve.vl.pfchv.ssl(i64 %offset, i8* %0, i32 256)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.ve.vl.pfchv.ssl(i64, i8*, i32)

