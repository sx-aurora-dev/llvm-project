// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s

#include <stdio.h>

int main() {
  int number = 0;
  int* numberp1 = &number;
  int** numberp2 = &numberp1;
  int*** numberp3 = &numberp2;

  #pragma omp target
  for (int i = 0; i < 1000; ++i) {
    ***numberp3 += 73;
  }

  printf("%d", number);
  return 0;
}

// CHECK: 73000