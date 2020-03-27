; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

@p = external global double*, align 8

; Function Attrs: nounwind
define void @test(i32) {
; CHECK-LABEL: test:
; CHECK:       .LBB0_2:
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    sll %s0, %s0, 3
; CHECK-NEXT:    lea %s0, 15(, %s0)
; CHECK-NEXT:    lea %s1, -16
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, 15(, %s1)
; CHECK-NEXT:    and %s0, %s0, %s1
; CHECK-NEXT:    lea %s1, __llvm_grow_stack@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, __llvm_grow_stack@hi(, %s1)
; CHECK-NEXT:    bsic %lr, (, %s12)
; CHECK-NEXT:    lea %s1, 240(, %s11)
; CHECK-NEXT:    lea %s0, p@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, p@hi(, %s0)
; CHECK-NEXT:    ld %s0, (, %s0)
; CHECK-NEXT:    adds.w.sx %s2, %s2, (0)1
; CHECK-NEXT:    sll %s2, %s2, 3
; CHECK-NEXT:    lea %s3, memcpy@lo
; CHECK-NEXT:    and %s3, %s3, (32)0
; CHECK-NEXT:    lea.sl %s12, memcpy@hi(, %s3)
; CHECK-NEXT:    bsic %lr, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i32 %0 to i64
  %3 = alloca double, i64 %2, align 8
  %4 = load i8*, i8** bitcast (double** @p to i8**), align 8, !tbaa !2
  %5 = bitcast double* %3 to i8*
  %6 = sext i32 %0 to i64
  %7 = shl nsw i64 %6, 3
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %4, i8* nonnull align 8 %5, i64 %7, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1)

!2 = !{!3, !3, i64 0}
!3 = !{!"any pointer", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
