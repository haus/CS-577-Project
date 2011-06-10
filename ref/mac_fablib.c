#include <stdlib.h>
#include <stdio.h>

extern int _$MAIN();

int main() {
  return _$MAIN();
}


void * alloc(long ignore, int i) {
  void * r = (void *) malloc(i);
  if (!r) {
    fprintf(stderr,"fab library failure: out of memory. could not allocate %u elements\n", i);
    exit(1);
  };
  return r;
}


int read_int() {
  int i;
  if (scanf("%d", &i) != 1) {
    fprintf(stderr,"fab library failure: invalid integer read\n");
    exit(1);
  };
  return i;
}

void write_string(long ignore,char *s) {
  printf("%s",s);
}

void write_bool(int ignore,char b) {
  if (b)
    printf("true");
  else
    printf("false");
}

void write_int(int ignore,int i) {
  printf("%d",i);
}

void write_newline() {
  printf("\n");
}

void bounds_error() {
  fprintf(stderr,"Array bounds violation\n");
  exit(1);
}

void nil_pointer() {
  fprintf(stderr,"Nil pointer dereference\n");
  exit(1);
}
