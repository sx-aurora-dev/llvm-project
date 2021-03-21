// RUN: python %S/interchange_and_run.py %s | FileCheck %s

#include <stdint.h>

void foo(int m) {
  for (int k = 0; k < m; ++k) {
# pragma clang loop distribute(enable)
    for (int i = 0; i < m; ++i) {
# pragma clang loop distribute(enable)
      for (int j = 0; j < m; ++j) {
        printf("%d %d %d\n", k, i, j);
      }
    }
  }
}

int main(void) {
  foo(4);
  return 0;
}

// CHECK:      0 0 0
// CHECK-NEXT: 0 1 0
// CHECK-NEXT: 0 2 0
// CHECK-NEXT: 0 3 0
// CHECK-NEXT: 0 0 1
// CHECK-NEXT: 0 1 1
// CHECK-NEXT: 0 2 1
// CHECK-NEXT: 0 3 1
// CHECK-NEXT: 0 0 2
// CHECK-NEXT: 0 1 2
// CHECK-NEXT: 0 2 2
// CHECK-NEXT: 0 3 2
// CHECK-NEXT: 0 0 3
// CHECK-NEXT: 0 1 3
// CHECK-NEXT: 0 2 3
// CHECK-NEXT: 0 3 3
// CHECK-NEXT: 1 0 0
// CHECK-NEXT: 1 1 0
// CHECK-NEXT: 1 2 0
// CHECK-NEXT: 1 3 0
// CHECK-NEXT: 1 0 1
// CHECK-NEXT: 1 1 1
// CHECK-NEXT: 1 2 1
// CHECK-NEXT: 1 3 1
// CHECK-NEXT: 1 0 2
// CHECK-NEXT: 1 1 2
// CHECK-NEXT: 1 2 2
// CHECK-NEXT: 1 3 2
// CHECK-NEXT: 1 0 3
// CHECK-NEXT: 1 1 3
// CHECK-NEXT: 1 2 3
// CHECK-NEXT: 1 3 3
// CHECK-NEXT: 2 0 0
// CHECK-NEXT: 2 1 0
// CHECK-NEXT: 2 2 0
// CHECK-NEXT: 2 3 0
// CHECK-NEXT: 2 0 1
// CHECK-NEXT: 2 1 1
// CHECK-NEXT: 2 2 1
// CHECK-NEXT: 2 3 1
// CHECK-NEXT: 2 0 2
// CHECK-NEXT: 2 1 2
// CHECK-NEXT: 2 2 2
// CHECK-NEXT: 2 3 2
// CHECK-NEXT: 2 0 3
// CHECK-NEXT: 2 1 3
// CHECK-NEXT: 2 2 3
// CHECK-NEXT: 2 3 3
// CHECK-NEXT: 3 0 0
// CHECK-NEXT: 3 1 0
// CHECK-NEXT: 3 2 0
// CHECK-NEXT: 3 3 0
// CHECK-NEXT: 3 0 1
// CHECK-NEXT: 3 1 1
// CHECK-NEXT: 3 2 1
// CHECK-NEXT: 3 3 1
// CHECK-NEXT: 3 0 2
// CHECK-NEXT: 3 1 2
// CHECK-NEXT: 3 2 2
// CHECK-NEXT: 3 3 2
// CHECK-NEXT: 3 0 3
// CHECK-NEXT: 3 1 3
// CHECK-NEXT: 3 2 3
// CHECK-NEXT: 3 3 3