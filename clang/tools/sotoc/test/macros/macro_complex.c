// RUN: %sotoc-transform-compile

#include <stdio.h>

#define WARN_IF(EXP) \
    if(EXP) \
    printf("Warning: " #EXP "\n")

int main(){
  #pragma omp target
  {
    int x = 0;
    WARN_IF (x==0);
  }
  return 0;
}

