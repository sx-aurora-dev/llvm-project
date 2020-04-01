// RUN: %sotoc-transform-compile

enum MyEnum {
  ZERO = 0,
  ONE,
  TWO,
  THREE
};

struct MyOtherStruct {
  int two;
  enum MyEnum three;
  enum MyInlineEnum {
    FOUR,
    FIVE
  } four;
};

typedef struct {
  int one;
  struct MyOtherStruct two;
} MyStruct;

int main(void) {
  int h = 0;

  #pragma omp target
  {
    MyStruct S;
    S.one = 1;
    S.two.two = 2;
    S.two.three = THREE;
    h += S.one;
  }

  return 0;
}
