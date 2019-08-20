 #!/bin/sh

function start() {
    prepareDirs

    php-fpm
} 

function prepareDirs() {
    makeDIR "${XHPROF_OUTPUT_DIR}"
}

function makeDIR() {
    DIR=$1

    if [ $DIR ]; then
        mkdir -p $DIR
        chmod 777 $DIR
    fi
}

start
