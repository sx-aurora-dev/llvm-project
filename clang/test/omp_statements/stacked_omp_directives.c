// RUN: %sotoc-transform-compile

int main(void) {
  int h = 0;
  int i = 0;

  #pragma omp target device(0)
  #pragma omp parallel num_threads(10)
  #pragma omp for reduction(+:h)
  for (i = 0; i < 10; ++i) {
    h += 1;
  }

  return 0;
}
