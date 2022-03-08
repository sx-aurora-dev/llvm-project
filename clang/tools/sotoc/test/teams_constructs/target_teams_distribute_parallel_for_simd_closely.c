// RUN: %sotoc-transform-compile | %sotoc-filecheck-transformed

int main(void) {
  int j = 0;

  //CHECK-NOT: distribute
  //CHECK-NOT: teams
  //CHECK: _NEC ivdep
  #pragma omp target
  #pragma omp teams distribute parallel for simd num_threads(10)
    for(int i = 0; i < 10; i++) {
      j++;
    }  

  return 0;
}
