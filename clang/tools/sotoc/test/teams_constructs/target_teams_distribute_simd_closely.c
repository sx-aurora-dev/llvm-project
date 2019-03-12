// RUN: %sotoc-transform-compile | %sotoc-filecheck-transformed

int main(void) {
  int j = 0;

  //CHECK-NOT: teams
  //CHECK-NOT: distribute
  //CHECK: #pragma omp simd
  #pragma omp target device(0)
  #pragma omp teams distribute simd
    for(int i = 0; i < 10; i++) {
      j++;
    }

  return 0;
}
