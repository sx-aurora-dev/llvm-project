; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define dso_local void @func0(i1 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func0:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    st1b %s0, -2(,%s9)
  %2 = alloca i8, align 2
  %3 = bitcast i8* %2 to i1*
  call void @llvm.lifetime.start.p0i1(i64 2, i1* nonnull %3) #3
  %4 = sext i1 %0 to i8
  store i8 %4, i8* %2, align 2, !tbaa !2
  call void @func_ch(i8* nonnull %2) #3
  call void @llvm.lifetime.end.p0i1(i64 2, i1* nonnull %3) #3
  ret void
}

declare void @llvm.lifetime.start.p0i1(i64, i1* nocapture) #1
declare dso_local void @func_ch(i8*) local_unnamed_addr #2
declare void @llvm.lifetime.end.p0i1(i64, i1* nocapture) #1

define dso_local void @func1(i8 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    st2b %s0, -2(,%s9)
  %2 = alloca i16, align 2
  %3 = bitcast i16* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 2, i8* nonnull %3) #3
  %4 = sext i8 %0 to i16
  store i16 %4, i16* %2, align 2, !tbaa !2
  call void @func_sh(i16* nonnull %2) #3
  call void @llvm.lifetime.end.p0i8(i64 2, i8* nonnull %3) #3
  ret void
}

declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #1
declare dso_local void @func_sh(i16*) local_unnamed_addr #2
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #1

define dso_local void @func2(i8 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    stl %s0, -4(,%s9)
  %2 = alloca i32, align 4
  %3 = bitcast i32* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3) #3
  %4 = sext i8 %0 to i32
  store i32 %4, i32* %2, align 4, !tbaa !6
  call void @func_in(i32* nonnull %2) #3
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3) #3
  ret void
}

declare dso_local void @func_in(i32*) local_unnamed_addr #2

define dso_local void @func3(i8 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s0, (0)1
; CHECK-NEXT:    st %s34, -8(,%s9)
  %2 = alloca i64, align 8
  %3 = bitcast i64* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3) #3
  %4 = sext i8 %0 to i64
  store i64 %4, i64* %2, align 8, !tbaa !8
  call void @func_lo(i64* nonnull %2) #3
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3) #3
  ret void
}

declare dso_local void @func_lo(i64*) local_unnamed_addr #2

define dso_local void @func4(i16 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    stl %s0, -4(,%s9)
  %2 = alloca i32, align 4
  %3 = bitcast i32* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3) #3
  %4 = sext i16 %0 to i32
  store i32 %4, i32* %2, align 4, !tbaa !6
  call void @func_in(i32* nonnull %2) #3
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3) #3
  ret void
}

define dso_local void @func5(i16 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s0, (0)1
; CHECK-NEXT:    st %s34, -8(,%s9)
  %2 = alloca i64, align 8
  %3 = bitcast i64* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3) #3
  %4 = sext i16 %0 to i64
  store i64 %4, i64* %2, align 8, !tbaa !8
  call void @func_lo(i64* nonnull %2) #3
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3) #3
  ret void
}

define dso_local void @func6(i32) local_unnamed_addr #0 {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s0, (0)1
; CHECK-NEXT:    st %s34, -8(,%s9)
  %2 = alloca i64, align 8
  %3 = bitcast i64* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3) #3
  %4 = sext i32 %0 to i64
  store i64 %4, i64* %2, align 8, !tbaa !8
  call void @func_lo(i64* nonnull %2) #3
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3) #3
  ret void
}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 7.0.0 (git@socsv218.svp.cl.nec.co.jp:ve-llvm/clang.git 94c1203774d203ef69c0c9429c11efb086946b05) (llvm/llvm.git 770f66a66652c1eec9a930ad681ac1b097ca4d5a)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"short", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!7, !7, i64 0}
!7 = !{!"int", !4, i64 0}
!8 = !{!9, !9, i64 0}
!9 = !{!"long long", !4, i64 0}
