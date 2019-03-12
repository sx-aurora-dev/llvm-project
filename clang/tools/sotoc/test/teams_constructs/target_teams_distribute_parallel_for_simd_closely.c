// RUN: %sotoc-transform-compile | %sotoc-filecheck-transformed

int main(void) {
  int j = 0;

  //CHECK-NOT: distribute
  //CHECK-NOT: teams
  #pragma omp target device(0) 
  #pragma omp teams distribute parallel for simd num_threads(10)
    for(int i = 0; i < 10; i++) {
      j++;
    }  

  return 0;
}
