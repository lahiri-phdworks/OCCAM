#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "library.h"

int global = 666;
static void * p;

int main(int argc, char* argv[]){
  int retval = 0;


  if(argc == 1){


  } else if(argc == 2){

    /* retval =  2  *  3 */
    retval =
      libcall_int(1, atol(argv[1]))          *           // 2
      libcall_int(2, atol(argv[1]))          *           // 3
      libcall_int(global, atol(argv[1]))     *           // 3
      // no specialized (global2 is external)
      libcall_int(global2, atol(argv[1]))    *           // 3            
      libcall_float(strlen(argv[1]), 0.5F)   *           // 7
      libcall_double(strlen(argv[1]), 0.75)  *           // 17
      libcall_null_pointer(4, NULL)          *           // 5
      libcall_string(5, "Z")                 *           // 11
      // no specialized 
      libcall_global_pointer(strlen(argv[1]), &libcall_global_pointer); //13
      // no specialized
      libcall_global_pointer(strlen(argv[1]), p); //13    

  } else {

    retval = libcall_int(argc, argc);

  }


  fprintf(stderr, "main returning %d\n", retval);

  return retval;
}
