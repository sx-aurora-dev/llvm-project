// RUN: %sotoc-transform-compile | %sotoc-filecheck-transformed 

int main(void) {
  int j = 0;

  #pragma omp target
  {
  //CHECK-NOT: teams
    #pragma omp teams
    {
      j++;
    }
  }
  return 0;
}
