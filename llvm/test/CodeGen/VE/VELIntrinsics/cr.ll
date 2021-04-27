; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s
; ModuleID = 'tests/cr.cc'
source_filename = "tests/cr.cc"
target datalayout = "e-m:e-i64:64-n32:64-S128-v64:64:64-v128:64:64-v256:64:64-v512:64:64-v1024:64:64-v2048:64:64-v4096:64:64-v8192:64:64-v16384:64:64"
target triple = "ve-unknown-linux-gnu"

; Function Attrs: nounwind readnone willreturn mustprogress
define dso_local i64 @_Z7lcr_sssmm(i64 %0, i64 %1) local_unnamed_addr #0 {
; CHECK: lcr %s0, %s0, %s1
  %3 = tail call i64 @llvm.ve.vl.lcr.sss(i64 %0, i64 %1)
  ret i64 %3
}

; Function Attrs: nounwind readnone
declare i64 @llvm.ve.vl.lcr.sss(i64, i64) #1

; Function Attrs: nounwind readnone willreturn mustprogress
define dso_local i64 @_Z7lcr_sismm(i64 %0, i64 %1) local_unnamed_addr #0 {
; CHECK: lcr %s0, 3, %s0
  %3 = add i64 %0, -3
  %4 = add i64 %3, %1
  %5 = tail call i64 @llvm.ve.vl.lcr.sss(i64 3, i64 %4)
  ret i64 %5
}

; Function Attrs: nounwind readnone willreturn mustprogress
define dso_local i64 @_Z7lcr_sszmm(i64 %0, i64 %1) local_unnamed_addr #0 {
; CHECK: lcr %s0, %s0, 0
  %3 = add i64 %1, %0
  %4 = tail call i64 @llvm.ve.vl.lcr.sss(i64 %3, i64 0)
  ret i64 %4
}

; Function Attrs: nounwind readnone willreturn mustprogress
define dso_local i64 @_Z7lcr_sizmm(i64 %0, i64 %1) local_unnamed_addr #0 {
; CHECK: lcr %s0, 15, 0
  %3 = tail call i64 @llvm.ve.vl.lcr.sss(i64 15, i64 0)
  ret i64 %3
}

; Function Attrs: nounwind mustprogress
define dso_local void @_Z7scr_sssmmm(i64 %0, i64 %1, i64 %2) local_unnamed_addr #2 {
; CHECK: scr %s0, %s1, %s2
  tail call void @llvm.ve.vl.scr.sss(i64 %0, i64 %1, i64 %2)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.ve.vl.scr.sss(i64, i64, i64) #3

; Function Attrs: nounwind mustprogress
define dso_local void @_Z7scr_sismmm(i64 %0, i64 %1, i64 %2) local_unnamed_addr #2 {
; CHECK: scr %s0, 3, %s1
  %4 = add i64 %1, -3
  %5 = add i64 %4, %2
  tail call void @llvm.ve.vl.scr.sss(i64 %0, i64 3, i64 %5)
  ret void
}

; Function Attrs: nounwind mustprogress
define dso_local void @_Z7scr_sszmmm(i64 %0, i64 %1, i64 %2) local_unnamed_addr #2 {
; CHECK: scr %s0, %s1, 0
  %4 = add i64 %2, %1
  tail call void @llvm.ve.vl.scr.sss(i64 %0, i64 %4, i64 0)
  ret void
}

; Function Attrs: nounwind mustprogress
define dso_local void @_Z7scr_sizmmm(i64 %0, i64 %1, i64 %2) local_unnamed_addr #2 {
; CHECK: scr %s0, 15, 0
  tail call void @llvm.ve.vl.scr.sss(i64 %0, i64 15, i64 0)
  ret void
}

; Function Attrs: nounwind mustprogress
define dso_local i64 @_Z9tscr_ssssmmm(i64 %0, i64 %1, i64 %2) local_unnamed_addr #2 {
; CHECK: tscr %s0, %s1, %s2
  %4 = tail call i64 @llvm.ve.vl.tscr.ssss(i64 %0, i64 %1, i64 %2)
  ret i64 %4
}

; Function Attrs: nounwind
declare i64 @llvm.ve.vl.tscr.ssss(i64, i64, i64) #3

; Function Attrs: nounwind mustprogress
define dso_local i64 @_Z9tscr_ssismmm(i64 %0, i64 %1, i64 %2) local_unnamed_addr #2 {
; CHECK: tscr %s0, 3, %s1
  %4 = add i64 %1, -3
  %5 = add i64 %4, %2
  %6 = tail call i64 @llvm.ve.vl.tscr.ssss(i64 %0, i64 3, i64 %5)
  ret i64 %6
}

; Function Attrs: nounwind mustprogress
define dso_local i64 @_Z9tscr_ssszmmm(i64 %0, i64 %1, i64 %2) local_unnamed_addr #2 {
; CHECK: tscr %s0, %s1, 0
  %4 = add i64 %2, %1
  %5 = tail call i64 @llvm.ve.vl.tscr.ssss(i64 %0, i64 %4, i64 0)
  ret i64 %5
}

; Function Attrs: nounwind mustprogress
define dso_local i64 @_Z9tscr_ssizmmm(i64 %0, i64 %1, i64 %2) local_unnamed_addr #2 {
; CHECK: tscr %s0, 15, 0
  %4 = tail call i64 @llvm.ve.vl.tscr.ssss(i64 %0, i64 15, i64 0)
  ret i64 %4
}

