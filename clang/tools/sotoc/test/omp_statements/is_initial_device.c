// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s

#include <omp.h>
#include <stdio.h>

int main() {
  int isOfld;
  int isHost = omp_is_initial_device();

#pragma omp target map(from: isOfld)
  {
    isOfld = omp_is_initial_device();
  }

  printf("%d %d\n",isHost,isOfld);

  return 0;
}

//CHECK: 1 0
