// RUN: %sotoc-library-compile && %compile-for-target %t.lib.so && %t.o

#include <stdio.h>

int function_with_region_in_lib(int x, int y);

#ifndef IS_LIBRARY

int main(void) {
  int x = 7;
  int y = 5;
  int z = 0;

  #pragma omp target map(tofrom: z)
  {
    z = x + y;
  }

  printf("Result from Target Region in main(): %i\n", z);
  fflush(0);
  z = 0;

  z = function_with_region_in_lib(x, y);
  printf("Result from Target Region in Library: %i\n", z);
  fflush(0);
  
  return 0;
}

#else

int function_with_region_in_lib(int x, int y) {
  int z2 = 0;
  #pragma omp target map(from: z2)
  {
    z2 = x + y;
  }
  return z2;
}

#endif /*IS_LIBRARY*/
