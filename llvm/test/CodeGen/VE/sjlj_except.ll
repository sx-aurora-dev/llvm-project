; RUN: llc < %s --exception-model=sjlj -mtriple=x86_64-unknown-unknown --print-after=sjljehprepare |& FileCheck --check-prefix=CHECK-X86 %s
; RUN: llc < %s --exception-model=sjlj -mtriple=ve-unknown-unknown  --print-after=sjljehprepare |& FileCheck --check-prefix=CHECK-VE %s

$_ZTS10SomeExcept = comdat any

$_ZTI10SomeExcept = comdat any

@_ZTVN10__cxxabiv120__si_class_type_infoE = external dso_local global i8*
@_ZTS10SomeExcept = linkonce_odr dso_local constant [13 x i8] c"10SomeExcept\00", comdat, align 1
@_ZTISt9exception = external dso_local constant i8*
@_ZTI10SomeExcept = linkonce_odr dso_local constant { i8*, i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8*, i8** @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @_ZTS10SomeExcept, i32 0, i32 0), i8* bitcast (i8** @_ZTISt9exception to i8*) }, comdat, align 8

define dso_local i32 @foo(i32 %arg) local_unnamed_addr personality i8* bitcast (i32 (...)* @__gxx_personality_sj0 to i8*) {
; CHECK-VE: *** IR Dump After SJLJ Exception Handling preparation ***
; CHECK-VE-NEXT: define dso_local i32 @foo(i32 %arg) local_unnamed_addr personality i8* bitcast (i32 (...)* @__gxx_personality_sj0 to i8*) {
; CHECK-VE-NEXT: entry:
; CHECK-VE-NEXT:   %fn_context = alloca { i8*, i64, [4 x i64], i8*, i8*, [5 x i8*] }, align 8
; CHECK-VE-NEXT:   %arg.tmp = select i1 true, i32 %arg, i32 undef
; CHECK-VE-NEXT:   %pers_fn_gep = getelementptr { i8*, i64, [4 x i64], i8*, i8*, [5 x i8*] }, { i8*, i64, [4 x i64], i8*, i8*, [5 x i8*] }* %fn_context, i32 0, i32 3
; CHECK-X86: *** IR Dump After SJLJ Exception Handling preparation ***
; CHECK-X86-NEXT: define dso_local i32 @foo(i32 %arg) local_unnamed_addr personality i8* bitcast (i32 (...)* @__gxx_personality_sj0 to i8*) {
; CHECK-X86-NEXT: entry:
; CHECK-X86-NEXT:   %fn_context = alloca { i8*, i32, [4 x i32], i8*, i8*, [5 x i8*] }, align 8
; CHECK-X86-NEXT:   %arg.tmp = select i1 true, i32 %arg, i32 undef
; CHECK-X86-NEXT:   %pers_fn_gep = getelementptr { i8*, i32, [4 x i32], i8*, i8*, [5 x i8*] }, { i8*, i32, [4 x i32], i8*, i8*, [5 x i8*] }* %fn_context, i32 0, i32 3
entry:
  invoke void @errorbar()
          to label %join unwind label %handle

handle:
  %error = landingpad { i8*, i32 }
          catch i8* bitcast ({ i8*, i8*, i8* }* @_ZTI10SomeExcept to i8*)
  %err.tyd = extractvalue { i8*, i32 } %error, 1
  %except.tyd = tail call i32 @llvm.eh.typeid.for(i8* bitcast ({ i8*, i8*, i8* }* @_ZTI10SomeExcept to i8*)) #3
  %is.someexcept = icmp eq i32 %err.tyd, %except.tyd
  br i1 %is.someexcept, label %handle.someexcept, label %escalate

handle.someexcept:
  %err.payload = extractvalue { i8*, i32 } %error, 0
  %someexcept.data = tail call i8* @__cxa_begin_catch(i8* %err.payload) #3
  %se.num.ptr = getelementptr inbounds i8, i8* %someexcept.data, i64 8
  %se.num.iptr = bitcast i8* %se.num.ptr to i32*
  %num = load i32, i32* %se.num.iptr, align 8
  tail call void @__cxa_end_catch()
  br label %join

join:
  %r = phi i32 [ %num, %handle.someexcept ], [ %arg, %entry ]
  ret i32 %r

escalate:
  resume { i8*, i32 } %error
}

declare dso_local void @errorbar() local_unnamed_addr

declare dso_local i32 @__gxx_personality_sj0(...)

; Function Attrs: nounwind readnone
declare i32 @llvm.eh.typeid.for(i8*) #2

declare dso_local i8* @__cxa_begin_catch(i8*) local_unnamed_addr

declare dso_local void @__cxa_end_catch() local_unnamed_addr

attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }
