// RUN: %sotoc-transform-compile

#include <stdio.h>

typedef union {
  int a;
  float b;
} union_type;

int main() {
  #pragma omp target
  {
    union_type t;
    t.a = 1;
    printf("%d", t.a);
  }

}
