// RUN: %sotoc-transform-compile

#include <stdio.h>
#include <math.h>
#include <malloc.h>


void foo(){

#pragma omp target
  {
    double* cosArg;
    cosArg = (double*)memalign(1024,1*sizeof(double));
    *cosArg = cosf(42.0);
    printf("%f\n", *cosArg);
  }
}

