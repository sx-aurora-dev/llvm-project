; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @test(float* %p) {
; CHECK-LABEL: test
; CHECK: .LBB0_2
; CHECK:        pfchv 4,%s0
entry:
  %0 = bitcast float* %p to i8*
  tail call void @llvm.ve.pfchv.ss(i64 4, i8* %0)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.ve.pfchv.ss(i64, i8*)

