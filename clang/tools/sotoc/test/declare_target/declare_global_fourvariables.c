// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s

#include <stdio.h>

#pragma omp declare target

int X = 2*23;
int Y = 23;
int Z = 23-4;

#pragma omp end declare target

int main(void) {
  int h = 0;

#pragma omp target  map(tofrom: h)
  {
    h = X - Y + Z;
  }

  printf("%d",h);
  return 0;
}

// CHECK: 42 
