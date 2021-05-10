// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s
#include <stdio.h>

int main(void) {
  int h = 0, j = 0, i = 0;

  #pragma omp target map(tofrom:h,j,i)
  {
    h += 1;
    j += 1;
    i += 1;
  }

  #pragma omp target map(tofrom:h,j,i) device(1)
  {
    h += 1;
    j += 1;
    i += 1;
  }

  #pragma omp target map(tofrom:h,j,i) device(2)
  {
    h += 1;
    j += 1;
    i += 1;
  }

  #pragma omp target map(tofrom:h,j,i) device(3)
  {
    h += 1;
    j += 1;
    i += 1;
  }

  #pragma omp target map(tofrom:h,j,i) device(4)
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
