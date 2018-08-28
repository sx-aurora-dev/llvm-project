; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define dso_local i64 @func1(i64) local_unnamed_addr #0 {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    pcnt %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i64 @llvm.ctpop.i64(i64 %0), !range !2
  ret i64 %2
}

declare i64 @llvm.ctpop.i64(i64) #1

define dso_local i32 @func2(i32) local_unnamed_addr #0 {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    and %s34, %s0, (32)0
; CHECK-NEXT:    pcnt %s0, %s34
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i32 @llvm.ctpop.i32(i32 %0), !range !3
  ret i32 %2
}

declare i32 @llvm.ctpop.i32(i32) #1

define dso_local i16 @func3(i16) local_unnamed_addr #0 {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s34, %s0, (48)0
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    pcnt %s0, %s34
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i16 @llvm.ctpop.i16(i16 %0), !range !4
  ret i16 %2
}

declare i16 @llvm.ctpop.i16(i16) #1

define dso_local i8 @func4(i8) local_unnamed_addr #0 {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s34, %s0, (56)0
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    pcnt %s0, %s34
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i8 @llvm.ctpop.i8(i8 %0), !range !5
  ret i8 %2
}

declare i8 @llvm.ctpop.i8(i8) #1

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 7.0.0 (git@socsv218.svp.cl.nec.co.jp:ve-llvm/clang.git 45a0446036e52c047bb827e6344023404a3c09fc) (llvm/llvm.git 45c9af272fee6265d41f270cdac88feb5971962c)"}
!2 = !{i64 0, i64 65}
!3 = !{i32 0, i32 33}
!4 = !{i16 0, i16 17}
!5 = !{i8 0, i8 9}
