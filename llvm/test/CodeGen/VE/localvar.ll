; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

@p = external global double*, align 8

; Function Attrs: nounwind
define void @test(i32) {
; CHECK-LABEL: test:
; CHECK:       .LBB0_2:
; CHECK-NEXT:    or %s34, 0, %s0
; CHECK-NEXT:    adds.w.zx %s35, %s0, (0)1
; CHECK-NEXT:    sll %s35, %s35, 3
; CHECK-NEXT:    lea %s35, 15(%s35)
; CHECK-NEXT:    lea %s36, -16
; CHECK-NEXT:    and %s36, %s36, (32)0
; CHECK-NEXT:    lea.sl %s36, 15(%s36)
; CHECK-NEXT:    and %s0, %s35, %s36
; CHECK-NEXT:    adds.l %s11, -64, %s11
; CHECK-NEXT:    lea %s35, __llvm_grow_stack@lo
; CHECK-NEXT:    and %s35, %s35, (32)0
; CHECK-NEXT:    lea.sl %s12, __llvm_grow_stack@hi(%s35)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    lea %s13, 64
; CHECK-NEXT:    and %s13, %s13, (32)0
; CHECK-NEXT:    lea.sl %s11, 0(%s11, %s13)
; CHECK-NEXT:    lea %s1, 176(%s11)
; CHECK-NEXT:    lea %s35, p@lo
; CHECK-NEXT:    and %s35, %s35, (32)0
; CHECK-NEXT:    lea.sl %s35, p@hi(%s35)
; CHECK-NEXT:    ld %s0, (,%s35)
; CHECK-NEXT:    adds.w.sx %s34, %s34, (0)1
; CHECK-NEXT:    sll %s2, %s34, 3
; CHECK-NEXT:    adds.l %s11, -64, %s11
; CHECK-NEXT:    lea %s34, memcpy@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, memcpy@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    lea %s13, 64
; CHECK-NEXT:    and %s13, %s13, (32)0
; CHECK-NEXT:    lea.sl %s11, 0(%s11, %s13)
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
