// RUN: %sotoc-transform-compile
#include <stdio.h>

#pragma omp declare target
void print_array();
#pragma omp end declare target

int main (){
  #pragma omp target
  {
    print_array();
  }
  return 0;
}

