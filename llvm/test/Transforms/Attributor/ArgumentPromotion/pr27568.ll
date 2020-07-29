; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --scrub-attributes --check-attributes
; RUN: opt -attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=1 -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_CGSCC_NPM,NOT_CGSCC_OPM,NOT_TUNIT_NPM,IS__TUNIT____,IS________OPM,IS__TUNIT_OPM
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=1 -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_CGSCC_OPM,NOT_CGSCC_NPM,NOT_TUNIT_OPM,IS__TUNIT____,IS________NPM,IS__TUNIT_NPM
; RUN: opt -attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_TUNIT_NPM,NOT_TUNIT_OPM,NOT_CGSCC_NPM,IS__CGSCC____,IS________OPM,IS__CGSCC_OPM
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_TUNIT_NPM,NOT_TUNIT_OPM,NOT_CGSCC_OPM,IS__CGSCC____,IS________NPM,IS__CGSCC_NPM
target triple = "x86_64-pc-windows-msvc"

define internal void @callee(i8*) {
; CHECK-LABEL: define {{[^@]+}}@callee()
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @thunk()
; CHECK-NEXT:    ret void
;
entry:
  call void @thunk()
  ret void
}

define void @test1() personality i32 (...)* @__CxxFrameHandler3 {
; CHECK-LABEL: define {{[^@]+}}@test1() personality i32 (...)* @__CxxFrameHandler3
; CHECK-NEXT:  entry:
; CHECK-NEXT:    invoke void @thunk()
; CHECK-NEXT:    to label [[OUT:%.*]] unwind label [[CPAD:%.*]]
; CHECK:       out:
; CHECK-NEXT:    ret void
; CHECK:       cpad:
; CHECK-NEXT:    [[PAD:%.*]] = cleanuppad within none []
; CHECK-NEXT:    call void @callee() [ "funclet"(token [[PAD]]) ]
; CHECK-NEXT:    cleanupret from [[PAD]] unwind to caller
;
entry:
  invoke void @thunk()
  to label %out unwind label %cpad

out:
  ret void

cpad:
  %pad = cleanuppad within none []
  call void @callee(i8* null) [ "funclet"(token %pad) ]
  cleanupret from %pad unwind to caller
}


declare void @thunk()

declare i32 @__CxxFrameHandler3(...)
