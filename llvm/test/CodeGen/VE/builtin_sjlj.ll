; RUN: llc < %s -mtriple=ve | FileCheck %s

%struct.__jmp_buf_tag = type { [25 x i64], i64, [16 x i64] }

@buf = common global [1 x %struct.__jmp_buf_tag] zeroinitializer, align 8

; Function Attrs: noinline nounwind optnone
define i32 @t_setjmp() {
; CHECK-LABEL: t_setjmp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, buf@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, buf@hi(%s34)
; CHECK-NEXT:  st %s9, (,%s34)
; CHECK-NEXT:  st %s11, 16(,%s34)
; CHECK-NEXT:  sic %s0
; CHECK-NEXT:  lea %s0, 32(%s0)
; CHECK-NEXT:  st %s0, 8(,%s34)
; CHECK-NEXT:  lea %s0, 0
; CHECK-NEXT:  br.l 16
; CHECK-NEXT:  lea %s0, 1
; CHECK-NEXT:  or %s11, 0, %s9
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
; CHECK-NEXT:  lea %s34, buf@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, buf@hi(%s34)
; CHECK-NEXT:  ld %s9, (,%s34)
; CHECK-NEXT:  ld %s10, 8(,%s34)
; CHECK-NEXT:  ld %s11, 16(,%s34)
; CHECK-NEXT:  b.l (,%s10)
  call void @llvm.eh.sjlj.longjmp(i8* bitcast ([1 x %struct.__jmp_buf_tag]* @buf to i8*))
  unreachable
                                                  ; No predecessors!
  ret void
}

; Function Attrs: noreturn nounwind
declare void @llvm.eh.sjlj.longjmp(i8*)

