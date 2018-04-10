// RUN: %sotoc-transform-compile

#pragma omp declare target

int X = 1;

#pragma omp end declare target

int main(void) {
  int h = 0;

  #pragma omp target device(0) 
  {
    h += X;
  }

  return 0;
}
