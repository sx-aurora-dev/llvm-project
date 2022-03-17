// RUN: %sotoc-transform-compile
#include <stdio.h>

#pragma omp declare target
void preprocess_array();
void process_array();
void postprocess_array();
void print_array();
#pragma omp end declare target

int main (){
  #pragma omp target
  {
    preprocess_array();
    process_array();
    postprocess_array();
    print_array();
  }
  return 0;
}

