#include <stdio.h>

int main(void) {
  // This is the Collatz sequence. We
  // don't know, without running the code,
  // when it will finish (it hasn't been
  // proved if it will even finish but that's
  // another story).
  int n = 20384;
  int count = 0;
  do {
    count++;
    if (n % 2 == 0)
      n = n / 2;
    else
      n = 3*n + 1;
  } while (n != 1);
  printf("%d\n", count);
}
