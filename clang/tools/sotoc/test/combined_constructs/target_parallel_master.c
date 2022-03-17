// RUN: %sotoc-transform-compile

#include "stdio.h"
#include "stdlib.h"
#include "omp.h"

void main () {
#pragma omp target parallel
#pragma omp master
  printf("%d",omp_get_thread_num());
}
