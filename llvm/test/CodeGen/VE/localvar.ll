; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

@p = external dso_local local_unnamed_addr global double*, align 8

; Function Attrs: nounwind
define dso_local void @test(i32) local_unnamed_addr #0 {
; CHECK-LABEL: test:
; CHECK:       .LBB0_2:
; CHECK-NEXT:    st %s18, 48(,%s9)               # 8-byte Folded Spill
; CHECK-NEXT:    or %s18, 0, %s0
; CHECK-NEXT:    adds.w.zx %s34, %s0, (0)1
; CHECK-NEXT:    sll %s34, %s34, 3
; CHECK-NEXT:    lea %s34, 15(%s34)
; CHECK-NEXT:    lea %s35, -16
; CHECK-NEXT:    and %s35, %s35, (32)0
; CHECK-NEXT:    lea.sl %s35, 15(%s35)
; CHECK-NEXT:    and %s0, %s34, %s35
; CHECK-NEXT:    adds.l %s11, -64, %s11
; CHECK-NEXT:    lea %s34, %lo(__grow_stack)
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, %hi(__grow_stack)(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    lea %s13, 64
; CHECK-NEXT:    and %s13, %s13, (32)0
; CHECK-NEXT:    lea.sl %s11, 0(%s11, %s13)
; CHECK-NEXT:    lea.sl %s34, %hi(p)
; CHECK-NEXT:    ld %s0, %lo(p)(,%s34)
; CHECK-NEXT:    lea %s1, 176(%s11)
; CHECK-NEXT:    adds.w.sx %s34, %s18, (0)1
; CHECK-NEXT:    sll %s2, %s34, 3
; CHECK-NEXT:    adds.l %s11, -64, %s11
; CHECK-NEXT:    lea %s34, %lo(memcpy)
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, %hi(memcpy)(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
  %2 = zext i32 %0 to i64
  %3 = alloca double, i64 %2, align 8
  %4 = load i8*, i8** bitcast (double** @p to i8**), align 8, !tbaa !2
  %5 = bitcast double* %3 to i8*
  %6 = sext i32 %0 to i64
  %7 = shl nsw i64 %6, 3
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %4, i8* nonnull align 8 %5, i64 %7, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1) #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 8.0.0 (https://github.com/llvm-mirror/clang.git 8ac29e6baf2b9a5aa59f1a1d9b75d2bf8c566d8f) (https://github.com/llvm-mirror/llvm.git f4ef29896b171e346c1c9fbee7184bbce7d9bb44)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"any pointer", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
