// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s

#include <stdio.h>

int main(){
  int j;
  int sizeX=512;
  int sizeY=512;
  float A[sizeX][sizeY];

  #pragma omp target map(tofrom:A[0:sizeX/2][0:sizeY])
  {
    int i;
    int j;
    for(i=0; i< sizeX/2; i++){
      for(j=0 ; j< sizeY; j++){
        A[i][j]=i-j;
      }
    }
  }

  #pragma omp target map(tofrom:A[sizeX/2:sizeX/2][0:sizeY])
  {
    int i;
    int j;
    for(i=sizeX/2; i< sizeX; i++){
      for(j=0; j< sizeY; j++){
        A[i][j]=i-j;
      }
    }
  }
  for (j = 0; j < sizeX; j+=64) {
    printf("%.2f ",A[j][j]);
  }

  printf("%.2f ",A[0][1]);

  return 0;
}

// CHECK: 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 -1.00
