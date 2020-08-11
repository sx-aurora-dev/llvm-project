// RUN: %sotoc-transform-compile
// RUN: %run-on-host

#include <stdio.h>

int main(){
    int bla();
      #pragma omp target
      printf("%d\n",bla());
}

int bla(){
    return 42;
};

