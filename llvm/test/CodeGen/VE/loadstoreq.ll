; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readonly
define dso_local fp128 @loadq(fp128* nocapture readonly) local_unnamed_addr #0 {
; CHECK-LABEL: loadq:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s34, (,%s0)
; CHECK-NEXT:    ld %s35, 8(,%s0)
; CHECK-NEXT:    or %s0, 0, %s34
; CHECK-NEXT:    or %s1, 0, %s35
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = load fp128, fp128* %0, align 16, !tbaa !2
  ret fp128 %2
}

; Function Attrs: norecurse nounwind
define dso_local void @storeq(fp128* nocapture, fp128) local_unnamed_addr #1 {
; CHECK-LABEL: storeq:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    st %s3, 8(,%s0)
; CHECK-NEXT:    st %s2, (,%s0)
; CHECK-NEXT:    or %s11, 0, %s9
  store fp128 %1, fp128* %0, align 16, !tbaa !2
  ret void
}

; Function Attrs: norecurse nounwind
define dso_local void @ld_l_arg(i8*, fp128, i64, i64, i64, fp128, i64, fp128, i64) local_unnamed_addr #1 {
; CHECK-LABEL: ld_l_arg:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s34, 272(,%s9)
; CHECK-NEXT:    lea %s36,272(,%s9)
; CHECK-NEXT:    or %s36, 8, %s36
; CHECK-NEXT:    ld %s35, (,%s36)
; CHECK-NEXT:    ld %s36, 240(,%s9)
; CHECK-NEXT:    lea %s38,240(,%s9)
; CHECK-NEXT:    or %s38, 8, %s38
; CHECK-NEXT:    ld %s37, (,%s38)
; CHECK-NEXT:    ld %s38, 288(,%s9)
; CHECK-NEXT:    ld %s39, 256(,%s9)
; CHECK-NEXT:    st %s3, 8(,%s0)
; CHECK-NEXT:    st %s2, (,%s0)
; CHECK-NEXT:    st %s4, (,%s0)
; CHECK-NEXT:    st %s5, (,%s0)
; CHECK-NEXT:    st %s6, (,%s0)
; CHECK-NEXT:    st %s37, 8(,%s0)
; CHECK-NEXT:    st %s36, (,%s0)
; CHECK-NEXT:    st %s39, (,%s0)
; CHECK-NEXT:    st %s35, 8(,%s0)
; CHECK-NEXT:    st %s34, (,%s0)
; CHECK-NEXT:    st %s38, (,%s0)
; CHECK-NEXT:    or %s11, 0, %s9
  %10 = bitcast i8* %0 to fp128*
  store volatile fp128 %1, fp128* %10, align 16, !tbaa !2
  %11 = bitcast i8* %0 to i64*
  store volatile i64 %2, i64* %11, align 8, !tbaa !6
  store volatile i64 %3, i64* %11, align 8, !tbaa !6
  store volatile i64 %4, i64* %11, align 8, !tbaa !6
  store volatile fp128 %5, fp128* %10, align 16, !tbaa !2
  store volatile i64 %6, i64* %11, align 8, !tbaa !6
  store volatile fp128 %7, fp128* %10, align 16, !tbaa !2
  store volatile i64 %8, i64* %11, align 8, !tbaa !6
  ret void
}

attributes #0 = { norecurse nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { norecurse nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 7.0.0 (https://github.com/llvm-mirror/clang.git 85f4d20fbaa66ed83f9fe688403dc8767b9d004a) (https://github.com/llvm-mirror/llvm.git 80af48ed03ca687a7cf3ebe95594fb1f166aaff2)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"long double", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!7, !7, i64 0}
!7 = !{!"long", !4, i64 0}
