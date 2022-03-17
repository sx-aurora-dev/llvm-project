// RUN: %sotoc-transform-compile

#define NUMBERS 1, \
                2, \
                3

int main(){
  #pragma omp target
  {
    int x[] = {NUMBERS};
  }
  return 0;
}

