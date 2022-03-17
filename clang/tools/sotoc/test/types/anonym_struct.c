// RUN: %sotoc-transform-compile

#include <stdio.h>
#include <stdlib.h>

int main() {

  struct {
    int a;
    int b[1000];
    int *p;
  } single;

  single.p = (int*) malloc(5 * sizeof(int));

#pragma omp target enter data map(to: single)
#pragma omp target map(alloc: single)
  {
    single.a = 1;
    for (int i = 0; i < 1000; ++i)
      single.b[i] = 1;

  }
  return 0;
}
