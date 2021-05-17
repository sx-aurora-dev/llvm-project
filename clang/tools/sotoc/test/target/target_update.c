// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s

#include <stdio.h>

int main(void) {
  int h = 0, j = 1, i = 1;

  #pragma omp target data  map(to: h,j,i)
  {
    #pragma omp target  map(to: j,i) map(from: h)
    {
      h = j + i;
    }
    #pragma omp target update  from(h)
  }

  printf("%d\n", h);

  return 0;
}

// CHECK: 2
