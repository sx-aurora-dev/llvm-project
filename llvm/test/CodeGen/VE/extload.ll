; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define double @func1() {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, func_fl@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, func_fl@hi(%s34)
; CHECK-NEXT:    lea %s0,-4(,%s9)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    ldu %s34, -4(,%s9)
; CHECK-NEXT:    cvt.d.s %s0, %s34
  %1 = alloca float, align 4
  %2 = bitcast float* %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %2)
  call void @func_fl(float* nonnull %1)
  %3 = load float, float* %1, align 4, !tbaa !2
  %4 = fpext float %3 to double
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %2)
  ret double %4
}

declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture)
declare void @func_fl(float*)
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture)

define fp128 @func2() {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, func_fl@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, func_fl@hi(%s34)
; CHECK-NEXT:    lea %s0,-4(,%s9)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    ldu %s34, -4(,%s9)
; CHECK-NEXT:    cvt.q.s %s0, %s34
  %1 = alloca float, align 4
  %2 = bitcast float* %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %2)
  call void @func_fl(float* nonnull %1)
  %3 = load float, float* %1, align 4, !tbaa !2
  %4 = fpext float %3 to fp128
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %2)
  ret fp128 %4
}

define fp128 @func3() {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, func_db@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, func_db@hi(%s34)
; CHECK-NEXT:    lea %s0,-8(,%s9)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    ld %s34, -8(,%s9)
; CHECK-NEXT:    cvt.q.d %s0, %s34
  %1 = alloca double, align 8
  %2 = bitcast double* %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2)
  call void @func_db(double* nonnull %1)
  %3 = load double, double* %1, align 8, !tbaa !6
  %4 = fpext double %3 to fp128
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2)
  ret fp128 %4
}

declare void @func_db(double*)

!2 = !{!3, !3, i64 0}
!3 = !{!"float", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!7, !7, i64 0}
!7 = !{!"double", !4, i64 0}
