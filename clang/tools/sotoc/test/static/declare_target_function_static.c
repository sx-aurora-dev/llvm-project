// RUN: %sotoc-static-compile && %t.o  | %filecheck %s

#include <stdio.h>

#pragma omp declare target

int add_one_to_var(int var) {
  return var + 1;
}

#pragma omp end declare target

int main(void) {
  int h = 0;

#pragma omp target  map(tofrom: h)
  {
    h = add_one_to_var(h);
  }

  printf("%d",h);
  return 0;
}

// CHECK: 1
