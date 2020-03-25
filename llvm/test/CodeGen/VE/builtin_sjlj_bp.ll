; RUN: llc < %s -mtriple=ve | FileCheck %s

%Foo = type { [125 x i8] }
declare void @whatever(i64, %Foo*, i8**, i8*, i8*, i32)  #0
declare i32 @llvm.eh.sjlj.setjmp(i8*) nounwind

; Function Attrs: noinline nounwind optnone
define i32 @t_setjmp(i64 %n, %Foo* byval nocapture readnone align 8 %f) {
; CHECK-LABEL: t_setjmp:
; CHECK:       lea %s0, .LBB{{[0-9]+}}_3@lo
; CHECK-NEXT:  and %s0, %s0, (32)0
; CHECK-NEXT:  lea.sl %s0, .LBB{{[0-9]+}}_3@hi(, %s0)
; CHECK-NEXT:  st %s17, 24(, %s1)
; CHECK-NEXT:  st %s1, 296(, %s17)
; CHECK-NEXT:  st %s0, 8(, %s1)
; CHECK-NEXT:  # EH_SJlJ_SETUP .LBB{{[0-9]+}}_3
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:  lea %s5, 0
; CHECK-NEXT:  br.l .LBB{{[0-9]+}}_2
; CHECK-NEXT:  .LBB{{[0-9]+}}_3:
; CHECK-NEXT:  ld %s17, 24(, %s10)
; CHECK-NEXT:  lea %s5, 1
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s0, whatever@lo
  %buf = alloca [5 x i8*], align 16
  %p = alloca i8*, align 8
  %q = alloca i8, align 64
  %r = bitcast [5 x i8*]* %buf to i8*
  %s = alloca i8, i64 %n, align 1
  store i8* %s, i8** %p, align 8
  %t = call i32 @llvm.eh.sjlj.setjmp(i8* %s)
  call void @whatever(i64 %n, %Foo* %f, i8** %p, i8* %q, i8* %s, i32 %t) #1
  ret i32 0
}
