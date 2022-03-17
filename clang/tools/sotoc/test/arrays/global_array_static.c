// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s

#include <stdio.h>
#include <stdlib.h>

#pragma omp declare target
int X[10];
#pragma omp end declare target

int main(void) {

  int tmp = 0;

  #pragma omp target update to(X[:10])
  #pragma omp target
  {
    for (int i = 0; i < 10; ++i) {
      X[i] = 1;
    }
  }
  #pragma omp target update from(X[:10])

  for (int i = 0; i < 10; ++i) {
    tmp += X[i];
  }

  printf("%d",tmp);
  fflush(0);
  return 0;
}

// CHECK: 10
