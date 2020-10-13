; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @test(float* %p) {
; CHECK-LABEL: test:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    pfchv 4, %s0
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = bitcast float* %p to i8*
  tail call void @llvm.ve.vl.pfchv.ssl(i64 4, i8* %0, i32 256)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.ve.vl.pfchv.ssl(i64, i8*, i32)

