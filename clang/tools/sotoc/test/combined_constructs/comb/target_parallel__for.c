// RUN: %sotoc-transform-compile

int main(void) {
  int j = 0;

  #pragma omp target parallel device(0) num_threads(10)
  {
//    #pragma omp for
//      for(int i = 0; i < 10; i++){
      {
        j++;
      }
  }	

  return 0;
}
