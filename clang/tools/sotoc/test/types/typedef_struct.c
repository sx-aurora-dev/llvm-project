// RUN: %sotoc-transform-compile


typedef struct {
  int one;
} MyStruct;

int main(void) {
  int h = 0;

  #pragma omp target
  {
    MyStruct S = { 1 };
    h += S.one;
  }

  return 0;
}
