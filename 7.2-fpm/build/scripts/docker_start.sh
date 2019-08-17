 #!/bin/sh

function start() {
    prepareDirectories

    php-fpm
} 

function prepareDirs() {
    prepareDirFromEnv $XDEBUG_PROFILER_DIR
    prepareDirFromEnv $XDEBUG_TRACE_DIR
    prepareDirFromEnv $XHPROFILE_DIR
}

function makeDIR() {
    DIR=$1

    if [ $DIR ]; then
        mkdir -p $DIR
        chmod 777 $DIR
    fi
}

start
