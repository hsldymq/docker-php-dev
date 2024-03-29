FROM php:7.4-fpm-alpine3.15 as temp

COPY extensions /docker-build-extensions

# 编译xhprof和tideways_xhprof
RUN echo -e "https://mirrors.aliyun.com/alpine/v3.15/main\n" > /etc/apk/repositories && \
    echo -e "https://mirrors.aliyun.com/alpine/v3.15/community\n" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS && \
    cd /docker-build-extensions/xhprof && phpize && ./configure && make && make install && \
    cd /docker-build-extensions/tideways_xhprof && phpize && ./configure && make && make install && \
    mkdir /php-ext && \
    cp $(php-config --extension-dir)/xhprof.so /php-ext && \
    cp $(php-config --extension-dir)/tideways_xhprof.so /php-ext

FROM php:7.4-fpm-alpine3.15

COPY --from=temp /php-ext/* /php-ext/

# amqp 扩展依赖: rabbitmq-c-dev
# bz2 扩展依赖: bzip2-dev
# event 扩展依赖: libevent-dev
# gd 扩展依赖: freetype-dev, libpng-dev, libjpeg-turbo-dev
# gettext 扩展依赖: gettext-dev
# gmp 扩展依赖: gmp-dev
# iconv 以来扩展: gnu-libiconv-dev
# imagick 扩展依赖: imagemagick-dev
# imap 扩展依赖: imap-dev
# intl 扩展依赖: icu-dev
# ldap 扩展依赖: openldap-dev
# memcached 扩展依赖: libmemcached-dev
# pdo_pgsql 扩展依赖: postgresql-dev
# rdkafka 扩展依赖: librdkafka-dev
# soap 扩展依赖: libxml2-dev
# zip 扩展依赖: libzip-dev
RUN echo -e "https://mirrors.aliyun.com/alpine/v3.15/main\n" > /etc/apk/repositories && \
    echo -e "https://mirrors.aliyun.com/alpine/v3.15/community\n" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add --no-cache \
        ca-certificates \
        gdb \
        strace \
        iproute2 \
        bzip2-dev \
        freetype-dev libpng-dev libjpeg-turbo-dev \
        gettext-dev \
        gmp-dev \
        gnu-libiconv-dev \
        icu-dev \
        imagemagick-dev \
        imap-dev \
        libevent-dev \
        libmemcached-dev \
        libxml2-dev \
        librdkafka-dev \
        openldap-dev \
        postgresql-dev \
        rabbitmq-c-dev \
        libzip-dev \
        linux-headers && \
    update-ca-certificates

RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install \
        bcmath \
        bz2 \
        exif \
        gd \
        gettext \
        gmp \
        iconv \
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
    printf "\n" | pecl install amqp-1.11.0 && \
    printf "\n" | pecl install apcu-5.1.21 && \
    printf "\n" | pecl install ev-1.1.5 && \
    printf "\n\n\n\n\n\n\n\n" | pecl install event-3.0.6 && \
    pecl install grpc-1.44.0 && \
    printf "\n" | pecl install imagick-3.7.0 && \
    pecl install inotify-3.0.0 && \
    printf "\n\n\n\n\n\n\n\n\n" | pecl install memcached-3.1.5 && \
    pecl install mongodb-1.12.1 && \
    pecl install protobuf-3.19.4 && \
    printf "\n\n\n" | pecl install redis-5.3.7 && \
    pecl install rdkafka-6.0.1 && \
    printf "yes\nyes\nyes\nyes\n" | pecl install swoole-4.8.5 && \
    pecl install sync-1.1.2 && \
    pecl install xdebug-3.0.4 && \
    mv /php-ext/xhprof.so $(php-config --extension-dir) && \
    mv /php-ext/tideways_xhprof.so $(php-config --extension-dir) && \
    docker-php-ext-enable event --ini-name php-ext-event.ini && \
    docker-php-ext-enable \
        amqp \
        apcu \
        ev \
        grpc \
        memcached \
        mongodb \
        imagick \
        inotify \
        protobuf \
        redis \
        rdkafka \
        swoole \
        sync \
        tideways_xhprof \
        xdebug \
        xhprof && \
    apk del --no-network $apkDel && \
    pear config-set http_proxy ""

COPY 0.php.ini /usr/local/etc/php/conf.d/0.php.ini
COPY docker_start.sh /usr/bin/docker_start.sh
RUN chmod a+x /usr/bin/docker_start.sh

ENV PHP_MAX_EXECUTE_TIME=30 \
    PHP_MEMORY_LIMIT=128M \
    PHP_POST_MAX_SIZE=8M \
    PHP_UPLOAD_MAX_FILESIZE=8M \
    PHP_MAX_FILE_UPLOADS=20 \
    PHP_SESSION_NAME=PHPSESSIONID \
    PHP_SESSION_SAVE_HANDLER=files \
    PHP_SESSION_SAVE_PATH="" \
    PHP_XDEBUG_REMOTE_ENABLE=0 \
    PHP_XDEBUG_REMOTE_HOST=localhost \
    PHP_XDEBUG_REMOTE_PORT=9000 \
    PHP_XDEBUG_IDEKEY=PHPSTORM \
    XHPROF_OUTPUT_DIR="" \
    LD_PRELOAD=/usr/lib/preloadable_libiconv.so

WORKDIR /var/www

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["docker_start.sh"]

EXPOSE 9000
