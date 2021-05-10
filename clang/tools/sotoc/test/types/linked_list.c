// RUN: %sotoc-transform-compile

#include<stdlib.h>
#include<stdio.h>

 typedef struct node {
   int data;
   struct node *next;
 } node_t;

void push(node_t * head, int data) {
  //printf("Entering push\n");
  node_t * current = head;
  while (current->next != NULL) {
    current = current->next;
  }

  /* now we can add a new variable */
  current->next = (node_t *) malloc(sizeof(node_t));
  current->next->data = data;
  current->next->next = NULL;
  //printf("Leaving push\n");
}

int main() {
  int i, sum = 0;
  node_t *head = NULL;
  head = (node_t*)malloc(sizeof(node_t));

  head->data = 0;
  head->next = NULL;

  for(i=1; i<10; ++i){
    push(head,i);
  }

  while(head->next) {
    node_t* current = head->next;
#pragma omp target enter data map(to:current[:1])
#pragma omp target
    {
      current->data += 1;
    }
#pragma omp target exit data map(from:current[:1])
    sum += current->data;
    head = head->next;
  }

  printf("%d",sum);

  return 0;
}
