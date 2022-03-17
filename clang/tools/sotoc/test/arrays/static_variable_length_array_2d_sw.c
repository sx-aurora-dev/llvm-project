// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s

#include <stdio.h>

int main(){
  int j;
  int size=512;
  float A[2][size];

  #pragma omp target map(tofrom:A[:2][:size])
  {
    int i;
    for(i=0; i< size; i++){
      A[0][i]=i;
      A[1][i]=i+1;
    }
  }

  for (j = 0; j < size; j+=64) {
    printf("%.2f %.2f ",A[0][j],A[1][j]);
  }
  return 0;
}

// CHECK: 0.00 1.00 64.00 65.00 128.00 129.00 192.00 193.00 256.00 257.00 320.00 321.00 384.00 385.00 448.00 449.00
