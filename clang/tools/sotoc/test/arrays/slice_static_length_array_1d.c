// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s

#include <stdio.h>
int main(){
  int j;
  int size=512;
  float A[512]; 
  #pragma omp target map(tofrom:A[0:256])
  {
    int i;
    for(i=0; i< size/2; i++){
      A[i]=i;
    }
  }
  
  #pragma omp target map(tofrom:A[256:256])
  {
    int i;
    for(i=size/2; i < size; i++) {
      A[i] = i;
    }
  }

  for (j = 0; j < size; j+=64) {
    printf("%.2f ",A[j]);
  }
  return 0;
}

// CHECK: 0.00 64.00 128.00 192.00 256.00 320.00 384.00 448.00
