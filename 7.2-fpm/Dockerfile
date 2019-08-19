FROM php:7.2-fpm-alpine3.10 as temp

COPY extensions /extensions
RUN echo -e "https://mirrors.aliyun.com/alpine/v3.10/main\n" > /etc/apk/repositories && \
    echo -e "https://mirrors.aliyun.com/alpine/v3.10/community\n" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS && \
    cd /extensions/tideways_xhprof && phpize && ./configure && make && make install && \
    mkdir /php-ext && \
    cp $(php-config --extension-dir)/tideways_xhprof.so /php-ext

FROM php:7.2-fpm-alpine3.10

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

COPY --from=temp /php-ext/tideways_xhprof.so /php-ext/tideways_xhprof.so

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
    mv /php-ext/tideways_xhprof.so $(php-config --extension-dir) && \
    docker-php-ext-enable event --ini-name php-ext-event.ini && \
    docker-php-ext-enable amqp ev memcached mongodb redis swoole imagick inotify grpc protobuf sync xdebug tideways_xhprof && \
    apk del --no-network $apkDel

COPY php.ini /usr/local/etc/php/php.ini
COPY docker_start.sh /usr/bin/docker_start.sh
RUN chmod a+x /usr/bin/docker_start.sh

ENV PHP_MAX_EXECUTE_TIME 30
ENV PHP_MEMORY_LIMIT 128M
ENV PHP_POST_MAX_SIZE 8M
ENV PHP_UPLOAD_MAX_FILESIZE 8M
ENV PHP_MAX_FILE_UPLOADS 20
ENV PHP_SESSION_NAME PHPSESSIONID
ENV PHP_SESSION_SAVE_HANDLER files
ENV PHP_SESSION_SAVE_PATH ""
ENV PHP_XDEBUG_REMOTE_ENABLE 0
ENV PHP_XDEBUG_REMOTE_HOST localhost
ENV PHP_XDEBUG_REMOTE_PORT 9000
ENV PHP_XDEBUG_IDEKEY PHPSTORM
ENV PHP_XHPROF_DIR ""

WORKDIR /var/www

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["docker_start.sh"]

EXPOSE 9000
