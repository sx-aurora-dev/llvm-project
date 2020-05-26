// RUN: %sotoc-transform-compile

int main(void) {
  int j = 0;

  #pragma omp target parallel  num_threads(10)
  {
    j++;
  }
  return 0;
}
