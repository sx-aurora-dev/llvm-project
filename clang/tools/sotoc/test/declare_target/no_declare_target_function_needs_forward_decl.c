// RUN: %sotoc-transform-compile

int add_x_to_var(int var, int x);

int add_one_to_var(int var) {
  return add_x_to_var(var, 1);
}

int add_x_to_var(int var, int x) {
  return var + x;
}

int main(void) {
  int h = 0;

  #pragma omp target
  {
    h = add_one_to_var(h);
  }


  return 0;
}
