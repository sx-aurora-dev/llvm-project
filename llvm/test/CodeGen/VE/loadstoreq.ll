; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readonly
define fp128 @loadq(fp128* nocapture readonly) {
; CHECK-LABEL: loadq:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s34, 8(,%s0)
; CHECK-NEXT:    ld %s35, (,%s0)
; CHECK-NEXT:    or %s0, 0, %s34
; CHECK-NEXT:    or %s1, 0, %s35
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = load fp128, fp128* %0, align 16, !tbaa !2
  ret fp128 %2
}

; Function Attrs: norecurse nounwind
define void @storeq(fp128* nocapture, fp128) {
; CHECK-LABEL: storeq:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    st %s2, 8(,%s0)
; CHECK-NEXT:    st %s3, (,%s0)
; CHECK-NEXT:    or %s11, 0, %s9
  store fp128 %1, fp128* %0, align 16, !tbaa !2
  ret void
}

; Function Attrs: norecurse nounwind
define void @ld_l_arg(i8*, fp128, i64, i64, i64, fp128, i64, fp128, i64) {
; CHECK-LABEL: ld_l_arg:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34,448(,%s11)
; CHECK-NEXT:    or %s34, 8, %s34
; CHECK-NEXT:    ld %s34, (,%s34)
; CHECK-NEXT:    ld %s35, 448(,%s11)
; CHECK-NEXT:    lea %s36,416(,%s11)
; CHECK-NEXT:    or %s36, 8, %s36
; CHECK-NEXT:    ld %s36, (,%s36)
; CHECK-NEXT:    ld %s37, 416(,%s11)
; CHECK-NEXT:    ld %s38, 464(,%s11)
; CHECK-NEXT:    ld %s39, 432(,%s11)
; CHECK-NEXT:    st %s2, 8(,%s0)
; CHECK-NEXT:    st %s3, (,%s0)
; CHECK-NEXT:    st %s4, (,%s0)
; CHECK-NEXT:    st %s5, (,%s0)
; CHECK-NEXT:    st %s6, (,%s0)
; CHECK-NEXT:    st %s36, 8(,%s0)
; CHECK-NEXT:    st %s37, (,%s0)
; CHECK-NEXT:    st %s39, (,%s0)
; CHECK-NEXT:    st %s34, 8(,%s0)
; CHECK-NEXT:    st %s35, (,%s0)
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

!2 = !{!3, !3, i64 0}
!3 = !{!"long double", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!7, !7, i64 0}
!7 = !{!"long", !4, i64 0}
