; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind uwtable
define void @func(i32* nocapture) {
; CHECK-LABEL: func:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:    lea %s1, (, %s11)
; CHECK-NEXT:    lea %s1, 16(, %s1)
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    lea %s3, 256
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    stl %s2, -16(, %s1)
; CHECK-NEXT:    or %s5, 1, %s4
; CHECK-NEXT:    stl %s5, -12(, %s1)
; CHECK-NEXT:    or %s5, 2, %s4
; CHECK-NEXT:    stl %s5, -8(, %s1)
; CHECK-NEXT:    or %s5, 3, %s4
; CHECK-NEXT:    stl %s5, -4(, %s1)
; CHECK-NEXT:    or %s5, 4, %s4
; CHECK-NEXT:    stl %s5, (, %s1)
; CHECK-NEXT:    or %s5, 5, %s4
; CHECK-NEXT:    stl %s5, 4(, %s1)
; CHECK-NEXT:    or %s5, 6, %s4
; CHECK-NEXT:    stl %s5, 8(, %s1)
; CHECK-NEXT:    or %s5, 7, %s4
; CHECK-NEXT:    stl %s5, 12(, %s1)
; CHECK-NEXT:    lea %s4, 8(, %s4)
; CHECK-NEXT:    adds.w.sx %s2, 8, %s2
; CHECK-NEXT:    lea %s1, 32(, %s1)
; CHECK-NEXT:    brne.l %s4, %s3, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    ldl.sx %s1, (, %s11)
; CHECK-NEXT:    stl %s1, (, %s0)
; CHECK-NEXT:    lea %s11, 1024(, %s11)
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = alloca [256 x i32], align 16
  %3 = bitcast [256 x i32]* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 1024, i8* nonnull %3)
  br label %7

; <label>:4:                                      ; preds = %7
  %5 = getelementptr inbounds [256 x i32], [256 x i32]* %2, i64 0, i64 0
  %6 = load i32, i32* %5, align 16
  store i32 %6, i32* %0, align 4
  call void @llvm.lifetime.end.p0i8(i64 1024, i8* nonnull %3)
  ret void

; <label>:7:                                      ; preds = %7, %1
  %8 = phi i64 [ 0, %1 ], [ %32, %7 ]
  %9 = getelementptr inbounds [256 x i32], [256 x i32]* %2, i64 0, i64 %8
  %10 = trunc i64 %8 to i32
  store i32 %10, i32* %9, align 16
  %11 = or i64 %8, 1
  %12 = getelementptr inbounds [256 x i32], [256 x i32]* %2, i64 0, i64 %11
  %13 = trunc i64 %11 to i32
  store i32 %13, i32* %12, align 4
  %14 = or i64 %8, 2
  %15 = getelementptr inbounds [256 x i32], [256 x i32]* %2, i64 0, i64 %14
  %16 = trunc i64 %14 to i32
  store i32 %16, i32* %15, align 8
  %17 = or i64 %8, 3
  %18 = getelementptr inbounds [256 x i32], [256 x i32]* %2, i64 0, i64 %17
  %19 = trunc i64 %17 to i32
  store i32 %19, i32* %18, align 4
  %20 = or i64 %8, 4
  %21 = getelementptr inbounds [256 x i32], [256 x i32]* %2, i64 0, i64 %20
  %22 = trunc i64 %20 to i32
  store i32 %22, i32* %21, align 16
  %23 = or i64 %8, 5
  %24 = getelementptr inbounds [256 x i32], [256 x i32]* %2, i64 0, i64 %23
  %25 = trunc i64 %23 to i32
  store i32 %25, i32* %24, align 4
  %26 = or i64 %8, 6
  %27 = getelementptr inbounds [256 x i32], [256 x i32]* %2, i64 0, i64 %26
  %28 = trunc i64 %26 to i32
  store i32 %28, i32* %27, align 8
  %29 = or i64 %8, 7
  %30 = getelementptr inbounds [256 x i32], [256 x i32]* %2, i64 0, i64 %29
  %31 = trunc i64 %29 to i32
  store i32 %31, i32* %30, align 4
  %32 = add nuw nsw i64 %8, 8
  %33 = icmp eq i64 %32, 256
  br i1 %33, label %4, label %7
}

declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture)
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture)
