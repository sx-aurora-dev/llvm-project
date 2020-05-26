// RUN: %sotoc-transform-compile | %sotoc-filecheck-transformed

int main(void) {
  int j = 0;

  #pragma omp target
  {    
    #pragma omp teams
    {
      //CHECK-NOT: distribute
      //CHECK-NOT: teams
      j++;
      #pragma omp distribute
      for (int i = 0; i < 100; ++i) {
        j++;
      }
    }
  }
  return 0;
}
