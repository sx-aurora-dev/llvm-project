#include <reserved.h>
struct X { int x; };
typedef struct t TYPEDEF;
typedef struct t _TYPEDEF;
void foo() {
  int y;
  // RUN: %clang_cc1 -isystem %S/Inputs -fsyntax-only -code-completion-at=%s:%(line-1):9 %s -o - | FileCheck -check-prefix=CHECK-CC1 %s
  // CHECK-CC1-NOT: __builtin_va_list
  // CHECK-CC1-NOT: __INTEGER_TYPE
  // CHECK-CC1: _Imaginary
  // CHECK-CC1: _MyPrivateType
  // CHECK-CC1: _TYPEDEF
  // CHECK-CC1: FLOATING_TYPE
  // CHECK-CC1: foo
  // CHECK-CC1: TYPEDEF
  // CHECK-CC1: y

  // PR8744
  // RUN: %clang_cc1 -isystem %S/Inputs -fsyntax-only -code-completion-at=%s:%(line-18):11 %s
  
  // RUN: %clang_cc1 -isystem %S/Inputs -fsyntax-only -fdebugger-support -code-completion-at=%s:%(line-15):9 %s -o - | FileCheck -check-prefix=CHECK-DBG %s
  // CHECK-DBG: __builtin_va_list
  // CHECK-DBG: __INTEGER_TYPE
