// RUN: %sotoc-transform-compile


typedef struct {
  int one;
} MyStruct;

int main(void) {
  int h = 0;

  #pragma omp target device(0)
  {
    MyStruct S = { 1 };
    h += S.one;
  }

  return 0;
}
