; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define dso_local signext i16 @func1() local_unnamed_addr #0 {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = sext i8 %2 to i16
  ret i16 %3
}

declare dso_local void @func_ch(i8*) local_unnamed_addr #2

define dso_local i32 @func2() local_unnamed_addr #0 {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = sext i8 %2 to i32
  ret i32 %3
}

define dso_local i64 @func3() local_unnamed_addr #0 {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = sext i8 %2 to i64
  ret i64 %3
}

define dso_local zeroext i16 @func4() local_unnamed_addr #0 {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s34, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = sext i8 %2 to i16
  ret i16 %3
}

define dso_local i32 @func5() local_unnamed_addr #0 {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = sext i8 %2 to i32
  ret i32 %3
}

define dso_local i64 @func6() local_unnamed_addr #0 {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = sext i8 %2 to i64
  ret i64 %3
}

define dso_local signext i16 @func7() local_unnamed_addr #0 {
; CHECK-LABEL: func7:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = zext i8 %2 to i16
  ret i16 %3
}

declare dso_local void @func_uch(i8*) local_unnamed_addr #2

define dso_local i32 @func8() local_unnamed_addr #0 {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = zext i8 %2 to i32
  ret i32 %3
}

define dso_local i64 @func9() local_unnamed_addr #0 {
; CHECK-LABEL: func9:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = zext i8 %2 to i64
  ret i64 %3
}

define dso_local zeroext i16 @func10() local_unnamed_addr #0 {
; CHECK-LABEL: func10:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = zext i8 %2 to i16
  ret i16 %3
}

define dso_local zeroext i16 @func11() local_unnamed_addr #0 {
; CHECK-LABEL: func11:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = zext i8 %2 to i16
  ret i16 %3
}

define dso_local i64 @func12() local_unnamed_addr #0 {
; CHECK-LABEL: func12:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = zext i8 %2 to i64
  ret i64 %3
}

define dso_local i32 @func13() local_unnamed_addr #0 {
; CHECK-LABEL: func13:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.sx %s0, 190(,%s11)
  %1 = alloca i16, align 2
  %2 = bitcast i16* %1 to i8*
  %3 = load i16, i16* %1, align 2, !tbaa !5
  %4 = sext i16 %3 to i32
  ret i32 %4
}

declare dso_local void @func_sh(i16*) local_unnamed_addr #2

define dso_local i64 @func14() local_unnamed_addr #0 {
; CHECK-LABEL: func14:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.sx %s0, 190(,%s11)
  %1 = alloca i16, align 2
  %2 = bitcast i16* %1 to i8*
  %3 = load i16, i16* %1, align 2, !tbaa !5
  %4 = sext i16 %3 to i64
  ret i64 %4
}

define dso_local zeroext i16 @func15() local_unnamed_addr #0 {
; CHECK-LABEL: func15:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.zx %s0, 190(,%s11)
  %1 = alloca i16, align 2
  %2 = bitcast i16* %1 to i8*
  %3 = load i16, i16* %1, align 2, !tbaa !5
  ret i16 %3
}

define dso_local i64 @func16() local_unnamed_addr #0 {
; CHECK-LABEL: func16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.sx %s0, 190(,%s11)
  %1 = alloca i16, align 2
  %2 = bitcast i16* %1 to i8*
  %3 = load i16, i16* %1, align 2, !tbaa !5
  %4 = sext i16 %3 to i64
  ret i64 %4
}

define dso_local i32 @func17() local_unnamed_addr #0 {
; CHECK-LABEL: func17:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.zx %s0, 190(,%s11)
  %1 = alloca i16, align 2
  %2 = bitcast i16* %1 to i8*
  %3 = load i16, i16* %1, align 2, !tbaa !5
  %4 = zext i16 %3 to i32
  ret i32 %4
}

declare dso_local void @func_ush(i16*) local_unnamed_addr #2

define dso_local i64 @func18() local_unnamed_addr #0 {
; CHECK-LABEL: func18:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.zx %s0, 190(,%s11)
  %1 = alloca i16, align 2
  %2 = bitcast i16* %1 to i8*
  %3 = load i16, i16* %1, align 2, !tbaa !5
  %4 = zext i16 %3 to i64
  ret i64 %4
}

define dso_local zeroext i16 @func19() local_unnamed_addr #0 {
; CHECK-LABEL: func19:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.zx %s0, 190(,%s11)
  %1 = alloca i16, align 2
  %2 = bitcast i16* %1 to i8*
  %3 = load i16, i16* %1, align 2, !tbaa !5
  ret i16 %3
}

define dso_local i64 @func20() local_unnamed_addr #0 {
; CHECK-LABEL: func20:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.zx %s0, 190(,%s11)
  %1 = alloca i16, align 2
  %2 = bitcast i16* %1 to i8*
  %3 = load i16, i16* %1, align 2, !tbaa !5
  %4 = zext i16 %3 to i64
  ret i64 %4
}

define dso_local i64 @func21() local_unnamed_addr #0 {
; CHECK-LABEL: func21:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ldl.sx %s0, 188(,%s11)
  %1 = alloca i32, align 4
  %2 = bitcast i32* %1 to i8*
  %3 = load i32, i32* %1, align 4, !tbaa !7
  %4 = sext i32 %3 to i64
  ret i64 %4
}

declare dso_local void @func_in(i32*) local_unnamed_addr #2

define dso_local i64 @func22() local_unnamed_addr #0 {
; CHECK-LABEL: func22:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ldl.sx %s0, 188(,%s11)
  %1 = alloca i32, align 4
  %2 = bitcast i32* %1 to i8*
  %3 = load i32, i32* %1, align 4, !tbaa !7
  %4 = sext i32 %3 to i64
  ret i64 %4
}

define dso_local i64 @func23() local_unnamed_addr #0 {
; CHECK-LABEL: func23:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ldl.zx %s0, 188(,%s11)
  %1 = alloca i32, align 4
  %2 = bitcast i32* %1 to i8*
  %3 = load i32, i32* %1, align 4, !tbaa !7
  %4 = zext i32 %3 to i64
  ret i64 %4
}

declare dso_local void @func_uin(i32*) local_unnamed_addr #2

define dso_local i64 @func24() local_unnamed_addr #0 {
; CHECK-LABEL: func24:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ldl.zx %s0, 188(,%s11)
  %1 = alloca i32, align 4
  %2 = bitcast i32* %1 to i8*
  %3 = load i32, i32* %1, align 4, !tbaa !7
  %4 = zext i32 %3 to i64
  ret i64 %4
}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 7.0.0 (git@socsv218.svp.cl.nec.co.jp:ve-llvm/clang.git 94c1203774d203ef69c0c9429c11efb086946b05) (llvm/llvm.git 770f66a66652c1eec9a930ad681ac1b097ca4d5a)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = !{!6, !6, i64 0}
!6 = !{!"short", !3, i64 0}
!7 = !{!8, !8, i64 0}
!8 = !{!"int", !3, i64 0}
