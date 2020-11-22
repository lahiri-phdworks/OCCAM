#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int retval = 0;

  if (argc > 3) {
    retval = -2;
  } else {
    retval = -5;
  }

  fprintf(stderr, "main returning %d\n", retval);

  return 0;
}