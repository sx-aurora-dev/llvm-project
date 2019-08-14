// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s

#include <stdio.h>

#pragma omp declare target

int X = 1;

#pragma omp end declare target

int main(void) {
  int h = 0;

#pragma omp target  map(tofrom: h)
  {
    h += X;
  }

  printf("%d",h);
  return 0;
}

// CHECK: 1
