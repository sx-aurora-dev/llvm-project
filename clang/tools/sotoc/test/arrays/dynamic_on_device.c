// RUN: %sotoc-transform-compile

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

int main() {
  int* array = omp_target_alloc(1000*sizeof(int),0);

#pragma omp target parallel for is_device_ptr(array)
  for (int i = 0; i < 1000; i++) {
    array[i] = 1;
    printf("SUCCESS: %x\n",&array);
  }
  return 0;
}
