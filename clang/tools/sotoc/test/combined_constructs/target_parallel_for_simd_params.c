// RUN: %sotoc-transform-compile

int main(void) {
  int j = 0;

  #pragma omp target parallel for simd  num_threads(10) reduction(+: j)
    for(int i = 0; i < 10; i++) {
      j++;
    }
  return 0;
}
