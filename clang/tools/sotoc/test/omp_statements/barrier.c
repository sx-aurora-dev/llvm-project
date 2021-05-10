// RUN: %sotoc-transform-compile

int main(void) {
  int h = 0;
  int i = 0;

  #pragma omp target
  #pragma omp parallel num_threads(10)
  {
  #pragma omp for nowait
  for (i = 0; i < 10; ++i) {
    h += 1;

  }
  #pragma omp barrier
}
  return 0;
}
