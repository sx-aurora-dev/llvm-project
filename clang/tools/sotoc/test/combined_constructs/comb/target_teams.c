// RUN: %sotoc-transform-compile

int main(void) {
  int j = 0;

  #pragma omp target teams device(0)
  {  j++;
  }
  return 0;
}
