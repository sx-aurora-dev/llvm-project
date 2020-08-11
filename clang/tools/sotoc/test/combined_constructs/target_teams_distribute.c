// RUN: %sotoc-transform-compile

int main(void) {
  int j = 0;
    
  #pragma omp target teams distribute  num_teams(1)
    for(int i = 0; i < 10; i++) {
      j++;
    }

  return 0;
}
