// RUN: %sotoc-transform-compile

#define N 42

int main(){
  #pragma omp target
  {
    int i = 23;
    int j = N;
    if(i!=N) {
      i+=j;
    }
  }
  return 0;
}

