; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s
; ModuleID = 'tests/fence.cc'
source_filename = "tests/fence.cc"
target datalayout = "e-m:e-i64:64-n32:64-S128-v64:64:64-v128:64:64-v256:64:64-v512:64:64-v1024:64:64-v2048:64:64-v4096:64:64-v8192:64:64-v16384:64:64"
target triple = "ve-unknown-linux-gnu"

; Function Attrs: nounwind mustprogress
define dso_local void @_Z6fenceiv() local_unnamed_addr #0 {
; CHECK: fencei
  tail call void @llvm.ve.vl.fencei()
  ret void
}

; Function Attrs: nounwind
declare void @llvm.ve.vl.fencei() #1

; Function Attrs: nounwind mustprogress
define dso_local void @_Z7fencem3v() local_unnamed_addr #0 {
; CHECK: fencem 3
  tail call void @llvm.ve.vl.fencem.s(i32 3)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.ve.vl.fencem.s(i32) #1

; Function Attrs: nounwind mustprogress
define dso_local void @_Z7fencec7v() local_unnamed_addr #0 {
; CHECK: fencec 7
  tail call void @llvm.ve.vl.fencec.s(i32 7)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.ve.vl.fencec.s(i32) #1

attributes #0 = { nounwind mustprogress "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+packed,+vpu" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (git@github.com:sx-aurora-dev/llvm-project.git 6454223434715cbfd0e85f1c9084f01a3f8958e9)"}
