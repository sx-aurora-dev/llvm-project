#include <stdio.h>

int main(void) {
  int n;
  printf("Give number: ");
  scanf("%d", &n);
  for (int i = 0; i < n; ++i) {
  }

  int sum = 0;
  for (int i = 0; i < 1000; ++i) {
    sum += i;
  }
  return sum;
}
