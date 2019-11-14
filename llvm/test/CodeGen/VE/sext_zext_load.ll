; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define signext i16 @func1() {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = sext i8 %2 to i16
  ret i16 %3
}

declare void @func_ch(i8*)

define i32 @func2() {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = sext i8 %2 to i32
  ret i32 %3
}

define i64 @func3() {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = sext i8 %2 to i64
  ret i64 %3
}

define i128 @func4() {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = sext i8 %2 to i128
  ret i128 %3
}

define zeroext i16 @func5() {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s34, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = sext i8 %2 to i16
  ret i16 %3
}

define i32 @func6() {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = sext i8 %2 to i32
  ret i32 %3
}

define i64 @func7() {
; CHECK-LABEL: func7:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = sext i8 %2 to i64
  ret i64 %3
}

define i128 @func8() {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = sext i8 %2 to i128
  ret i128 %3
}

define signext i16 @func9() {
; CHECK-LABEL: func9:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = zext i8 %2 to i16
  ret i16 %3
}

declare void @func_uch(i8*)

define i32 @func10() {
; CHECK-LABEL: func10:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = zext i8 %2 to i32
  ret i32 %3
}

define i64 @func11() {
; CHECK-LABEL: func11:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = zext i8 %2 to i64
  ret i64 %3
}

define i128 @func12() {
; CHECK-LABEL: func12:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = zext i8 %2 to i128
  ret i128 %3
}

define zeroext i16 @func13() {
; CHECK-LABEL: func13:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = zext i8 %2 to i16
  ret i16 %3
}

define zeroext i16 @func14() {
; CHECK-LABEL: func14:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = zext i8 %2 to i16
  ret i16 %3
}

define i64 @func15() {
; CHECK-LABEL: func15:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = zext i8 %2 to i64
  ret i64 %3
}

define i128 @func16() {
; CHECK-LABEL: func16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 191(,%s11)
  %1 = alloca i8, align 1
  %2 = load i8, i8* %1, align 1, !tbaa !2
  %3 = zext i8 %2 to i128
  ret i128 %3
}

define i32 @func17() {
; CHECK-LABEL: func17:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.sx %s0, 190(,%s11)
  %1 = alloca i16, align 2
  %2 = bitcast i16* %1 to i8*
  %3 = load i16, i16* %1, align 2, !tbaa !5
  %4 = sext i16 %3 to i32
  ret i32 %4
}

declare void @func_sh(i16*)

define i64 @func18() {
; CHECK-LABEL: func18:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.sx %s0, 190(,%s11)
  %1 = alloca i16, align 2
  %2 = bitcast i16* %1 to i8*
  %3 = load i16, i16* %1, align 2, !tbaa !5
  %4 = sext i16 %3 to i64
  ret i64 %4
}

define i128 @func19() {
; CHECK-LABEL: func19:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.sx %s0, 190(,%s11)
  %1 = alloca i16, align 2
  %2 = bitcast i16* %1 to i8*
  %3 = load i16, i16* %1, align 2, !tbaa !5
  %4 = sext i16 %3 to i128
  ret i128 %4
}

define zeroext i16 @func20() {
; CHECK-LABEL: func20:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.zx %s0, 190(,%s11)
  %1 = alloca i16, align 2
  %2 = bitcast i16* %1 to i8*
  %3 = load i16, i16* %1, align 2, !tbaa !5
  ret i16 %3
}

define i64 @func21() {
; CHECK-LABEL: func21:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.sx %s0, 190(,%s11)
  %1 = alloca i16, align 2
  %2 = bitcast i16* %1 to i8*
  %3 = load i16, i16* %1, align 2, !tbaa !5
  %4 = sext i16 %3 to i64
  ret i64 %4
}

define i128 @func22() {
; CHECK-LABEL: func22:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.sx %s0, 190(,%s11)
  %1 = alloca i16, align 2
  %2 = bitcast i16* %1 to i8*
  %3 = load i16, i16* %1, align 2, !tbaa !5
  %4 = sext i16 %3 to i128
  ret i128 %4
}

define i32 @func23() {
; CHECK-LABEL: func23:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.zx %s0, 190(,%s11)
  %1 = alloca i16, align 2
  %2 = bitcast i16* %1 to i8*
  %3 = load i16, i16* %1, align 2, !tbaa !5
  %4 = zext i16 %3 to i32
  ret i32 %4
}

declare void @func_ush(i16*)

define i64 @func24() {
; CHECK-LABEL: func24:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.zx %s0, 190(,%s11)
  %1 = alloca i16, align 2
  %2 = bitcast i16* %1 to i8*
  %3 = load i16, i16* %1, align 2, !tbaa !5
  %4 = zext i16 %3 to i64
  ret i64 %4
}

