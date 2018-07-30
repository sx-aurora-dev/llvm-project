; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; ModuleID = 'src/callstruct.c'
source_filename = "src/callstruct.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v16384:64:64"
target triple = "ve"

%struct.a = type { i32, i32 }

@A = common dso_local local_unnamed_addr global %struct.a zeroinitializer, align 4

; Function Attrs: norecurse nounwind
define dso_local void @fun(%struct.a* noalias nocapture sret, i32, i32) local_unnamed_addr #0 {
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
define dso_local void @caller() local_unnamed_addr #1 {
; CHECK-LABEL: caller:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, %lo(callee)
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, %hi(callee)(%s34)
; CHECK-NEXT:    lea %s0,-8(,%s9)
; CHECK-NEXT:    or %s1, 3, (0)1
; CHECK-NEXT:    or %s2, 4, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    ld %s34, -8(,%s9)
; CHECK-NEXT:    lea.sl %s35, %hi(A)
; CHECK-NEXT:    stl %s34, %lo(A)(,%s35)
; CHECK-NEXT:    lea %s35, %lo(A)
; CHECK-NEXT:    and %s35, %s35, (32)0
; CHECK-NEXT:    lea.sl %s35, %hi(A)(%s35)
; CHECK-NEXT:    srl %s34, %s34, 32
; CHECK-NEXT:    stl %s34, 4(,%s35)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = alloca i64, align 8
  %2 = bitcast i64* %1 to %struct.a*
  %3 = bitcast i64* %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3) #4
  call void @callee(%struct.a* nonnull sret %2, i32 3, i32 4) #4
  %4 = load i64, i64* %1, align 8
  store i64 %4, i64* bitcast (%struct.a* @A to i64*), align 4
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3) #4
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #2

declare dso_local void @callee(%struct.a* sret, i32, i32) local_unnamed_addr #3

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #2

attributes #0 = { norecurse nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 7.0.0 (https://github.com/llvm-mirror/clang.git d326119e3a71593369edd97e642577b570bf7c32) (https://github.com/llvm-mirror/llvm.git ec537259afcab671cb7eaf08abba9c2ec8b60640)"}
!2 = !{!3, !4, i64 0}
!3 = !{!"a", !4, i64 0, !4, i64 4}
!4 = !{!"int", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = !{!3, !4, i64 4}
