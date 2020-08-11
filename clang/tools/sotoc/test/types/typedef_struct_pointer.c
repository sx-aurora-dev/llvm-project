// RUN: %sotoc-transform-compile
#include <stdlib.h>

typedef struct node {
    int data;
    struct node *next;
} node_t;


int main() {
  node_t *list = malloc(sizeof(node_t));
  node_t *current = list;
  current->next = NULL;
  current->data = 0;
  #pragma omp target enter data map(to:current[0:1])
  #pragma omp target
  {
    current->data += 1;
  }

}
