; RUN: opt "-passes=print<pdg>" -S < %s 2>&1 | FileCheck %s

; CHECK-DAG: @foo :: %a ----> @foo(  %add  )  [RAW (must)]
; CHECK-DAG: @foo(  %add  ) ----> @foo(  ret i32 %add  )  [RAW (must)]

define i32 @foo(i32 %a) {
entry:
  %add = add nsw i32 %a, 2
  ret i32 %add
}
