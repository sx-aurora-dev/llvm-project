#include <stdio.h>

int main(void) {
  int sum = 0;
  for (int i = 0; i < 1000; ++i) {
    sum += i;
  }
  // 40 iterations
  for (int i = 60; i < 100; ++i) {
    sum += i;
  }
  return sum;
}
