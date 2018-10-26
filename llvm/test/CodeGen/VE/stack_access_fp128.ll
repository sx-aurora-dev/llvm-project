; RUN: llc -O0 < %s -mtriple=ve-unknown-unknown | FileCheck %s

@.str = private unnamed_addr constant [4 x i8] c"%Lf\00", align 1
@.str.1 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1

; Function Attrs: noinline nounwind optnone
define void @test(fp128) {
; CHECK-LABEL: test:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s34, 0, %s0
; CHECK-NEXT:    or %s35, 0, %s1
; CHECK-NEXT:    st %s1, -16(,%s9)
; CHECK-NEXT:    st %s0, -8(,%s9)
; CHECK-NEXT:    st %s1, -32(,%s9)
; CHECK-NEXT:    st %s0, -24(,%s9)
; CHECK-NEXT:    or %s36, 0, %s0
; CHECK-NEXT:    st %s36, 200(,%s11)
; CHECK-NEXT:    or %s36, 0, %s1
; CHECK-NEXT:    st %s36, 192(,%s11)
; CHECK-NEXT:    lea %s36, .L.str@lo
; CHECK-NEXT:    and %s36, %s36, (32)0
; CHECK-NEXT:    lea.sl %s36, .L.str@hi(%s36)
; CHECK-NEXT:    st %s36, 176(,%s11)
; CHECK-NEXT:    lea %s37, printf@lo
; CHECK-NEXT:    and %s37, %s37, (32)0
; CHECK-NEXT:    lea.sl %s37, printf@hi(%s37)
; CHECK-NEXT:    or %s12, 0, %s37
; CHECK-NEXT:    st %s1, -48(,%s9)
; CHECK-NEXT:    st %s0, -40(,%s9)               # 16-byte Folded Spill
; CHECK-NEXT:    or %s0, 0, %s36
; CHECK-NEXT:    ld %s3, -48(,%s9)
; CHECK-NEXT:    ld %s2, -40(,%s9)               # 16-byte Folded Reload
; CHECK-NEXT:    st %s35, -64(,%s9)
; CHECK-NEXT:    st %s34, -56(,%s9)              # 16-byte Folded Spill

  %2 = alloca fp128, align 16
  %3 = alloca fp128, align 16
  store fp128 %0, fp128* %2, align 16
  %4 = load fp128, fp128* %2, align 16
  store fp128 %4, fp128* %3, align 16
  %5 = load fp128, fp128* %3, align 16
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), fp128 %5)
  %7 = load fp128, fp128* %2, align 16
  %8 = call i32 bitcast (i32 (...)* @test1 to i32 (fp128)*)(fp128 %7)
  %9 = load fp128, fp128* %3, align 16
  %10 = call i32 bitcast (i32 (...)* @test2 to i32 (i8*, fp128)*)(i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.1, i32 0, i32 0), fp128 %9)
  ret void
}

declare i32 @printf(i8*, ...)

declare i32 @test1(...)

declare i32 @test2(...)
