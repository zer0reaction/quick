#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "You must specify the name of the directory"
    exit 1
fi

directory_name=$1

if [[ -d ${directory_name} ]]; then
    echo "Specified directory already exists"
    exit 2
fi

source_main='#include <stdio.h>

int main(void) {
  printf("Hello, world!\n");
  return 0;
}'

source_build="#!/bin/bash

CC='gcc'

WARNFLAGS='-Wall -Wextra -Wconversion -Wunused -Wfloat-equal -Wundef
-Wshadow -Wpointer-arith -Wcast-align -Wstrict-prototypes
-Wwrite-strings -Wswitch-default -Wswitch-enum -Wunreachable-code
-Wformat=2 -Wuninitialized -Winit-self'

CFLAGS='-O2 -std=c99 -fsanitize=address,undefined'

set -xe

\${CC} \${WARNFLAGS} \${CFLAGS} -o main main.c"

set -e

mkdir ${directory_name}
cd ${directory_name}

echo "${source_main}" > main.c
echo "${source_build}" > build.sh
chmod 755 build.sh

echo "Generated template directory \"${directory_name}\""
