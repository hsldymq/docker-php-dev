FROM php:7.2-fpm-alpine3.10

ADD build/ /docker-build/

# 预先准备环境目录,删除无用文件/目录
RUN rm -rf /var/www/html && \
    cp /docker-build/scripts/docker_start.sh /usr/bin/docker_start.sh && \
    chmod a+x /usr/bin/docker_start.sh

RUN echo -e "https://mirrors.aliyun.com/alpine/v3.10/main\n" > /etc/apk/repositories && \
    echo -e "https://mirrors.aliyun.com/alpine/v3.10/community\n" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add --no-cache ca-certificates \
        autoconf \
        build-base \
        gdb \
        strace && \
    update-ca-certificates

RUN apk add --no-cache \
        zlib-dev \
        libtool \
        linux-headers \
        libmcrypt-dev \
        libevent-dev \
        cyrus-sasl-dev \
        rabbitmq-c-dev \
        libmemcached-dev \
        imagemagick-dev \
        imagemagick \
        pcre-dev \
        unixodbc-dev \
        openssl \
        openssh-client \
        procps && \
    update-ca-certificates

RUN docker-php-ext-install bcmath && \
    apk --no-cache add bzip2-dev && \
    docker-php-ext-install bz2 && \
    docker-php-ext-install exif && \
    apk --no-cache add freetype-dev libpng-dev libjpeg-turbo-dev && \
    docker-php-ext-configure gd --with-freetype-dir=/usr --with-jpeg-dir=/usr --with-png-dir=/usr &&
    docker-php-ext-install gd && \
    apk add --no-cache gettext-dev && \
    docker-php-ext-install gettext && \
    apk --no-cache add gmp-dev && \
    docker-php-ext-install gmp && \
    apk --no-cache add imap-dev && \
    docker-php-ext-install imap && \
    apk add --no-cache icu-dev && \
    docker-php-ext-install intl && \
    apk add --no-cache openldap-dev && \
    docker-php-ext-install ldap && \
    docker-php-ext-install mysqli && \
    docker-php-ext-install pcntl && \
    docker-php-ext-install pdo_mysql && \
    apk add --no-cache postgresql-dev && \
    docker-php-ext-install pdo_pgsql && \
    docker-php-ext-install pgsql && \
    apk add --no-cache libxml2-dev && \
    docker-php-ext-install soap && \
    docker-php-ext-install sockets && \
    docker-php-ext-install sysvmsg && \
    docker-php-ext-install sysvsem && \
    docker-php-ext-install sysvshm && \
    docker-php-ext-install zip

## 安装各种扩展 
RUN echo -e "\n" | pecl install file:///docker-build/php-extensions/amqp-1.9.1.tgz && \
    echo -e "\n" | pecl install file:///docker-build/php-extensions/ev-1.0.4.tgz && \
    echo -e "\n\n\n\n\n\n\n" | pecl install file:///docker-build/php-extensions/event-2.3.0.tgz && \
    echo -e "/usr\n" | pecl install file:///docker-build/php-extensions/memcached-3.0.3.tgz && \
    pecl install file:///docker-build/php-extensions/mongodb-1.4.2.tgz && \
    pecl install file:///docker-build/php-extensions/redis-3.1.2.tgz && \
    pecl install file:///docker-build/php-extensions/swoole-4.3.5.tgz && \
    echo -e "\n" | pecl install file:///docker-build/php-extensions/imagick-3.4.3.tgz && \
    pecl install file:///docker-build/php-extensions/inotify-2.0.0.tgz && \
    pecl install file:///docker-build/php-extensions/grpc-1.21.3.tgz && \
    pecl install file:///docker-build/php-extensions/protobuf-3.8.0.tgz && \
    pecl install file:///docker-build/php-extensions/sync-1.1.1.tgz && \
    pecl install file:///docker-build/php-extensions/xdebug-2.7.2.tgz && \
    docker-php-ext-enable amqp ev event memcached mongodb redis swoole imagick inotify grpc protobuf sync xdebug && \
    cd /docker-build/php-extensions/xhprof/extension && \
    phpize && ./configure && make && make install && \
    cd /docker-build/php-extensions/sysvmsg && \
    phpize && ./configure && make && make install && \
    cd /docker-build/php-extensions/sysvsem && \
    phpize && ./configure && make && make install && \
    cd /docker-build/php-extensions/sysvshm && \
    phpize && ./configure && make && make install && \
    cd /var/www && rm -rf /docker-build

# 设置ini
# xdebug profiler & tracer
# curl & openssl 设置CA证书验证文件路径, 默认情况下个别场景会造成 SSL certificate problem: unable to get local issuer certificate错误
RUN echo -e "xdebug.profiler_output_dir=\${XDEBUG_PROFILER_DIR}" >> /usr/local/etc/php/conf.d/xdebug_config.ini && \
    echo -e "xdebug.trace_output_dir=\${XDEBUG_TRACE_DIR}" >> /usr/local/etc/php/conf.d/xdebug_config.ini && \
    echo -e "xdebug.idekey=\${XDEBUG_IDEKEY}" >> /usr/local/etc/php/conf.d/xdebug_config.ini && \
    echo "curl.info=/etc/ssl/cert.pem" > /usr/local/etc/php/conf.d/curl.ini && \
    echo "openssl.cafile=/etc/ssl/cert.pem" > /usr/local/etc/php/conf.d/openssl.ini

# 设置启动并配置编译的扩展
RUN echo -e "extension=xhprof.so" >> /usr/local/etc/php/conf.d/xhprof.ini && \
    echo -e "xhprof.output_dir=\${XHPROFILE_DIR}" >> /usr/local/etc/php/conf.d/xhprof.ini

WORKDIR /var/www

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["docker_start.sh"]

EXPOSE 9000
