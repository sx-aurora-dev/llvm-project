// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s

#include <stdio.h>

int main(void) {
  int h = 0, j = 1, i = 1;

  #pragma omp target data  map(to: j,i) map(from: h)
  {
    #pragma omp target  map(to: j,i) map(from: h)
    {
      h = j + i;
    }
    #pragma omp target  map(to: j,i) map(tofrom: h)
    {
      h += j + i;
    }
  }

  printf("%d\n", h);

  return 0;
}

// CHECK: 4
