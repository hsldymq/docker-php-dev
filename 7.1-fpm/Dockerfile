FROM php:7.1-fpm-alpine3.8

ADD build/ /docker-build/

# 解决iconv字符集转换不支持//IGNORE标记的问题
# 下面引入了gnu-libiconv库,which在testing仓库中
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so

# 预先准备环境目录,删除无用文件/目录
RUN rm -rf /var/www/html && \
    mkdir -p /etc/syslog-ng/include && \
    cp -r /docker-build/config/syslog-ng/* /etc/syslog-ng/ && \
    cp /docker-build/scripts/docker_start.sh /usr/bin/docker_start.sh && \
    chmod a+x /usr/bin/docker_start.sh

RUN echo -e "https://mirrors.ustc.edu.cn/alpine/v3.8/main\n" > /etc/apk/repositories && \
    echo -e "https://mirrors.ustc.edu.cn/alpine/v3.8/community\n" >> /etc/apk/repositories && \
    echo -e "https://mirrors.ustc.edu.cn/alpine/edge/testing\n" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade

RUN apk --no-cache add \
        ca-certificates \
        gnu-libiconv \
        autoconf \
        build-base \
        zlib-dev \
        libtool \
        linux-headers \
        gdb \
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
        imagemagick-dev \
        imagemagick \
        pcre-dev \
        unixodbc-dev \
        openssl \
        openssh-client \
        graphviz \
        ttf-dejavu \
        ttf-droid \
        ttf-freefont \
        ttf-liberation \
        ttf-ubuntu-font-family \
        syslog-ng \
        strace \
        procps && \
    update-ca-certificates

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
        zip \
        sysvmsg \
        sysvsem \
        sysvshm

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
    pecl install file:///docker-build/php-extensions/mongodb-1.4.2.tgz && \
    pecl install file:///docker-build/php-extensions/redis-3.1.2.tgz && \
    pecl install file:///docker-build/php-extensions/pdo_sqlsrv-4.1.6.1.tgz && \
    pecl install file:///docker-build/php-extensions/swoole-1.9.13.tgz && \
    echo -e "\n" | pecl install file:///docker-build/php-extensions/imagick-3.4.3.tgz && \
    pecl install file:///docker-build/php-extensions/inotify-2.0.0.tgz && \
    pecl install file:///docker-build/php-extensions/grpc-1.11.0.tgz && \
    pecl install file:///docker-build/php-extensions/protobuf-3.6.1.tgz && \
    pecl install file:///docker-build/php-extensions/sync-1.1.1.tgz && \
    pecl install file:///docker-build/php-extensions/xdebug-2.5.4.tgz && \
    docker-php-ext-enable amqp ev event memcached mongodb redis pdo_sqlsrv swoole imagick inotify grpc protobuf sync xdebug && \
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
