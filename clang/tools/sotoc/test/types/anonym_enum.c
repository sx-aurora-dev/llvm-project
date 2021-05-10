// RUN: %sotoc-transform-compile

#include <stdio.h>
#include <stdlib.h>


int main() {

  enum { VAL1 = 1, VAL2, VAL3, VAL4} scalar_enum = VAL1;

#pragma omp target map(tofrom: scalar_enum)
  {
    scalar_enum = VAL4;
  }

  printf("%d",scalar_enum);
}
