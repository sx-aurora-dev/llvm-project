// RUN: %compile-for-target 2>&1 | %filecheck %s
#include <stdio.h>

int main() {
  int m = 100;
  int C[100][100];
  #pragma omp target map(tofrom:C[:][:], m)
  {
    #pragma omp parallel for
    for (int i = 0; i < m; ++i) {
      #pragma omp simd
      for (int j = 0; j < m; ++j) {
        C[i][j] = C[j][i];
      }
    }
  }
}

//CHECK: Parallel routine generated.
//CHECK: Parallelized by "for".
//CHECK: Vectorized loop.
