FROM php:7.1-fpm-alpine

ADD build/ /docker-build/

RUN echo -e "https://mirrors.ustc.edu.cn/alpine/latest-stable/main\nhttps://mirrors.ustc.edu.cn/alpine/latest-stable/community" > /etc/apk/repositories && \
    apk update && \
    apk upgrade
 
RUN apk --no-cache add \
    linux-headers \
    autoconf \
    build-base \
    zlib-dev \
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
    unixodbc-dev

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

# event扩展依赖sockets扩展,修改文件名使得sockets先于event载入.
RUN mv /usr/local/etc/php/conf.d/docker-php-ext-sockets.ini /usr/local/etc/php/conf.d/0-docker-php-ext-sockets.ini
    
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd

RUN echo | pecl install file:///docker-build/php-extensions/amqp-1.9.1.tgz && \
    echo | pecl install file:///docker-build/php-extensions/ev-1.0.4.tgz && \
    echo -e "\n\n\n\n\n\n\n" | pecl install file:///docker-build/php-extensions/event-2.3.0.tgz && \
    echo "/usr" | pecl install file:///docker-build/php-extensions/memcached-3.0.3.tgz && \
    pecl install file:///docker-build/php-extensions/mongodb-1.2.9.tgz && \
    pecl install file:///docker-build/php-extensions/redis-3.1.2.tgz && \
    pecl install file:///docker-build/php-extensions/pdo_sqlsrv-4.1.6.1.tgz && \
    pecl install file:///docker-build/php-extensions/swoole-1.9.13.tgz && \
    pecl install file:///docker-build/php-extensions/xdebug-2.5.4.tgz && \
    docker-php-ext-enable amqp ev event memcached mongodb redis pdo_sqlsrv swoole xdebug

RUN rm -rf /docker-build

WORKDIR /var/www/html

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["php-fpm"]

EXPOSE 9000

