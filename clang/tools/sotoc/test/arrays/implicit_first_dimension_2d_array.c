// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s

#include <stdio.h>

int main(){
  int size1 = 256;
  int size2 = 512;
  int array[size1][size2];
  int (*imp_dim_array)[size2] = array;

  #pragma omp target map(tofrom: imp_dim_array[0:size1][0:size2])
  {
    for (int i = 0; i < size1; ++i) {
      for (int j = 0 ; j < size2; ++j) {
        imp_dim_array[i][j] = i - j;
      }
    }
  }

  for (int i = 0; i < size1; i += 32) {
    printf("%d ", array[i][0]);
  }

  printf("%d", array[17][73]);

  return 0;
}

// CHECK: 0 32 64 96 128 160 192 224 -56