define i128 @func25() {
; CHECK-LABEL: func25:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.zx %s0, 190(,%s11)
  %1 = alloca i16, align 2
  %2 = bitcast i16* %1 to i8*
  %3 = load i16, i16* %1, align 2, !tbaa !5
  %4 = zext i16 %3 to i128
  ret i128 %4
}

define zeroext i16 @func26() {
; CHECK-LABEL: func26:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.zx %s0, 190(,%s11)
  %1 = alloca i16, align 2
  %2 = bitcast i16* %1 to i8*
  %3 = load i16, i16* %1, align 2, !tbaa !5
  ret i16 %3
}

define i64 @func27() {
; CHECK-LABEL: func27:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.zx %s0, 190(,%s11)
  %1 = alloca i16, align 2
  %2 = bitcast i16* %1 to i8*
  %3 = load i16, i16* %1, align 2, !tbaa !5
  %4 = zext i16 %3 to i64
  ret i64 %4
}

define i128 @func28() {
; CHECK-LABEL: func28:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.zx %s0, 190(,%s11)
  %1 = alloca i16, align 2
  %2 = bitcast i16* %1 to i8*
  %3 = load i16, i16* %1, align 2, !tbaa !5
  %4 = zext i16 %3 to i128
  ret i128 %4
}

define i64 @func29() {
; CHECK-LABEL: func29:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ldl.sx %s0, 188(,%s11)
  %1 = alloca i32, align 4
  %2 = bitcast i32* %1 to i8*
  %3 = load i32, i32* %1, align 4, !tbaa !7
  %4 = sext i32 %3 to i64
  ret i64 %4
}

define i128 @func30() {
; CHECK-LABEL: func30:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ldl.sx %s0, 188(,%s11)
  %1 = alloca i32, align 4
  %2 = bitcast i32* %1 to i8*
  %3 = load i32, i32* %1, align 4, !tbaa !7
  %4 = sext i32 %3 to i128
  ret i128 %4
}

declare void @func_in(i32*)

define i64 @func31() {
; CHECK-LABEL: func31:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ldl.sx %s0, 188(,%s11)
  %1 = alloca i32, align 4
  %2 = bitcast i32* %1 to i8*
  %3 = load i32, i32* %1, align 4, !tbaa !7
  %4 = sext i32 %3 to i64
  ret i64 %4
}

define i128 @func32() {
; CHECK-LABEL: func32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ldl.sx %s0, 188(,%s11)
  %1 = alloca i32, align 4
  %2 = bitcast i32* %1 to i8*
  %3 = load i32, i32* %1, align 4, !tbaa !7
  %4 = sext i32 %3 to i128
  ret i128 %4
}

define i64 @func33() {
; CHECK-LABEL: func33:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ldl.zx %s0, 188(,%s11)
  %1 = alloca i32, align 4
  %2 = bitcast i32* %1 to i8*
  %3 = load i32, i32* %1, align 4, !tbaa !7
  %4 = zext i32 %3 to i64
  ret i64 %4
}

define i128 @func34() {
; CHECK-LABEL: func34:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ldl.zx %s0, 188(,%s11)
  %1 = alloca i32, align 4
  %2 = bitcast i32* %1 to i8*
  %3 = load i32, i32* %1, align 4, !tbaa !7
  %4 = zext i32 %3 to i128
  ret i128 %4
}

declare void @func_uin(i32*)

define i64 @func35() {
; CHECK-LABEL: func35:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ldl.zx %s0, 188(,%s11)
  %1 = alloca i32, align 4
  %2 = bitcast i32* %1 to i8*
  %3 = load i32, i32* %1, align 4, !tbaa !7
  %4 = zext i32 %3 to i64
  ret i64 %4
}

define i128 @func36() {
; CHECK-LABEL: func36:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ldl.zx %s0, 188(,%s11)
  %1 = alloca i32, align 4
  %2 = bitcast i32* %1 to i8*
  %3 = load i32, i32* %1, align 4, !tbaa !7
  %4 = zext i32 %3 to i128
  ret i128 %4
}

define signext i8 @func37() {
; CHECK-LABEL: func37:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s34, 191(,%s11)
; CHECK-NEXT:     sla.w.sx %s34, %s34, 31
; CHECK-NEXT:     sra.w.sx %s0, %s34, 31
  %1 = alloca i1, align 1
  %2 = load i1, i1* %1, align 1, !tbaa !2
  %3 = sext i1 %2 to i8
  ret i8 %3
}

