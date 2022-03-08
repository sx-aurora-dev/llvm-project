// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s

#include <stdio.h>

int main() {

  int i = 0;
  int j = 0;

  #pragma omp target 
  {

    #pragma omp parallel for private(j)
    for(i=0; i<42; i++)
    {
      for(j=0; j<42; j++){}
    }

    #pragma omp parallel for
    for(i=0; i<42; i++)
    {
      #pragma omp atomic
      j++;
    }

  printf("%d\n", j);
  fflush(0);
  }

  return 0;
}

// CHECK: 42
