; RUN: opt -aa-pipeline=basic-aa "-passes=print<pdg>" -S < %s 2>&1 | FileCheck %s

; CHECK-DAG: @foo(  load %q  ) ----> @foo(  store %p  )  [RAW (must)]
; CHECK-DAG: @foo :: %q ----> @foo(  load %q  )  [RAW (must)]
; CHECK-DAG: @foo(  load %q  ) ----> @foo(  store %p  )  [WAR (may) from memory ]
; CHECK-DAG: @foo :: %p ----> @foo(  store %p  )  [RAW (must)]
; CHECK-DAG: @foo(  store %p  ) ----> @foo(  load %q  )  [RAW (may) from memory ]

define void @foo(i32* %p, i32* %q) {
entry:
  %0 = load i32, i32* %q, align 4
  store i32 %0, i32* %p, align 4
  ret void
}
