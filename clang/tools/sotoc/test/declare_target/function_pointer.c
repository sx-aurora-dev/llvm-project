// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s
#include <stdio.h>

#pragma omp declare target
void execfunc(void(*func)(void)){
  func();
}

void foo(){
  printf("42");
  fflush(0);
}
#pragma omp end declare target

int main(void) {

#pragma omp target
  {
    execfunc(&foo);
  }
  return 0;
}

// CHECK: 42 
