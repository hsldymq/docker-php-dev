 #!/bin/sh

if [ ${SYSLOG} = "on" ]; then
    if [ ${SYSLOG_REMOTE_ADDR} ]; then
        SLR_ADDR=$SYSLOG_REMOTE_ADDR
        if [ ${SYSLOG_REMOTE_PORT} ]; then
            SLR_PORT=$SYSLOG_REMOTE_PORT
        else
            SLR_PORT=9997
        fi
    fi
    rsyslogd
fi

 php-fpm