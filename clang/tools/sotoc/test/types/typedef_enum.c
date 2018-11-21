// RUN: %sotoc-transform-compile

#include <stdio.h>

#include "typedef_enum.h"

int main() {
  #pragma omp target
  {
    printf("%d", B);
  } 

}
