OS   =  $(shell uname)
LIBRARYNAME=example
CC=gclang 

ifeq (Darwin, $(findstring Darwin, ${OS}))
#  DARWIN
LIB = ${LIBRARYNAME}.dylib
LIBFLAGS = -Wall -fPIC -dynamiclib
else
# LINUX
LIB = ${LIBRARYNAME}.so
LIBFLAGS = -shared -fPIC  -Wl,-soname,${LIB}
endif

OBJS = example.o 
CFLAGS = -Wall
all: example

${LIB}: example.c
	${CC} ${CFLAGS} ${LIBFLAGS}  example.c -o ${LIB}

%.o: %.c
	${CC} ${CFLAGS} $< -c

example:  ${OBJS} ${LIB}
	${CC}  ${CFLAGS}  ${OBJS} -o example ${LIB}

clean:
	rm -f .example.c .example.c.o
	rm -f *~ ${LIB} .*.bc *.bc *.ll *.o *.manifest example
	rm -rf slash example_slash
