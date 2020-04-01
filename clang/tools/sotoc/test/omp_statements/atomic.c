// RUN: %sotoc-transform-compile

int main(void) {
  int h = 0;
  int i = 0;

  #pragma omp target
  #pragma omp parallel for num_threads(10)
  for (i = 0; i < 10; ++i) {
    #pragma omp atomic update
    h ++;
  }

  return 0;
}
