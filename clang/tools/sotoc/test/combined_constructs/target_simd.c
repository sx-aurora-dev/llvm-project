// RUN: %sotoc-transform-compile

int main(void) {
  int j = 0;

  #pragma omp target simd
    for(int i = 0; i < 10; i++) {
      j++;
    }
  return 0;
}
