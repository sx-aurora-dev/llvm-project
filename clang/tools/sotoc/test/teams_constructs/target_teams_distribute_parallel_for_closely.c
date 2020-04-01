// RUN: %sotoc-transform-compile | %sotoc-filecheck-transformed

int main(void) {
  int j = 0;

  //CHECK-NOT: teams
  //CHECK-NOT: distribute
  #pragma omp target
  #pragma omp teams distribute parallel for num_threads(10)
    for(int i = 0; i < 10; i++) {
      j++;
    }

  return 0;
}
