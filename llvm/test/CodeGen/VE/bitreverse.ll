; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define dso_local i64 @func1(i64) local_unnamed_addr #0 {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    brv %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i64 @llvm.bitreverse.i64(i64 %0)
  ret i64 %2
}

declare i64 @llvm.bitreverse.i64(i64) #1

define dso_local i32 @func2(i32) local_unnamed_addr #0 {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    brv %s34, %s0
; CHECK-NEXT:    srl %s0, %s34, 32
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i32 @llvm.bitreverse.i32(i32 %0)
  ret i32 %2
}

declare i32 @llvm.bitreverse.i32(i32) #1

define dso_local signext i16 @func3(i16 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    brv %s34, %s0
; CHECK-NEXT:    srl %s34, %s34, 32
; CHECK-NEXT:    sra.w.sx %s0, %s34, 16
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i16 @llvm.bitreverse.i16(i16 %0)
  ret i16 %2
}

declare i16 @llvm.bitreverse.i16(i16) #1

define dso_local signext i8 @func4(i8 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    brv %s34, %s0
; CHECK-NEXT:    srl %s34, %s34, 32
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i8 @llvm.bitreverse.i8(i8 %0)
  ret i8 %2
}

declare i8 @llvm.bitreverse.i8(i8) #1

define dso_local i64 @func5(i64) local_unnamed_addr #0 {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    brv %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i64 @llvm.bitreverse.i64(i64 %0)
  ret i64 %2
}

define dso_local i32 @func6(i32) local_unnamed_addr #0 {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    brv %s34, %s0
; CHECK-NEXT:    srl %s0, %s34, 32
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
  %2 = tail call i32 @llvm.bitreverse.i32(i32 %0)
  ret i32 %2
}

define dso_local zeroext i16 @func7(i16 zeroext) local_unnamed_addr #0 {
; CHECK-LABEL: func7:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    brv %s34, %s0
; CHECK-NEXT:    srl %s34, %s34, 32
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    srl %s0, %s34, 16
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i16 @llvm.bitreverse.i16(i16 %0)
  ret i16 %2
}

define dso_local zeroext i8 @func8(i8 zeroext) local_unnamed_addr #0 {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    brv %s34, %s0
; CHECK-NEXT:    srl %s34, %s34, 32
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    srl %s0, %s34, 24
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i8 @llvm.bitreverse.i8(i8 %0)
  ret i8 %2
}

attributes #0 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 7.0.0 (git@socsv218.svp.cl.nec.co.jp:ve-llvm/clang.git 45a0446036e52c047bb827e6344023404a3c09fc) (llvm/llvm.git 45c9af272fee6265d41f270cdac88feb5971962c)"}
