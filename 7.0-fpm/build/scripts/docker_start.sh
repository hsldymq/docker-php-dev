 #!/bin/sh

function start() {
    prepareDirectories
    tryStartingSyslog
    
    php-fpm
} 

function prepareDirectories() {
    prepareDirFromEnv "XDEBUG_PROFILER_DIR"
    prepareDirFromEnv "XDEBUG_TRACE_DIR"
    prepareDirFromEnv "XHPROFILE_DIR"
}

function prepareDirFromEnv() {
    eval DIR=\$$1

    if [ $DIR ]; then
        mkdir -p $DIR
        chmod 777 $DIR
    fi
}

function tryStartingSyslog() {
    if [ "${SYSLOG}" = "on" ]; then
        syslog-ng
    fi
}

start
