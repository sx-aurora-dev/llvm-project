// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s

#include <stdio.h>

#pragma omp declare target
static int a;
#pragma omp end declare target
  
int main(){
  a = 42;
  #pragma omp target update to(a)
  #pragma omp target
  {
    printf("%d\n", a);
    fflush(0);
  }
}

// CHECK: 42 
