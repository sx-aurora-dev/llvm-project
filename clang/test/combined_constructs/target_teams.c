// RUN: %sotoc-transform-compile

int main() {

  #pragma omp target teams
  {
    // non-empty
  }

  return 0;
}

