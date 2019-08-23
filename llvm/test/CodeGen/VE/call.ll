; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i32 @sample_call() {
; CHECK-LABEL: sample_call:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, sample_add@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, sample_add@hi(%s34)
; CHECK-NEXT:    or %s0, 1, (0)1
; CHECK-NEXT:    or %s1, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
  %1 = tail call i32 @sample_add(i32 1, i32 2)
  ret i32 %1
}

declare i32 @sample_add(i32, i32)

define i32 @stack_call_int() {
; CHECK-LABEL: stack_call_int:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s34, 10, (0)1
; CHECK-NEXT:  stl %s34, 248(,%s11)
; CHECK-NEXT:  or %s34, 9, (0)1
; CHECK-NEXT:  lea %s35, stack_callee_int@lo
; CHECK-NEXT:  and %s35, %s35, (32)0
; CHECK-NEXT:  lea.sl %s12, stack_callee_int@hi(%s35)
; CHECK-NEXT:  or %s0, 1, (0)1
; CHECK-NEXT:  or %s1, 2, (0)1
; CHECK-NEXT:  or %s2, 3, (0)1
; CHECK-NEXT:  or %s3, 4, (0)1
; CHECK-NEXT:  or %s4, 5, (0)1
; CHECK-NEXT:  or %s5, 6, (0)1
; CHECK-NEXT:  or %s6, 7, (0)1
; CHECK-NEXT:  or %s7, 8, (0)1
; CHECK-NEXT:  stl %s34, 240(,%s11)
; CHECK-NEXT:  bsic %lr, (,%s12)
; CHECK-NEXT:  or %s11, 0, %s9
  %1 = tail call i32 @stack_callee_int(i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10)
  ret i32 %1
}

declare i32 @stack_callee_int(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)

define float @stack_call_float() {
; CHECK-LABEL: stack_call_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 1092616192
; CHECK-NEXT:  stl %s34, 252(,%s11)
; CHECK-NEXT:  lea %s34, 1091567616
; CHECK-NEXT:  lea %s35, stack_callee_float@lo
; CHECK-NEXT:  and %s35, %s35, (32)0
; CHECK-NEXT:  lea.sl %s12, stack_callee_float@hi(%s35)
; CHECK-NEXT:  lea.sl %s35, 1065353216
; CHECK-NEXT:  lea.sl %s36, 1073741824
; CHECK-NEXT:  lea.sl %s37, 1077936128
; CHECK-NEXT:  lea.sl %s38, 1082130432
; CHECK-NEXT:  lea.sl %s39, 1084227584
; CHECK-NEXT:  lea.sl %s40, 1086324736
; CHECK-NEXT:  lea.sl %s41, 1088421888
; CHECK-NEXT:  lea.sl %s42, 1090519040
; CHECK-NEXT:  stl %s34, 244(,%s11)
; CHECK-NEXT:  or %s0, 0, %s35
; CHECK-NEXT:  or %s1, 0, %s36
; CHECK-NEXT:  or %s2, 0, %s37
; CHECK-NEXT:  or %s3, 0, %s38
; CHECK-NEXT:  or %s4, 0, %s39
; CHECK-NEXT:  or %s5, 0, %s40
; CHECK-NEXT:  or %s6, 0, %s41
; CHECK-NEXT:  or %s7, 0, %s42
; CHECK-NEXT:  bsic %lr, (,%s12)
; CHECK-NEXT:  or %s11, 0, %s9
  %1 = tail call float @stack_callee_float(float 1.0, float 2.0, float 3.0, float 4.0, float 5.0, float 6.0, float 7.0, float 8.0, float 9.0, float 10.0)
  ret float %1
}

declare float @stack_callee_float(float, float, float, float, float, float, float, float, float, float)

define float @stack_call_float2(float) {
; CHECK-LABEL: stack_call_float2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  stu %s0, 252(,%s11)
; CHECK-NEXT:  lea %s34, stack_callee_float@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s12, stack_callee_float@hi(%s34)
; CHECK-NEXT:  stu %s0, 244(,%s11)
; CHECK-NEXT:  or %s1, 0, %s0
; CHECK-NEXT:  or %s2, 0, %s0
; CHECK-NEXT:  or %s3, 0, %s0
; CHECK-NEXT:  or %s4, 0, %s0
; CHECK-NEXT:  or %s5, 0, %s0
; CHECK-NEXT:  or %s6, 0, %s0
; CHECK-NEXT:  or %s7, 0, %s0
; CHECK-NEXT:  bsic %lr, (,%s12)
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = tail call float @stack_callee_float(float %0, float %0, float %0, float %0, float %0, float %0, float %0, float %0, float %0, float %0)
  ret float %2
}

