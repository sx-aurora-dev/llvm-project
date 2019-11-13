; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s
; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=-vec | FileCheck %s
; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+vec | FileCheck %s -check-prefix=VEC

@data = common global [16 x i32] zeroinitializer, align 4
@ldata = common global [16 x i64] zeroinitializer, align 8

; Function Attrs: noinline nounwind
define void @fun() {
; CHECK-LABEL: fun:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, data@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, data@hi(%s34)
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  st %s35, (,%s34)
; CHECK-NEXT:  st %s35, 8(,%s34)
; CHECK-NEXT:  st %s35, 16(,%s34)
; CHECK-NEXT:  st %s35, 24(,%s34)
; CHECK-NEXT:  or %s11, 0, %s9
; VEC-LABEL: fun:
; VEC:       .LBB{{[0-9]+}}_2:
; VEC-NEXT:  lea %s34, data@lo
; VEC-NEXT:  and %s34, %s34, (32)0
; VEC-NEXT:  lea.sl %s34, data@hi(%s34)
; VEC-NEXT:  or %s35, 0, (0)1
; VEC-NEXT:  st %s35, (,%s34)
; VEC-NEXT:  st %s35, 8(,%s34)
; VEC-NEXT:  st %s35, 16(,%s34)
; VEC-NEXT:  st %s35, 24(,%s34)
; VEC-NEXT:  or %s11, 0, %s9
  store i32 0, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @data, i64 0, i64 0), align 4
  store i32 0, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @data, i64 0, i64 1), align 4
  store i32 0, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @data, i64 0, i64 2), align 4
  store i32 0, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @data, i64 0, i64 3), align 4
  store i32 0, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @data, i64 0, i64 4), align 4
  store i32 0, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @data, i64 0, i64 5), align 4
  store i32 0, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @data, i64 0, i64 6), align 4
  store i32 0, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @data, i64 0, i64 7), align 4
  ret void
}

; Function Attrs: noinline nounwind
define void @fun2() {
; CHECK-LABEL: fun2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, ldata@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, ldata@hi(%s34)
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  st %s35, (,%s34)
; CHECK-NEXT:  st %s35, 8(,%s34)
; CHECK-NEXT:  st %s35, 16(,%s34)
; CHECK-NEXT:  st %s35, 24(,%s34)
; CHECK-NEXT:  st %s35, 32(,%s34)
; CHECK-NEXT:  st %s35, 40(,%s34)
; CHECK-NEXT:  st %s35, 48(,%s34)
; CHECK-NEXT:  st %s35, 56(,%s34)
; CHECK-NEXT:  or %s11, 0, %s9
; VEC-LABEL: fun2:
; VEC:       .LBB{{[0-9]+}}_2:
; VEC-NEXT:  lea %s34, 8
; VEC-NEXT:  or %s35, 0, (0)1
; VEC-NEXT:  lvl %s34
; VEC-NEXT:  vbrd %v0,%s35
; VEC-NEXT:  lea %s35, ldata@lo
; VEC-NEXT:  and %s35, %s35, (32)0
; VEC-NEXT:  lea.sl %s35, ldata@hi(%s35)
; VEC-NEXT:  vst %v0,8,%s35
; VEC-NEXT:  or %s11, 0, %s9
  store i64 0, i64* getelementptr inbounds ([16 x i64], [16 x i64]* @ldata, i64 0, i64 0), align 8
  store i64 0, i64* getelementptr inbounds ([16 x i64], [16 x i64]* @ldata, i64 0, i64 1), align 8
  store i64 0, i64* getelementptr inbounds ([16 x i64], [16 x i64]* @ldata, i64 0, i64 2), align 8
  store i64 0, i64* getelementptr inbounds ([16 x i64], [16 x i64]* @ldata, i64 0, i64 3), align 8
  store i64 0, i64* getelementptr inbounds ([16 x i64], [16 x i64]* @ldata, i64 0, i64 4), align 8
  store i64 0, i64* getelementptr inbounds ([16 x i64], [16 x i64]* @ldata, i64 0, i64 5), align 8
  store i64 0, i64* getelementptr inbounds ([16 x i64], [16 x i64]* @ldata, i64 0, i64 6), align 8
  store i64 0, i64* getelementptr inbounds ([16 x i64], [16 x i64]* @ldata, i64 0, i64 7), align 8
  ret void
}

