; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind readonly
define i64 @test(float* readonly %pValue, i64 %distance) {
; CHECK-LABEL: test
; CHECK: .LBB0_2:
; CHECK-NEXT: sll %s34, %s1, 2
; CHECK-NEXT: adds.l %s34, %s0, %s34
; CHECK-NEXT: ldu %s35, (,%s0)
; CHECK-NEXT: ldl.zx %s34, (,%s34)
; CHECK-NEXT: or %s0, %s35, %s34
; CHECK-NEXT: or %s11, 0, %s9

entry:
  %0 = bitcast float* %pValue to i8*
  %add.ptr = getelementptr inbounds float, float* %pValue, i64 %distance
  %1 = bitcast float* %add.ptr to i8*
  %2 = tail call i64 @llvm.ve.vl.pack.f32p(i8* %0, i8* %1)
  ret i64 %2
}

; Function Attrs: nounwind readonly
declare i64 @llvm.ve.vl.pack.f32p(i8*, i8*)

