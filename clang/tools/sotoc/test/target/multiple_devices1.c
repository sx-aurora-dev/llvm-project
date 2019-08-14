// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s
#include <stdio.h>

int main(void) {
  int h = 0, j = 0, i = 0;

  #pragma omp target
  {
    h += 1;
    j += 1;
    i += 1;
  }

  #pragma omp target device(1)
  {
    h += 1;
    j += 1;
    i += 1;
  }

  #pragma omp target device(2)
  {
    h += 1;
    j += 1;
    i += 1;
  }

  #pragma omp target device(3)
  {
    h += 1;
    j += 1;
    i += 1;
  }

  #pragma omp target device(4)
  {
    h += 1;
    j += 1;
    i += 1;
  }

  printf("%i %i %i\n", h, j, i);
  fflush(0);
// CHECK: 5 5 5
  return 0;
}
