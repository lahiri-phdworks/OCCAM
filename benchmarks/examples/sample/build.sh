#!/usr/bin/env bash

export OCCAM_LOGFILE=${PWD}/slash/occam.log
export OCCAM_LOGLEVEL=INFO

LIBRARY='example'

unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   LIBRARY='example.so'
elif [[ "$unamestr" == 'Darwin' ]]; then
   LIBRARY='example.dylib'
fi

cat > example.manifest <<EOF
{ "main" : "example.o.bc"
, "binary"  : "example"
, "modules"    : ["${LIBRARY}.bc"]
, "native_libs" : []
, "static_args"    : ["sumit", "lahiri"]
, "name"    : "example"
}
EOF

#make the bitcode
CC=gclang make all  
get-bc example.o
get-bc ${LIBRARY}


# slash
slash --work-dir=slash example.manifest
cp slash/example example_slash

#debugging stuff below:
for bitcode in slash/*.bc; do
    llvm-dis  "$bitcode" &> /dev/null
done

