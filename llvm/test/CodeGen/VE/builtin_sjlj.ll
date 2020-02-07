; RUN: llc < %s -mtriple=ve | FileCheck %s

%struct.__jmp_buf_tag = type { [25 x i64], i64, [16 x i64] }

@buf = common global [1 x %struct.__jmp_buf_tag] zeroinitializer, align 8

; Function Attrs: noinline nounwind optnone
define i32 @t_setjmp() {
; CHECK-LABEL: t_setjmp:
; CHECK:       lea %s0, buf@lo
; CHECK-NEXT:  and %s0, %s0, (32)0
; CHECK-NEXT:  lea.sl %s0, buf@hi(, %s0)
; CHECK-NEXT:  st %s9, (, %s0)
; CHECK-NEXT:  st %s11, 16(, %s0)
; CHECK-NEXT:  lea %s1, .LBB{{[0-9]+}}_3@lo
; CHECK-NEXT:  and %s1, %s1, (32)0
; CHECK-NEXT:  lea.sl %s1, .LBB{{[0-9]+}}_3@hi(, %s1)
; CHECK-NEXT:  st %s1, 8(, %s0)
; CHECK-NEXT:  # EH_SJlJ_SETUP .LBB{{[0-9]+}}_3
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:  lea %s0, 0
; CHECK-NEXT:  br.l .LBB{{[0-9]+}}_2
; CHECK-NEXT:  .LBB{{[0-9]+}}_3:
; CHECK-NEXT:  lea %s0, 1
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
  %1 = call i8* @llvm.frameaddress(i32 0)
  store i8* %1, i8** bitcast ([1 x %struct.__jmp_buf_tag]* @buf to i8**), align 8
  %2 = call i8* @llvm.stacksave()
  store i8* %2, i8** getelementptr inbounds (i8*, i8** bitcast ([1 x %struct.__jmp_buf_tag]* @buf to i8**), i64 2), align 8
  %3 = call i32 @llvm.eh.sjlj.setjmp(i8* bitcast ([1 x %struct.__jmp_buf_tag]* @buf to i8*))
  ret i32 %3
}

; Function Attrs: nounwind readnone
declare i8* @llvm.frameaddress(i32)

; Function Attrs: nounwind
declare i8* @llvm.stacksave()

; Function Attrs: nounwind
declare i32 @llvm.eh.sjlj.setjmp(i8*)

; Function Attrs: noinline nounwind optnone
define void @t_longjmp() {
; CHECK-LABEL: t_longjmp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s0, buf@lo
; CHECK-NEXT:  and %s0, %s0, (32)0
; CHECK-NEXT:  lea.sl %s0, buf@hi(, %s0)
; CHECK-NEXT:  ld %s9, (, %s0)
; CHECK-NEXT:  ld %s1, 8(, %s0)
; CHECK-NEXT:  or %s10, 0, %s0
; CHECK-NEXT:  ld %s11, 16(, %s0)
; CHECK-NEXT:  b.l (, %s1)
  call void @llvm.eh.sjlj.longjmp(i8* bitcast ([1 x %struct.__jmp_buf_tag]* @buf to i8*))
  unreachable
                                                  ; No predecessors!
  ret void
}

; Function Attrs: noreturn nounwind
declare void @llvm.eh.sjlj.longjmp(i8*)

