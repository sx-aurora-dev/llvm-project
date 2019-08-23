; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

@buf = external global i8*, align 8

; Function Attrs: nounwind
define void @test(i32) {
; CHECK-LABEL: test:
; CHECK:       .LBB0_2:
; CHECK-NEXT:    adds.w.sx %s2, %s0, (0)1
; CHECK-NEXT:    lea %s34, 15(%s2)
; CHECK-NEXT:    and %s0, -16, %s34
; CHECK-NEXT:    adds.l %s11, -64, %s11
; CHECK-NEXT:    lea %s34, __llvm_grow_stack@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __llvm_grow_stack@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    lea %s13, 64
; CHECK-NEXT:    and %s13, %s13, (32)0
; CHECK-NEXT:    lea.sl %s11, 0(%s11, %s13)
; CHECK-NEXT:    lea %s1, 176(%s11)
; CHECK-NEXT:    lea %s34, buf@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, buf@hi(%s34)
; CHECK-NEXT:    ld %s0, (,%s34)
; CHECK-NEXT:    adds.l %s11, -64, %s11
; CHECK-NEXT:    lea %s34, memcpy@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, memcpy@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    lea %s13, 64
; CHECK-NEXT:    and %s13, %s13, (32)0
; CHECK-NEXT:    lea.sl %s11, 0(%s11, %s13)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i32 %0 to i64
  %3 = alloca i8, i64 %2, align 8
  %4 = load i8*, i8** @buf, align 8, !tbaa !2
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %4, i8* nonnull align 8 %3, i64 %2, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1)

!2 = !{!3, !3, i64 0}
!3 = !{!"any pointer", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
