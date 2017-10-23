FROM php:7.0-fpm-alpine

ADD build/ /docker-build/

RUN rm -rf /var/www/html && \
    cp /docker-build/scripts/docker_start.sh /usr/bin/docker_start.sh && \
    chmod a+x /usr/bin/docker_start.sh

RUN echo -e "https://mirrors.ustc.edu.cn/alpine/latest-stable/main\nhttps://mirrors.ustc.edu.cn/alpine/latest-stable/community" > /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk --no-cache add ca-certificates && update-ca-certificates && \
    apk --no-cache add \
        autoconf \
        build-base \
        zlib-dev \
        libtool \
        linux-headers \
        postgresql-dev \
        imap-dev \
        bzip2-dev \
        libmcrypt-dev \
        freetype-dev \
        libpng-dev \
        libjpeg-turbo-dev \
        libevent-dev \
        cyrus-sasl-dev \
        rabbitmq-c-dev \
        libmemcached-dev \
        pcre-dev \
        unixodbc-dev \
        imagemagick-dev \
        openssl \
        openssh-client \
        graphviz \
        ttf-dejavu \
        ttf-droid \
        ttf-freefont \
        ttf-liberation \
        ttf-ubuntu-font-family \
        rsyslog

RUN docker-php-ext-install \
        bcmath \
        bz2 \
        exif \
        imap \
        mcrypt \
        mysqli \
        pcntl \
        pdo_mysql \
        pdo_pgsql \
        pgsql \
        sockets \
        zip

# 1. event扩展依赖sockets扩展,修改文件名使得sockets先于event载入. 不修改文件名会是的event先于sockets载入,使得php无法启动
# 2. 安装GD库扩展
RUN mv /usr/local/etc/php/conf.d/docker-php-ext-sockets.ini /usr/local/etc/php/conf.d/0-docker-php-ext-sockets.ini && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd

## 安装各种扩展
RUN echo -e "\n" | pecl install file:///docker-build/php-extensions/amqp-1.9.1.tgz && \
    echo -e "\n" | pecl install file:///docker-build/php-extensions/ev-1.0.4.tgz && \
    echo -e "\n\n\n\n\n\n\n" | pecl install file:///docker-build/php-extensions/event-2.3.0.tgz && \
    echo -e "/usr\n" | pecl install file:///docker-build/php-extensions/memcached-3.0.3.tgz && \
    pecl install file:///docker-build/php-extensions/mongodb-1.2.9.tgz && \
    pecl install file:///docker-build/php-extensions/redis-3.1.2.tgz && \
    pecl install file:///docker-build/php-extensions/pdo_sqlsrv-4.1.6.1.tgz && \
    pecl install file:///docker-build/php-extensions/swoole-1.9.13.tgz && \
    echo -e "\n" | pecl install file:///docker-build/php-extensions/imagick-3.4.3.tgz && \
    pecl install file:///docker-build/php-extensions/xdebug-2.5.4.tgz && \
    docker-php-ext-enable amqp ev event memcached mongodb redis pdo_sqlsrv swoole imagick xdebug && \
    cd /docker-build/php-extensions/xhprof/extension && \
    phpize && ./configure && make && make install && \
    cd /var/www && rm -rf /docker-build

# 设置xdebug profiler & tracer
RUN echo -e "xdebug.profiler_output_dir=\${XDEBUG_PROFILER_DIR}" >> /usr/local/etc/php/conf.d/xdebug_config.ini && \
    echo -e "xdebug.trace_output_dir=\${XDEBUG_TRACE_DIR}" >> /usr/local/etc/php/conf.d/xdebug_config.ini && \
    echo -e "xdebug.idekey=\${XDEBUG_IDEKEY}" >> /usr/local/etc/php/conf.d/xdebug_config.ini

# 设置xhprof
RUN echo -e "extension=xhprof.so" >> /usr/local/etc/php/conf.d/xhprof.ini && \
    echo -e "xhprof.output_dir=\${XHPROFILE_DIR}" >> /usr/local/etc/php/conf.d/xhprof.ini

WORKDIR /var/www

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["docker_start.sh"]

EXPOSE 9000

