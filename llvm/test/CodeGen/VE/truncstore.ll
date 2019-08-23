; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define void @func0(i1 signext) {
; CHECK-LABEL: func0:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    st1b %s0, -2(,%s9)
  %2 = alloca i8, align 2
  %3 = bitcast i8* %2 to i1*
  call void @llvm.lifetime.start.p0i1(i64 2, i1* nonnull %3)
  %4 = sext i1 %0 to i8
  store i8 %4, i8* %2, align 2, !tbaa !2
  call void @func_ch(i8* nonnull %2)
  call void @llvm.lifetime.end.p0i1(i64 2, i1* nonnull %3)
  ret void
}

declare void @llvm.lifetime.start.p0i1(i64, i1* nocapture)
declare void @func_ch(i8*)
declare void @llvm.lifetime.end.p0i1(i64, i1* nocapture)

define void @func1(i8 signext) {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    st2b %s0, -2(,%s9)
  %2 = alloca i16, align 2
  %3 = bitcast i16* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 2, i8* nonnull %3)
  %4 = sext i8 %0 to i16
  store i16 %4, i16* %2, align 2, !tbaa !2
  call void @func_sh(i16* nonnull %2)
  call void @llvm.lifetime.end.p0i8(i64 2, i8* nonnull %3)
  ret void
}

declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture)
declare void @func_sh(i16*)
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture)

define void @func2(i8 signext) {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    stl %s0, -4(,%s9)
  %2 = alloca i32, align 4
  %3 = bitcast i32* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3)
  %4 = sext i8 %0 to i32
  store i32 %4, i32* %2, align 4, !tbaa !6
  call void @func_in(i32* nonnull %2)
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3)
  ret void
}

declare void @func_in(i32*)

define void @func3(i8 signext) {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s0, (0)1
; CHECK-NEXT:    st %s34, -8(,%s9)
  %2 = alloca i64, align 8
  %3 = bitcast i64* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3)
  %4 = sext i8 %0 to i64
  store i64 %4, i64* %2, align 8, !tbaa !8
  call void @func_lo(i64* nonnull %2)
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3)
  ret void
}

declare void @func_lo(i64*)

define void @func4(i8 signext) {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s0, (0)1
; CHECK-NEXT:    sra.l %s35, %s34, 63
; CHECK-NEXT:    lea %s0,-16(,%s9)
; CHECK-NEXT:    or %s36, 8, %s0
; CHECK-NEXT:    st %s35, (,%s36)
; CHECK-NEXT:    st %s34, -16(,%s9)
  %2 = alloca i128, align 16
  %3 = bitcast i128* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %3)
  %4 = sext i8 %0 to i128
  store i128 %4, i128* %2, align 16, !tbaa !10
  call void @func_i128(i128* nonnull %2)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %3)
  ret void
}

declare void @func_i128(i128*)

define void @func5(i16 signext) {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    stl %s0, -4(,%s9)
  %2 = alloca i32, align 4
  %3 = bitcast i32* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3)
  %4 = sext i16 %0 to i32
  store i32 %4, i32* %2, align 4, !tbaa !6
  call void @func_in(i32* nonnull %2)
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3)
  ret void
}

define void @func6(i16 signext) {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s0, (0)1
; CHECK-NEXT:    st %s34, -8(,%s9)
  %2 = alloca i64, align 8
  %3 = bitcast i64* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3)
  %4 = sext i16 %0 to i64
  store i64 %4, i64* %2, align 8, !tbaa !8
  call void @func_lo(i64* nonnull %2)
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3)
  ret void
}

define void @func7(i16 signext) {
; CHECK-LABEL: func7:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s0, (0)1
; CHECK-NEXT:    sra.l %s35, %s34, 63
; CHECK-NEXT:    lea %s0,-16(,%s9)
; CHECK-NEXT:    or %s36, 8, %s0
; CHECK-NEXT:    st %s35, (,%s36)
; CHECK-NEXT:    st %s34, -16(,%s9)
  %2 = alloca i128, align 16
  %3 = bitcast i128* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %3)
  %4 = sext i16 %0 to i128
  store i128 %4, i128* %2, align 16, !tbaa !10
  call void @func_i128(i128* nonnull %2)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %3)
  ret void
}

define void @func8(i32) {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s0, (0)1
; CHECK-NEXT:    st %s34, -8(,%s9)
  %2 = alloca i64, align 8
  %3 = bitcast i64* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3)
  %4 = sext i32 %0 to i64
  store i64 %4, i64* %2, align 8, !tbaa !8
  call void @func_lo(i64* nonnull %2)
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3)
  ret void
}

define void @func9(i32) {
; CHECK-LABEL: func9:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s0, (0)1
; CHECK-NEXT:    sra.l %s35, %s34, 63
; CHECK-NEXT:    lea %s0,-16(,%s9)
; CHECK-NEXT:    or %s36, 8, %s0
; CHECK-NEXT:    st %s35, (,%s36)
; CHECK-NEXT:    st %s34, -16(,%s9)
  %2 = alloca i128, align 16
  %3 = bitcast i128* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %3)
  %4 = sext i32 %0 to i128
  store i128 %4, i128* %2, align 16, !tbaa !10
  call void @func_i128(i128* nonnull %2)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %3)
  ret void
}

define void @func10(i64) {
; CHECK-LABEL: func10:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sra.l %s35, %s0, 63
; CHECK-NEXT:    lea %s34,-16(,%s9)
; CHECK-NEXT:    or %s36, 8, %s34
; CHECK-NEXT:    st %s35, (,%s36)
; CHECK-NEXT:    st %s0, -16(,%s9)
  %2 = alloca i128, align 16
  %3 = bitcast i128* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %3)
  %4 = sext i64 %0 to i128
  store i128 %4, i128* %2, align 16, !tbaa !10
  call void @func_i128(i128* nonnull %2)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %3)
  ret void
}

!2 = !{!3, !3, i64 0}
!3 = !{!"short", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!7, !7, i64 0}
!7 = !{!"int", !4, i64 0}
!8 = !{!9, !9, i64 0}
!9 = !{!"long long", !4, i64 0}
!10 = !{!11, !11, i64 0}
!11 = !{!"__int128", !4, i64 0}
