// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s

#include <stdio.h>

int main(void) {

  int x[10] = {2, 3, 5, 7, 11, 13, 17, 23, 29, 31};
  int y[10] = {31, 29, 23, 17, 13, 11, 7, 5, 3, 2};
  int a = 5;
  int z[10];
  int i;
#pragma omp target parallel for simd  map(tofrom                      \
                                                   : x, y) map(from            \
                                                               : z)            \
    map(to                                                                     \
        : a, i)
  for (i = 0; i < 10; i++) {
    z[i] = x[i] + a * y[i];
  }

  for (int j = 0; j < 10; j++) {
    printf(" %d ", z[j]);
  }

  return 0;
}

// CHECK: 157  148  120  92  76  68  52  48  44  41
