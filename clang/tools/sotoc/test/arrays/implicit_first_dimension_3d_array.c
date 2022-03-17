// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s

#include <stdio.h>

int main(){
  int size1 = 256;
  int size2 = 384;
  int size3 = 512;
  int array[size1][size2][size3];
  int (*imp_dim_array)[size2][size3] = array;

  #pragma omp target map(tofrom: imp_dim_array[0:size1][0:size2][0:size3])
  {
    for (int i = 0; i < size1; ++i) {
      for (int j = 0 ; j < size2; ++j) {
        for (int k = 0; k < size3; ++k) {
          imp_dim_array[i][j][k] = i + j + k;
        }
      }
    }
  }

  for (int i = 0; i < size1; i += 32) {
    printf("%d ", array[i][i][i]);
  }

  printf("%d", array[7][17][73]);

  return 0;
}

// CHECK: 0 96 192 288 384 480 576 672 97