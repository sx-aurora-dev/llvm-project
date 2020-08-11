// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s

#include <stdio.h>
#include <stdlib.h>

int main() {
  int* array = malloc(1000*sizeof(int));
  int sum = 0;

#pragma omp target parallel for map(tofrom: array[0:1000])
  for (int i = 0; i < 1000; i++) {
    array[i] = 1;
  }

  for (int i = 0; i < 1000; i++) {
    sum += array[i];
  }

  printf("%d", sum);

  return 0;
}

// CHECK: 1000
