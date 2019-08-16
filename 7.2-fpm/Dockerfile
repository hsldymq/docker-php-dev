FROM php:7.2-fpm-alpine3.10

ADD build/ /docker-build/

# 预先准备环境目录,删除无用文件/目录
RUN rm -rf /var/www/html && \
    cp /docker-build/scripts/docker_start.sh /usr/bin/docker_start.sh && \
    chmod a+x /usr/bin/docker_start.sh

# bz2 扩展依赖: bzip2-dev
# gd 扩展依赖: freetype-dev, libpng-dev, libjpeg-turbo-dev
# gettext 扩展依赖: gettext-dev
# gmp 扩展依赖: gmp-dev
# imap 扩展依赖: imap-dev
# intl 扩展依赖: icu-dev
# ldap 扩展依赖: openldap-dev
# pdo_pgsql 扩展依赖: postgresql-dev
# soap 扩展依赖: libxml2-dev
# amqp 扩展依赖: rabbitmq-c-dev
# event 扩展依赖: libevent-dev
# memcached 扩展依赖: libmemcached-dev
# imagick 扩展依赖: imagemagick-dev
RUN echo -e "https://mirrors.aliyun.com/alpine/v3.10/main\n" > /etc/apk/repositories && \
    echo -e "https://mirrors.aliyun.com/alpine/v3.10/community\n" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add --no-cache \
        ca-certificates \
        gdb \
        strace \
        bzip2-dev \
        freetype-dev libpng-dev libjpeg-turbo-dev \
        gettext-dev \
        gmp-dev \
        imap-dev \
        icu-dev \
        openldap-dev \
        postgresql-dev \
        libxml2-dev \
        libevent-dev \
        libmemcached-dev \
        imagemagick-dev \
        rabbitmq-c-dev && \
    update-ca-certificates

RUN docker-php-ext-configure gd --with-freetype-dir=/usr --with-jpeg-dir=/usr --with-png-dir=/usr && \
    docker-php-ext-install \
        bcmath \
        bz2 \
        exif \
        gd \
        gettext \
        gmp \
        imap \
        intl \
        ldap \
        mysqli \
        pcntl \
        pdo_mysql \
        pdo_pgsql \
        pgsql \
        soap \
        sockets \
        sysvmsg \
        sysvsem \
        sysvshm \
        zip

# 传递pecl_http_proxy参数允许在pecl install走代理,但需要将--network设置为host才能使用宿主环境的代理
ARG pecl_http_proxy

# 开启event扩展需要将ini文件重命名,它必须在sockets扩展之后被载入
RUN pear config-set http_proxy "${pecl_http_proxy}" && \
    apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS && apkDel='.phpize-deps' && \
    printf "\n" | pecl install amqp-1.9.4 && \
    printf "\n" | pecl install ev-1.0.6 && \
    printf "\n\n\n\n\n\n\n\n" | pecl install event-2.5.3 && \
    printf "\n\n\n\n\n\n\n\n\n" | pecl install memcached-3.1.3 && \
    pecl install mongodb-1.5.5 && \
    printf "\n\n" | pecl install redis-5.0.2 && \
    printf "yes\nyes\nyes\nyes\n" | pecl install swoole-4.4.3 && \
    printf "\n" | pecl install imagick-3.4.4 && \
    pecl install inotify-2.0.0 && \
    pecl install grpc-1.21.3 && \
    pecl install protobuf-3.8.0 && \
    pecl install sync-1.1.1 && \
    pecl install xdebug-2.7.2 && \
    docker-php-ext-enable event --ini-name php-ext-event.ini && \
    docker-php-ext-enable amqp ev memcached mongodb redis swoole imagick inotify grpc protobuf sync xdebug && \
    apk del --no-network $apkDel

# 设置ini
# xdebug profiler & tracer
# curl & openssl 设置CA证书验证文件路径, 默认情况下个别场景会造成 SSL certificate problem: unable to get local issuer certificate错误
# RUN echo -e "xdebug.profiler_output_dir=\${XDEBUG_PROFILER_DIR}" >> /usr/local/etc/php/conf.d/xdebug_config.ini && \
#     echo -e "xdebug.trace_output_dir=\${XDEBUG_TRACE_DIR}" >> /usr/local/etc/php/conf.d/xdebug_config.ini && \
#     echo -e "xdebug.idekey=\${XDEBUG_IDEKEY}" >> /usr/local/etc/php/conf.d/xdebug_config.ini && \
#     echo "curl.info=/etc/ssl/cert.pem" > /usr/local/etc/php/conf.d/curl.ini && \
#     echo "openssl.cafile=/etc/ssl/cert.pem" > /usr/local/etc/php/conf.d/openssl.ini

# # 设置启动并配置编译的扩展
# RUN echo -e "extension=xhprof.so" >> /usr/local/etc/php/conf.d/xhprof.ini && \
#     echo -e "xhprof.output_dir=\${XHPROFILE_DIR}" >> /usr/local/etc/php/conf.d/xhprof.ini

WORKDIR /var/www

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["docker_start.sh"]

EXPOSE 9000
