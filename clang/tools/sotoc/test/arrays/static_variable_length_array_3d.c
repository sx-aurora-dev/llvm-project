// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s

#include <stdio.h>
int main(){
  int j;
  int size=512;
  float A[size][2][5];
 
  #pragma omp target map(tofrom:A[:size][:2][:5])
  {
    int k;
    int i;
    for(i=0; i< size; i++){
      for(k=0; k< 5; k++){
        A[i][0][k]=i;
        A[i][1][k]=i+1;
      }
    }
  }

  for (j = 0; j < size; j+=64) {
    printf("%.2f %.2f ",A[j][0][3],A[j][1][2]);
  }
  return 0;
}

// CHECK: 0.00 1.00 64.00 65.00 128.00 129.00 192.00 193.00 256.00 257.00 320.00 321.00 384.00 385.00 448.00 449.00
