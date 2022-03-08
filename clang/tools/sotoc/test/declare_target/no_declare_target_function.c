// RUN: %sotoc-transform-compile


int add_one_to_var(int var) {
  return var + 1;
}


int main(void) {
  int h = 0;

  #pragma omp target
  {
    h = add_one_to_var(h);
  }


  return 0;
}
