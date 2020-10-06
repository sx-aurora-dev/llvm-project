// RUN: %sotoc-library-compile && %compile-for-target %t.lib.so && %t.o

#pragma omp declare target
int target_func_in_lib(int x, int y);
#pragma omp end declare target

#ifndef IS_LIBRARY
#include <stdio.h>


int main(void) {

  int a = 0;
  int b = 2;
  int c = 1;
  #pragma omp target
  {
    a = target_func_in_lib(b, c);
  }

  printf("%i", a);
  fflush(0);
  // CHECK: 1
  return 0;
}

#else

int target_func_in_lib(int x, int y) {
  return x - y;
}

#endif
