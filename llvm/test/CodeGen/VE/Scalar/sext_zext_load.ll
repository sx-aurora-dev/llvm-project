; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define signext i16 @func1() {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s0, 15(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i8, align 1
  %a.val = load i8, ptr %a, align 1
  %a.conv = sext i8 %a.val to i16
  ret i16 %a.conv
}

define signext i32 @func2() {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s0, 15(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i8, align 1
  %a.val = load i8, ptr %a, align 1
  %a.conv = sext i8 %a.val to i32
  ret i32 %a.conv
}

define i64 @func3() {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s0, 15(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i8, align 1
  %a.val = load i8, ptr %a, align 1
  %a.conv = sext i8 %a.val to i64
  ret i64 %a.conv
}

define i128 @func4() {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s0, 15(, %s11)
; CHECK-NEXT:    sra.l %s1, %s0, 63
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i8, align 1
  %a.val = load i8, i8* %a, align 1
  %a.conv = sext i8 %a.val to i128
  ret i128 %a.conv
}

define zeroext i16 @func5() {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s0, 15(, %s11)
; CHECK-NEXT:    and %s0, %s0, (48)0
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i8, align 1
  %a.val = load i8, ptr %a, align 1
  %a.conv = sext i8 %a.val to i16
  ret i16 %a.conv
}

define zeroext i32 @func6() {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s0, 15(, %s11)
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i8, align 1
  %a.val = load i8, ptr %a, align 1
  %a.conv = sext i8 %a.val to i32
  ret i32 %a.conv
}

define i64 @func7() {
; CHECK-LABEL: func7:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s0, 15(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i8, align 1
  %a.val = load i8, ptr %a, align 1
  %a.conv = sext i8 %a.val to i64
  ret i64 %a.conv
}

define i128 @func8() {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.sx %s0, 15(, %s11)
; CHECK-NEXT:    sra.l %s1, %s0, 63
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i8, align 1
  %a.val = load i8, i8* %a, align 1
  %a.conv = sext i8 %a.val to i128
  ret i128 %a.conv
}

define signext i16 @func9() {
; CHECK-LABEL: func9:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 15(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i8, align 1
  %a.val = load i8, ptr %a, align 1
  %a.conv = zext i8 %a.val to i16
  ret i16 %a.conv
}

define signext i32 @func10() {
; CHECK-LABEL: func10:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 15(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i8, align 1
  %a.val = load i8, ptr %a, align 1
  %a.conv = zext i8 %a.val to i32
  ret i32 %a.conv
}

define i64 @func11() {
; CHECK-LABEL: func11:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 15(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i8, align 1
  %a.val = load i8, ptr %a, align 1
  %a.conv = zext i8 %a.val to i64
  ret i64 %a.conv
}

define i128 @func12() {
; CHECK-LABEL: func12:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 15(, %s11)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i8, align 1
  %a.val = load i8, i8* %a, align 1
  %a.conv = zext i8 %a.val to i128
  ret i128 %a.conv
}

define zeroext i16 @func13() {
; CHECK-LABEL: func13:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 15(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i8, align 1
  %a.val = load i8, ptr %a, align 1
  %a.conv = zext i8 %a.val to i16
  ret i16 %a.conv
}

define zeroext i16 @func14() {
; CHECK-LABEL: func14:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 15(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i8, align 1
  %a.val = load i8, ptr %a, align 1
  %a.conv = zext i8 %a.val to i16
  ret i16 %a.conv
}

define i64 @func15() {
; CHECK-LABEL: func15:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 15(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i8, align 1
  %a.val = load i8, ptr %a, align 1
  %a.conv = zext i8 %a.val to i64
  ret i64 %a.conv
}

define i128 @func16() {
; CHECK-LABEL: func16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 15(, %s11)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i8, align 1
  %a.val = load i8, i8* %a, align 1
  %a.conv = zext i8 %a.val to i128
  ret i128 %a.conv
}

define signext i32 @func17() {
; CHECK-LABEL: func17:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.sx %s0, 14(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i16, align 2
  %a.val = load i16, ptr %a, align 2
  %a.conv = sext i16 %a.val to i32
  ret i32 %a.conv
}

define i64 @func18() {
; CHECK-LABEL: func18:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.sx %s0, 14(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i16, align 2
  %a.val = load i16, ptr %a, align 2
  %a.conv = sext i16 %a.val to i64
  ret i64 %a.conv
}

define i128 @func19() {
; CHECK-LABEL: func19:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.sx %s0, 14(, %s11)
; CHECK-NEXT:    sra.l %s1, %s0, 63
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i16, align 2
  %a.val = load i16, i16* %a, align 2
  %a.conv = sext i16 %a.val to i128
  ret i128 %a.conv
}

define zeroext i16 @func20() {
; CHECK-LABEL: func20:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.zx %s0, 14(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i16, align 2
  %a.conv = load i16, ptr %a, align 2
  ret i16 %a.conv
}

define i64 @func21() {
; CHECK-LABEL: func21:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.sx %s0, 14(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i16, align 2
  %a.val = load i16, ptr %a, align 2
  %a.conv = sext i16 %a.val to i64
  ret i64 %a.conv
}

define i128 @func22() {
; CHECK-LABEL: func22:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.sx %s0, 14(, %s11)
; CHECK-NEXT:    sra.l %s1, %s0, 63
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i16, align 2
  %a.val = load i16, i16* %a, align 2
  %a.conv = sext i16 %a.val to i128
  ret i128 %a.conv
}

define zeroext i32 @func23() {
; CHECK-LABEL: func23:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.zx %s0, 14(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i16, align 2
  %a.val = load i16, ptr %a, align 2
  %a.conv = zext i16 %a.val to i32
  ret i32 %a.conv
}

define i64 @func24() {
; CHECK-LABEL: func24:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.zx %s0, 14(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i16, align 2
  %a.val = load i16, ptr %a, align 2
  %a.conv = zext i16 %a.val to i64
  ret i64 %a.conv
}

define i128 @func25() {
; CHECK-LABEL: func25:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.zx %s0, 14(, %s11)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i16, align 2
  %a.val = load i16, i16* %a, align 2
  %a.conv = zext i16 %a.val to i128
  ret i128 %a.conv
}

define zeroext i16 @func26() {
; CHECK-LABEL: func26:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.zx %s0, 14(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i16, align 2
  %a.conv = load i16, ptr %a, align 2
  ret i16 %a.conv
}

define i64 @func27() {
; CHECK-LABEL: func27:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.zx %s0, 14(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i16, align 2
  %a.val = load i16, ptr %a, align 2
  %a.conv = zext i16 %a.val to i64
  ret i64 %a.conv
}

define i128 @func28() {
; CHECK-LABEL: func28:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld2b.zx %s0, 14(, %s11)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i16, align 2
  %a.val = load i16, i16* %a, align 2
  %a.conv = zext i16 %a.val to i128
  ret i128 %a.conv
}

define i64 @func29() {
; CHECK-LABEL: func29:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ldl.sx %s0, 12(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i32, align 4
  %a.val = load i32, ptr %a, align 4
  %a.conv = sext i32 %a.val to i64
  ret i64 %a.conv
}

define i128 @func30() {
; CHECK-LABEL: func30:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ldl.sx %s0, 12(, %s11)
; CHECK-NEXT:    sra.l %s1, %s0, 63
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i32, align 4
  %a.val = load i32, i32* %a, align 4
  %a.conv = sext i32 %a.val to i128
  ret i128 %a.conv
}

define i64 @func31() {
; CHECK-LABEL: func31:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ldl.sx %s0, 12(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i32, align 4
  %a.val = load i32, ptr %a, align 4
  %a.conv = sext i32 %a.val to i64
  ret i64 %a.conv
}

define i128 @func32() {
; CHECK-LABEL: func32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ldl.sx %s0, 12(, %s11)
; CHECK-NEXT:    sra.l %s1, %s0, 63
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i32, align 4
  %a.val = load i32, i32* %a, align 4
  %a.conv = sext i32 %a.val to i128
  ret i128 %a.conv
}

define i64 @func33() {
; CHECK-LABEL: func33:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ldl.zx %s0, 12(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i32, align 4
  %a.val = load i32, ptr %a, align 4
  %a.conv = zext i32 %a.val to i64
  ret i64 %a.conv
}

define i128 @func34() {
; CHECK-LABEL: func34:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ldl.zx %s0, 12(, %s11)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i32, align 4
  %a.val = load i32, i32* %a, align 4
  %a.conv = zext i32 %a.val to i128
  ret i128 %a.conv
}

define i64 @func35() {
; CHECK-LABEL: func35:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ldl.zx %s0, 12(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i32, align 4
  %a.val = load i32, ptr %a, align 4
  %a.conv = zext i32 %a.val to i64
  ret i64 %a.conv
}

define i128 @func36() {
; CHECK-LABEL: func36:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ldl.zx %s0, 12(, %s11)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i32, align 4
  %a.val = load i32, i32* %a, align 4
  %a.conv = zext i32 %a.val to i128
  ret i128 %a.conv
}

define signext i8 @func37() {
; CHECK-LABEL: func37:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 15(, %s11)
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    subs.l %s0, 0, %s0
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i1, align 1
  %a.val = load i1, ptr %a, align 1
  %a.conv = sext i1 %a.val to i8
  ret i8 %a.conv
}

define signext i16 @func38() {
; CHECK-LABEL: func38:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 15(, %s11)
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    subs.l %s0, 0, %s0
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i1, align 1
  %a.val = load i1, ptr %a, align 1
  %a.conv = sext i1 %a.val to i16
  ret i16 %a.conv
}

define signext i32 @func39() {
; CHECK-LABEL: func39:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 15(, %s11)
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    subs.l %s0, 0, %s0
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i1, align 1
  %a.val = load i1, ptr %a, align 1
  %a.conv = sext i1 %a.val to i32
  ret i32 %a.conv
}

define signext i64 @func40() {
; CHECK-LABEL: func40:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 15(, %s11)
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    subs.l %s0, 0, %s0
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i1, align 1
  %a.val = load i1, ptr %a, align 1
  %a.conv = sext i1 %a.val to i64
  ret i64 %a.conv
}

define signext i128 @func41() {
; CHECK-LABEL: func41:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 15(, %s11)
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    subs.l %s0, 0, %s0
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i1, align 1
  %a.val = load i1, i1* %a, align 1
  %a.conv = sext i1 %a.val to i128
  ret i128 %a.conv
}

define signext i8 @func42() {
; CHECK-LABEL: func42:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 15(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i1, align 1
  %a.val = load i1, ptr %a, align 1
  %a.conv = zext i1 %a.val to i8
  ret i8 %a.conv
}

define signext i16 @func43() {
; CHECK-LABEL: func43:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 15(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i1, align 1
  %a.val = load i1, ptr %a, align 1
  %a.conv = zext i1 %a.val to i16
  ret i16 %a.conv
}

define signext i32 @func44() {
; CHECK-LABEL: func44:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 15(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i1, align 1
  %a.val = load i1, ptr %a, align 1
  %a.conv = zext i1 %a.val to i32
  ret i32 %a.conv
}

define signext i64 @func45() {
; CHECK-LABEL: func45:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 15(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i1, align 1
  %a.val = load i1, ptr %a, align 1
  %a.conv = zext i1 %a.val to i64
  ret i64 %a.conv
}

define signext i128 @func46() {
; CHECK-LABEL: func46:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld1b.zx %s0, 15(, %s11)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i1, align 1
  %a.val = load i1, i1* %a, align 1
  %a.conv = zext i1 %a.val to i128
  ret i128 %a.conv
}

define i128 @func47() {
; CHECK-LABEL: func47:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s0, 8(, %s11)
; CHECK-NEXT:    sra.l %s1, %s0, 63
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i64, align 8
  %a.val = load i64, i64* %a, align 8
  %a.conv = sext i64 %a.val to i128
  ret i128 %a.conv
}

define i128 @func48() {
; CHECK-LABEL: func48:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s0, 8(, %s11)
; CHECK-NEXT:    sra.l %s1, %s0, 63
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i64, align 8
  %a.val = load i64, i64* %a, align 8
  %a.conv = sext i64 %a.val to i128
  ret i128 %a.conv
}

define i128 @func49() {
; CHECK-LABEL: func49:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s0, 8(, %s11)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i64, align 8
  %a.val = load i64, i64* %a, align 8
  %a.conv = zext i64 %a.val to i128
  ret i128 %a.conv
}

define i128 @func50() {
; CHECK-LABEL: func50:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s0, 8(, %s11)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %a = alloca i64, align 8
  %a.val = load i64, i64* %a, align 8
  %a.conv = zext i64 %a.val to i128
  ret i128 %a.conv
}
