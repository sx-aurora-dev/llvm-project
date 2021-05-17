// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s

#include <stdio.h>

#pragma omp declare target

int X, Y, Z;

#pragma omp end declare target

int main(void) {
  int h = 0;

#pragma omp target  map(tofrom: h)
  {
    X = 2*23;
    Y = 23;
    Z = 23-4;
    h = X - Y + Z;
  }

  printf("%d",h);
  return 0;
}

// CHECK: 42 
