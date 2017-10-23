 #!/bin/sh

function start() {
    prepareDirectories
    runSyslog
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
        mkdir -vp $DIR
        chmod 777 $DIR
    fi
}

function runSyslog() {
    if [ "${SYSLOG}" = "on" ]; then
        if [ $SYSLOG_REMOTE_ADDR ]; then
            SLR_ADDR=$SYSLOG_REMOTE_ADDR
            if [ $SYSLOG_REMOTE_PORT ]; then
                SLR_PORT=$SYSLOG_REMOTE_PORT
            else
                SLR_PORT=9997
            fi
        fi
        rsyslogd
    fi
}

start
