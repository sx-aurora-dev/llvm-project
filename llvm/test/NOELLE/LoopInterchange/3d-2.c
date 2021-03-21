// RUN: python %S/interchange_and_run.py %s | FileCheck %s

#include <stdio.h>
#include <math.h>

void do_comp6 (int n, int m, int o, double* A, double* B, double* C) {
# pragma clang loop distribute(enable)
  for (int j=1; j<n-1; j++) {
    for (int i=1; i<m-1; i++) {
# pragma clang loop distribute(enable)
      for (int k=0; k<o; k++) {
        int idx = j*m+i;
        B[idx] += sqrt(C[k]*A[idx]);
        printf("%d %d %d\n", j, i, k);
      }
    }
  }
}

int main(void) {
  int n = 8;
  int m = 4;
  int o = 20;
  double A[100], B[100], C[100];
  do_comp6(n, m, o, A, B, C);
}

// CHECK:      1 1 0
// CHECK-NEXT: 2 1 0
// CHECK-NEXT: 3 1 0
// CHECK-NEXT: 4 1 0
// CHECK-NEXT: 5 1 0
// CHECK-NEXT: 6 1 0
// CHECK-NEXT: 1 2 0
// CHECK-NEXT: 2 2 0
// CHECK-NEXT: 3 2 0
// CHECK-NEXT: 4 2 0
// CHECK-NEXT: 5 2 0
// CHECK-NEXT: 6 2 0
// CHECK-NEXT: 1 1 1
// CHECK-NEXT: 2 1 1
// CHECK-NEXT: 3 1 1
// CHECK-NEXT: 4 1 1
// CHECK-NEXT: 5 1 1
// CHECK-NEXT: 6 1 1
// CHECK-NEXT: 1 2 1
// CHECK-NEXT: 2 2 1
// CHECK-NEXT: 3 2 1
// CHECK-NEXT: 4 2 1
// CHECK-NEXT: 5 2 1
// CHECK-NEXT: 6 2 1
// CHECK-NEXT: 1 1 2
// CHECK-NEXT: 2 1 2
// CHECK-NEXT: 3 1 2
// CHECK-NEXT: 4 1 2
// CHECK-NEXT: 5 1 2
// CHECK-NEXT: 6 1 2
// CHECK-NEXT: 1 2 2
// CHECK-NEXT: 2 2 2
// CHECK-NEXT: 3 2 2
// CHECK-NEXT: 4 2 2
// CHECK-NEXT: 5 2 2
// CHECK-NEXT: 6 2 2
// CHECK-NEXT: 1 1 3
// CHECK-NEXT: 2 1 3
// CHECK-NEXT: 3 1 3
// CHECK-NEXT: 4 1 3
// CHECK-NEXT: 5 1 3
// CHECK-NEXT: 6 1 3
// CHECK-NEXT: 1 2 3
// CHECK-NEXT: 2 2 3
// CHECK-NEXT: 3 2 3
// CHECK-NEXT: 4 2 3
// CHECK-NEXT: 5 2 3
// CHECK-NEXT: 6 2 3
// CHECK-NEXT: 1 1 4
// CHECK-NEXT: 2 1 4
// CHECK-NEXT: 3 1 4
// CHECK-NEXT: 4 1 4
// CHECK-NEXT: 5 1 4
// CHECK-NEXT: 6 1 4
// CHECK-NEXT: 1 2 4
// CHECK-NEXT: 2 2 4
// CHECK-NEXT: 3 2 4
// CHECK-NEXT: 4 2 4
// CHECK-NEXT: 5 2 4
// CHECK-NEXT: 6 2 4
// CHECK-NEXT: 1 1 5
// CHECK-NEXT: 2 1 5
// CHECK-NEXT: 3 1 5
// CHECK-NEXT: 4 1 5
// CHECK-NEXT: 5 1 5
// CHECK-NEXT: 6 1 5
// CHECK-NEXT: 1 2 5
// CHECK-NEXT: 2 2 5
// CHECK-NEXT: 3 2 5
// CHECK-NEXT: 4 2 5
// CHECK-NEXT: 5 2 5
// CHECK-NEXT: 6 2 5
// CHECK-NEXT: 1 1 6
// CHECK-NEXT: 2 1 6
// CHECK-NEXT: 3 1 6
// CHECK-NEXT: 4 1 6
// CHECK-NEXT: 5 1 6
// CHECK-NEXT: 6 1 6
// CHECK-NEXT: 1 2 6
// CHECK-NEXT: 2 2 6
// CHECK-NEXT: 3 2 6
// CHECK-NEXT: 4 2 6
// CHECK-NEXT: 5 2 6
// CHECK-NEXT: 6 2 6
// CHECK-NEXT: 1 1 7
// CHECK-NEXT: 2 1 7
// CHECK-NEXT: 3 1 7
// CHECK-NEXT: 4 1 7
// CHECK-NEXT: 5 1 7
// CHECK-NEXT: 6 1 7
// CHECK-NEXT: 1 2 7
// CHECK-NEXT: 2 2 7
// CHECK-NEXT: 3 2 7
// CHECK-NEXT: 4 2 7
// CHECK-NEXT: 5 2 7
// CHECK-NEXT: 6 2 7
// CHECK-NEXT: 1 1 8
// CHECK-NEXT: 2 1 8
// CHECK-NEXT: 3 1 8
// CHECK-NEXT: 4 1 8
// CHECK-NEXT: 5 1 8
// CHECK-NEXT: 6 1 8
// CHECK-NEXT: 1 2 8
// CHECK-NEXT: 2 2 8
// CHECK-NEXT: 3 2 8
// CHECK-NEXT: 4 2 8
// CHECK-NEXT: 5 2 8
// CHECK-NEXT: 6 2 8
// CHECK-NEXT: 1 1 9
// CHECK-NEXT: 2 1 9
// CHECK-NEXT: 3 1 9
// CHECK-NEXT: 4 1 9
// CHECK-NEXT: 5 1 9
// CHECK-NEXT: 6 1 9
// CHECK-NEXT: 1 2 9
// CHECK-NEXT: 2 2 9
// CHECK-NEXT: 3 2 9
// CHECK-NEXT: 4 2 9
// CHECK-NEXT: 5 2 9
// CHECK-NEXT: 6 2 9