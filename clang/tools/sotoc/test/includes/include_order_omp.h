// RUN: %sotoc-transform | %filecheck %s --input-file=%t.transformed.c

#include <omp.h>

// CHECK: #include <stdint.h>

int main(){
  uint64_t i = 0;

  // Use a function from omp.h for something
  int j = omp_get_num_threads();
  printf("Host is running with %i threads\n", j);

  // run a target region that operates on uint64_t
  #pragma omp target map(tofrom:i)
  {
    i += 1;
  }
}

