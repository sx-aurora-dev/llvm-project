; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

%struct.a = type { i32, i32 }

@A = common global %struct.a zeroinitializer, align 4

; Function Attrs: norecurse nounwind
define void @fun(%struct.a* noalias nocapture sret, i32, i32) {
; CHECK-LABEL: fun:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    stl %s1, (,%s0)
; CHECK-NEXT:    stl %s2, 4(,%s0)
; CHECK-NEXT:    or %s11, 0, %s9
  %4 = getelementptr inbounds %struct.a, %struct.a* %0, i64 0, i32 0
  store i32 %1, i32* %4, align 4, !tbaa !2
  %5 = getelementptr inbounds %struct.a, %struct.a* %0, i64 0, i32 1
  store i32 %2, i32* %5, align 4, !tbaa !7
  ret void
}

; Function Attrs: nounwind
define void @caller() {
; CHECK-LABEL: caller:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, callee@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, callee@hi(%s34)
; CHECK-NEXT:    lea %s0,-8(,%s9)
; CHECK-NEXT:    or %s1, 3, (0)1
; CHECK-NEXT:    or %s2, 4, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    ld %s34, -8(,%s9)
; CHECK-NEXT:    lea %s35, A@lo
; CHECK-NEXT:    and %s35, %s35, (32)0
; CHECK-NEXT:    lea.sl %s35, A@hi(%s35)
; CHECK-NEXT:    stl %s34, (,%s35)
; CHECK-NEXT:    srl %s34, %s34, 32
; CHECK-NEXT:    stl %s34, 4(,%s35)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = alloca i64, align 8
  %2 = bitcast i64* %1 to %struct.a*
  %3 = bitcast i64* %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3)
  call void @callee(%struct.a* nonnull sret %2, i32 3, i32 4)
  %4 = load i64, i64* %1, align 8
  store i64 %4, i64* bitcast (%struct.a* @A to i64*), align 4
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture)

declare void @callee(%struct.a* sret, i32, i32)

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture)

!2 = !{!3, !4, i64 0}
!3 = !{!"a", !4, i64 0, !4, i64 4}
!4 = !{!"int", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = !{!3, !4, i64 4}
