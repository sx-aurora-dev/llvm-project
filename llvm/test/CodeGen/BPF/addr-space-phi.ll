; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt --bpf-check-and-opt-ir -S -mtriple=bpf-pc-linux < %s | FileCheck %s

; Generated from the following C code:
;
;   #define __uptr __attribute__((address_space(1)))
;
;   extern int __uptr *magic1();
;   extern int __uptr *magic2();
;
;   void test(long i) {
;     int __uptr *a;
;
;     if (i > 42)
;       a = magic1();
;     else
;       a = magic2();
;     a[5] = 7;
;   }
;
; Using the following command:
;
;   clang --target=bpf -O2 -S -emit-llvm -o t.ll t.c

define void @test(i64 noundef %i) {
; CHECK:       if.end:
; CHECK-NEXT:    [[A_0:%.*]] = phi ptr addrspace(1)
; CHECK-NEXT:    [[A_01:%.*]] = addrspacecast ptr addrspace(1) [[A_0]] to ptr
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds i32, ptr [[A_01]], i64 5
; CHECK-NEXT:    store i32 7, ptr [[ARRAYIDX2]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %cmp = icmp sgt i64 %i, 42
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %call = tail call ptr addrspace(1) @magic1()
  br label %if.end

if.else:                                          ; preds = %entry
  %call1 = tail call ptr addrspace(1) @magic2()
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %a.0 = phi ptr addrspace(1) [ %call, %if.then ], [ %call1, %if.else ]
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %a.0, i64 5
  store i32 7, ptr addrspace(1) %arrayidx, align 4
  ret void
}

declare ptr addrspace(1) @magic1(...)
declare ptr addrspace(1) @magic2(...)
