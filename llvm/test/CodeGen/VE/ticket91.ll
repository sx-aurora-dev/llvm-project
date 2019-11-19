; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind uwtable
define void @func(i32* nocapture) {
; CHECK-LABEL: func:
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  lea %s34,176(,%s11)
; CHECK-NEXT:  lea %s34, 16(%s34)
; CHECK-NEXT:  or %s35, 0, (0)1
  %2 = alloca [256 x i32], align 16
  %3 = bitcast [256 x i32]* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 1024, i8* nonnull %3)
  br label %7

; <label>:4:                                      ; preds = %7
  %5 = getelementptr inbounds [256 x i32], [256 x i32]* %2, i64 0, i64 0
  %6 = load i32, i32* %5, align 16, !tbaa !2
  store i32 %6, i32* %0, align 4, !tbaa !2
  call void @llvm.lifetime.end.p0i8(i64 1024, i8* nonnull %3)
  ret void

; <label>:7:                                      ; preds = %7, %1
  %8 = phi i64 [ 0, %1 ], [ %32, %7 ]
  %9 = getelementptr inbounds [256 x i32], [256 x i32]* %2, i64 0, i64 %8
  %10 = trunc i64 %8 to i32
  store i32 %10, i32* %9, align 16, !tbaa !2
  %11 = or i64 %8, 1
  %12 = getelementptr inbounds [256 x i32], [256 x i32]* %2, i64 0, i64 %11
  %13 = trunc i64 %11 to i32
  store i32 %13, i32* %12, align 4, !tbaa !2
  %14 = or i64 %8, 2
  %15 = getelementptr inbounds [256 x i32], [256 x i32]* %2, i64 0, i64 %14
  %16 = trunc i64 %14 to i32
  store i32 %16, i32* %15, align 8, !tbaa !2
  %17 = or i64 %8, 3
  %18 = getelementptr inbounds [256 x i32], [256 x i32]* %2, i64 0, i64 %17
  %19 = trunc i64 %17 to i32
  store i32 %19, i32* %18, align 4, !tbaa !2
  %20 = or i64 %8, 4
  %21 = getelementptr inbounds [256 x i32], [256 x i32]* %2, i64 0, i64 %20
  %22 = trunc i64 %20 to i32
  store i32 %22, i32* %21, align 16, !tbaa !2
  %23 = or i64 %8, 5
  %24 = getelementptr inbounds [256 x i32], [256 x i32]* %2, i64 0, i64 %23
  %25 = trunc i64 %23 to i32
  store i32 %25, i32* %24, align 4, !tbaa !2
  %26 = or i64 %8, 6
  %27 = getelementptr inbounds [256 x i32], [256 x i32]* %2, i64 0, i64 %26
  %28 = trunc i64 %26 to i32
  store i32 %28, i32* %27, align 8, !tbaa !2
  %29 = or i64 %8, 7
  %30 = getelementptr inbounds [256 x i32], [256 x i32]* %2, i64 0, i64 %29
  %31 = trunc i64 %29 to i32
  store i32 %31, i32* %30, align 4, !tbaa !2
  %32 = add nuw nsw i64 %8, 8
  %33 = icmp eq i64 %32, 256
  br i1 %33, label %4, label %7
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture)

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture)

!2 = !{!3, !3, i64 0}
!3 = !{!"int", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
