#!/bin/bash

directory_name='quick_template'

source_main='#include <stdio.h>

int main(void)
{
    printf("Hello, world!\n");
    return 0;
}'

source_build="#!/bin/bash

CC='gcc'
CFLAGS='-Wall -Wextra -std=c99 -fsanitize=address,undefined'

set -xe

\${CC} \${CFLAGS} -o main main.c"

set -e

mkdir ${directory_name}
cd ${directory_name}

echo "${source_main}" > main.c
echo "${source_build}" > build.sh
chmod 755 build.sh

echo "Generated template directory \"${directory_name}\""