; Function Attrs: nounwind mustprogress
define dso_local i64 @_Z8fidcr_s0m(i64 %0) local_unnamed_addr #2 {
; CHECK: fidcr %s0, %s0, 0
  %2 = tail call i64 @llvm.ve.vl.fidcr.sss(i64 %0, i32 0)
  ret i64 %2
}

; Function Attrs: nounwind
declare i64 @llvm.ve.vl.fidcr.sss(i64, i32) #3

; Function Attrs: nounwind mustprogress
define dso_local i64 @_Z8fidcr_s1m(i64 %0) local_unnamed_addr #2 {
; CHECK: fidcr %s0, %s0, 1
  %2 = tail call i64 @llvm.ve.vl.fidcr.sss(i64 %0, i32 1)
  ret i64 %2
}

; Function Attrs: nounwind mustprogress
define dso_local i64 @_Z8fidcr_s2m(i64 %0) local_unnamed_addr #2 {
; CHECK: fidcr %s0, %s0, 2
  %2 = tail call i64 @llvm.ve.vl.fidcr.sss(i64 %0, i32 2)
  ret i64 %2
}

; Function Attrs: nounwind mustprogress
define dso_local i64 @_Z8fidcr_s3m(i64 %0) local_unnamed_addr #2 {
; CHECK: fidcr %s0, %s0, 3
  %2 = tail call i64 @llvm.ve.vl.fidcr.sss(i64 %0, i32 3)
  ret i64 %2
}

; Function Attrs: nounwind mustprogress
define dso_local i64 @_Z8fidcr_s4m(i64 %0) local_unnamed_addr #2 {
; CHECK: fidcr %s0, %s0, 4
  %2 = tail call i64 @llvm.ve.vl.fidcr.sss(i64 %0, i32 4)
  ret i64 %2
}

; Function Attrs: nounwind mustprogress
define dso_local i64 @_Z8fidcr_s5m(i64 %0) local_unnamed_addr #2 {
; CHECK: fidcr %s0, %s0, 5
  %2 = tail call i64 @llvm.ve.vl.fidcr.sss(i64 %0, i32 5)
  ret i64 %2
}

; Function Attrs: nounwind mustprogress
define dso_local i64 @_Z8fidcr_s6m(i64 %0) local_unnamed_addr #2 {
; CHECK: fidcr %s0, %s0, 6
  %2 = tail call i64 @llvm.ve.vl.fidcr.sss(i64 %0, i32 6)
  ret i64 %2
}

; Function Attrs: nounwind mustprogress
define dso_local i64 @_Z8fidcr_s7m(i64 %0) local_unnamed_addr #2 {
; CHECK: fidcr %s0, %s0, 7
  %2 = tail call i64 @llvm.ve.vl.fidcr.sss(i64 %0, i32 7)
  ret i64 %2
}

; Function Attrs: nounwind mustprogress
define dso_local i64 @_Z8fidcr_i0m(i64 %0) local_unnamed_addr #2 {
; CHECK: fidcr %s0, 12, 0
  %2 = tail call i64 @llvm.ve.vl.fidcr.sss(i64 12, i32 0)
  ret i64 %2
}

; Function Attrs: nounwind mustprogress
define dso_local i64 @_Z8fidcr_i1m(i64 %0) local_unnamed_addr #2 {
; CHECK: fidcr %s0, 12, 1
  %2 = tail call i64 @llvm.ve.vl.fidcr.sss(i64 12, i32 1)
  ret i64 %2
}

; Function Attrs: nounwind mustprogress
define dso_local i64 @_Z8fidcr_i2m(i64 %0) local_unnamed_addr #2 {
; CHECK: fidcr %s0, 12, 2
  %2 = tail call i64 @llvm.ve.vl.fidcr.sss(i64 12, i32 2)
  ret i64 %2
}

; Function Attrs: nounwind mustprogress
define dso_local i64 @_Z8fidcr_i3m(i64 %0) local_unnamed_addr #2 {
; CHECK: fidcr %s0, 12, 3
  %2 = tail call i64 @llvm.ve.vl.fidcr.sss(i64 12, i32 3)
  ret i64 %2
}

; Function Attrs: nounwind mustprogress
define dso_local i64 @_Z8fidcr_i4m(i64 %0) local_unnamed_addr #2 {
; CHECK: fidcr %s0, 12, 4
  %2 = tail call i64 @llvm.ve.vl.fidcr.sss(i64 12, i32 4)
  ret i64 %2
}

; Function Attrs: nounwind mustprogress
define dso_local i64 @_Z8fidcr_i5m(i64 %0) local_unnamed_addr #2 {
; CHECK: fidcr %s0, 12, 5
  %2 = tail call i64 @llvm.ve.vl.fidcr.sss(i64 12, i32 5)
  ret i64 %2
}

; Function Attrs: nounwind mustprogress
define dso_local i64 @_Z8fidcr_i6m(i64 %0) local_unnamed_addr #2 {
; CHECK: fidcr %s0, 12, 6
  %2 = tail call i64 @llvm.ve.vl.fidcr.sss(i64 12, i32 6)
  ret i64 %2
}

; Function Attrs: nounwind mustprogress
define dso_local i64 @_Z8fidcr_i7m(i64 %0) local_unnamed_addr #2 {
; CHECK: fidcr %s0, 12, 7
  %2 = tail call i64 @llvm.ve.vl.fidcr.sss(i64 12, i32 7)
  ret i64 %2
}

attributes #0 = { nounwind readnone willreturn mustprogress "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+packed,+vpu" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind mustprogress "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+packed,+vpu" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (git@github.com:sx-aurora-dev/llvm-project.git 6454223434715cbfd0e85f1c9084f01a3f8958e9)"}
