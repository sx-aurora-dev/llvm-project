; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: noinline nounwind optnone
define signext i32 @hasCall() {
; CHECK-LABEL: hasCall:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, noCall@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, noCall@hi(, %s0)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s0, 1, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = call signext i32 @noCall()
  ret i32 1
}

; Function Attrs: noinline nounwind optnone
define signext i32 @noCall() {
; CHECK-LABEL: noCall:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  ret i32 2
}

; Function Attrs: noinline nounwind optnone
define signext i32 @hasStackObjects() {
; CHECK-LABEL: hasStackObjects:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 3, (0)1
; CHECK-NEXT:    or %s0, 3, (0)1
; CHECK-NEXT:    stl %s1, 12(, %s11)
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %1 = alloca i32, align 4
  store i32 3, i32* %1, align 4
  %2 = load i32, i32* %1, align 4
  ret i32 %2
}

; Function Attrs: noinline nounwind optnone
define signext i32 @hasVarSizedObjects(i32 signext %0) {
; CHECK-LABEL: hasVarSizedObjects:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    stl %s0, -4(, %s9)
; CHECK-NEXT:    and %s1, %s0, (32)0
; CHECK-NEXT:    st %s11, -16(, %s9)
; CHECK-NEXT:    sll %s0, %s1, 2
; CHECK-NEXT:    lea %s0, 15(, %s0)
; CHECK-NEXT:    lea %s2, -16
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, 7(, %s2)
; CHECK-NEXT:    and %s0, %s0, %s2
; CHECK-NEXT:    lea %s2, __ve_grow_stack@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, __ve_grow_stack@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    st %s1, -24(, %s9)
; CHECK-NEXT:    ld %s11, -16(, %s9)
; CHECK-NEXT:    or %s0, 4, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = alloca i32, align 4
  %3 = alloca i8*, align 8
  %4 = alloca i64, align 8
  store i32 %0, i32* %2, align 4
  %5 = load i32, i32* %2, align 4
  %6 = zext i32 %5 to i64
  %7 = call i8* @llvm.stacksave()
  store i8* %7, i8** %3, align 8
  %8 = alloca i32, i64 %6, align 4
  store i64 %6, i64* %4, align 8
  %9 = load i8*, i8** %3, align 8
  call void @llvm.stackrestore(i8* %9)
  ret i32 4
}

; Function Attrs: nounwind
declare i8* @llvm.stacksave()

; Function Attrs: nounwind
declare void @llvm.stackrestore(i8*)

; Function Attrs: noinline nounwind optnone
define signext i32 @hasAlignedAlloca() {
; CHECK-LABEL: hasAlignedAlloca:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 5, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = alloca i32, align 128
  ret i32 5
}

; Function Attrs: noinline nounwind optnone
define signext i32 @DisableFramePointerElim() #1{
; CHECK-LABEL: DisableFramePointerElim:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 6, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  ret i32 6
}

; Function Attrs: noinline nounwind optnone
define i8* @isFrameAddressTaken() {
; CHECK-LABEL: isFrameAddressTaken:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 0, %s9
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = call i8* @llvm.frameaddress.p0i8(i32 0)
  ret i8* %1
}

; Function Attrs: nounwind readnone
declare i8* @llvm.frameaddress.p0i8(i32 immarg)

attributes #1 = { "frame-pointer"="all" }
