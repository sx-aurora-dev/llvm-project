// RUN: %sotoc-transform-compile

#include <stdio.h>
#include <math.h>

void foo(){

#pragma omp target
  {
    double cosArg;
    printf("Hello\n");
    cosArg = cosf(42.0);
  }
}

