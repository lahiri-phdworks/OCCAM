#include "library.h"

#include <stdio.h>
#include <stdlib.h>
#include <time.h>


int main(int argc, char* argv[]){
  int r1 = libcall(1,2);
  int r2 = libcall(3,4);
  int r3 = libcall(5,6);
  int r4 = libcall(7,8);  

  printf("%d %d %d %d\n", r1,r2,r3,r4);
  return 0;
}
