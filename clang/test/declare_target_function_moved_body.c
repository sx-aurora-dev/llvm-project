// RUN: %sotoc-transform-compile

#pragma omp declare target

int add_one_to_var(int var);

#pragma omp end declare target

int main(void) {
  int h = 0;

  #pragma omp target device(0)
  {
    h = add_one_to_var(h);
  }


  return 0;
}


int add_one_to_var(int var) {
  return var + 1;
}
