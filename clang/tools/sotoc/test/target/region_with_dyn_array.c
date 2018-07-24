// RUN: %sotoc-transform-compile
#include <stdlib.h>

int main(void) {
  int h = 0, i = 0;
  double *j = calloc(100, sizeof(double));


  #pragma omp target device(0) map(tofrom:j[0:100])
  {
    h += 1;
    i += 1;
    j[10] = 10.0;
  }

  return 0;
}
