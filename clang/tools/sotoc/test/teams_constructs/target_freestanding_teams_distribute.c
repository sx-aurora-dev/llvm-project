// RUN: %sotoc-transform-compile | %sotoc-filecheck-transformed

int main(void) {
  int j = 0;
    
  #pragma omp target
  {
    //CHECK-NOT: teams
    //CHECK-NOT: distribute
    #pragma omp teams distribute num_teams(1)
    for(int i = 0; i < 10; i++) {
      j++;
    }
  }

  return 0;
}