define signext i16 @func38() {
; CHECK-LABEL: func38:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s34, 191(,%s11)
; CHECK-NEXT:     sla.w.sx %s34, %s34, 31
; CHECK-NEXT:     sra.w.sx %s0, %s34, 31
  %1 = alloca i1, align 1
  %2 = load i1, i1* %1, align 1, !tbaa !2
  %3 = sext i1 %2 to i16
  ret i16 %3
}

define signext i32 @func39() {
; CHECK-LABEL: func39:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s34, 191(,%s11)
; CHECK-NEXT:     sla.w.sx %s34, %s34, 31
; CHECK-NEXT:     sra.w.sx %s0, %s34, 31
  %1 = alloca i1, align 1
  %2 = load i1, i1* %1, align 1, !tbaa !2
  %3 = sext i1 %2 to i32
  ret i32 %3
}

define signext i64 @func40() {
; CHECK-LABEL: func40:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s34, 191(,%s11)
; CHECK-NEXT:     sll %s34, %s34, 63
; CHECK-NEXT:     sra.l %s0, %s34, 63
  %1 = alloca i1, align 1
  %2 = load i1, i1* %1, align 1, !tbaa !2
  %3 = sext i1 %2 to i64
  ret i64 %3
}

define signext i128 @func41() {
; CHECK-LABEL: func41:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s34, 191(,%s11)
; CHECK-NEXT:     sll %s34, %s34, 63
; CHECK-NEXT:     sra.l %s0, %s34, 63
  %1 = alloca i1, align 1
  %2 = load i1, i1* %1, align 1, !tbaa !2
  %3 = sext i1 %2 to i128
  ret i128 %3
}

define signext i8 @func42() {
; CHECK-LABEL: func42:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 191(,%s11)
  %1 = alloca i1, align 1
  %2 = load i1, i1* %1, align 1, !tbaa !2
  %3 = zext i1 %2 to i8
  ret i8 %3
}

define signext i16 @func43() {
; CHECK-LABEL: func43:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 191(,%s11)
  %1 = alloca i1, align 1
  %2 = load i1, i1* %1, align 1, !tbaa !2
  %3 = zext i1 %2 to i16
  ret i16 %3
}

define signext i32 @func44() {
; CHECK-LABEL: func44:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 191(,%s11)
  %1 = alloca i1, align 1
  %2 = load i1, i1* %1, align 1, !tbaa !2
  %3 = zext i1 %2 to i32
  ret i32 %3
}

define signext i64 @func45() {
; CHECK-LABEL: func45:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 191(,%s11)
  %1 = alloca i1, align 1
  %2 = load i1, i1* %1, align 1, !tbaa !2
  %3 = zext i1 %2 to i64
  ret i64 %3
}

define signext i128 @func46() {
; CHECK-LABEL: func46:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 191(,%s11)
  %1 = alloca i1, align 1
  %2 = load i1, i1* %1, align 1, !tbaa !2
  %3 = zext i1 %2 to i128
  ret i128 %3
}

define i128 @func47() {
; CHECK-LABEL: func47:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s0, 184(,%s11)
  %1 = alloca i64, align 8
  %2 = bitcast i64* %1 to i8*
  %3 = load i64, i64* %1, align 8, !tbaa !9
  %4 = sext i64 %3 to i128
  ret i128 %4
}

declare void @func_ll(i64*)

define i128 @func48() {
; CHECK-LABEL: func48:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s0, 184(,%s11)
  %1 = alloca i64, align 8
  %2 = bitcast i64* %1 to i8*
  %3 = load i64, i64* %1, align 8, !tbaa !9
  %4 = sext i64 %3 to i128
  ret i128 %4
}

define i128 @func49() {
; CHECK-LABEL: func49:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s0, 184(,%s11)
  %1 = alloca i64, align 8
  %2 = bitcast i64* %1 to i8*
  %3 = load i64, i64* %1, align 8, !tbaa !9
  %4 = zext i64 %3 to i128
  ret i128 %4
}

declare void @func_ull(i64*)

define i128 @func50() {
; CHECK-LABEL: func50:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s0, 184(,%s11)
  %1 = alloca i64, align 8
  %2 = bitcast i64* %1 to i8*
  %3 = load i64, i64* %1, align 8, !tbaa !9
  %4 = zext i64 %3 to i128
  ret i128 %4
}

!2 = !{!3, !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = !{!6, !6, i64 0}
!6 = !{!"short", !3, i64 0}
!7 = !{!8, !8, i64 0}
!8 = !{!"int", !3, i64 0}
!9 = !{!10, !10, i64 0}
!10 = !{!"long long", !3, i64 0}
