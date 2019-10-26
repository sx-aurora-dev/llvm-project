// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s
#include <omp.h>
#include <stdio.h>

int main() {
  omp_set_num_threads(4);
#pragma omp parallel
  {
#pragma omp target
    { printf("DEBUG\n"); fflush(0); } // End target
  }
  return 0;
}

// CHECK: DEBUG
