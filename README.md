# PHP开发用镜像

####基础镜像: php(alpine版)

#### 环境变量
> XDEBUG\_CONFIG

> XDEBUG\_PROFILER\_DIR

> XDEBUG\_TRACE\_DIR

> XHPROFILE\_DIR

#### 获取镜像
docker pull hsldymq/php-dev:latest

#### 容器中配置文件路径
##### php.ini
/usr/local/etc/php/php.ini

#### 使用
##### docker-compose
```docker-compose
version: "3"
services:
    php:
        image: hsldymq/php-dev
        container_name: php
        restart: always
        log_driver: journald 
        environment:
            XDEBUG_CONFIG: "idekey=PHPSTORM remote_enable=on remote_host=192.168.1.2 remote_port=9000"
            XHPROFILE_DIR: "/path/to/xhprof/directory/in/container"
        ports:
            - 9000:9000
        volumes:
            - /path/to/project:/path/to/project/in/container
            - /path/to/xhprof/directory:/path/to/xhprof/directory/in/container
            - /path/to/php.ini:/usr/local/etc/php/php.int  # 如果不需要覆盖可以去掉这一行
            - xhprof:/path/to/xhprof/dir    # 如果不需要xhprof可以去掉这一行
        cap_add:
            - SYS_PTRACE
        privileged: true
        security_opt:
            - seccomp=unconfined

# 如果想配合xhprof一起使用还可以我的另一个xhprof镜像(hsldymq/xhprof-report),并加入以下配置
    xhprof:
        image: hsldymq/xhprof-reporter
        container_name: xhprof
        restart: always
        environment:
            XHPROFILE_DIR: "/path/to/xhprof/dir"
        volumes:
            - xhprof:/path/to/xhprof/dir
        ports:
            - 9527:9527
volumes:
    xhprof:
```



#### 启用的扩展
* amqp
* bcmath
* bz2
* Core
* ctype
* curl
* date
* dom 
* ev
* event
* exif
* fileinfo
* filter
* ftp
* gd
* hash
* iconv
* imagick
* imap
* inotify
* json
* libxml
* mbstring
* mcrypt (7.1及以下包含)
* memcached
* mongodb
* mysqli
* mysqlnd
* openssl
* pcntl
* pcre
* PDO
* pdo_mysql
* pdo_pgsql
* pdo_sqlite
* pgsql
* Phar
* posix
* protobuf
* readline
* redis
* Reflection
* session
* SimpleXML
* sockets
* SPL
* sqlite3
* standard
* swoole
* sync
* sysvmsg
* sysvsem
* sysvshm
* tokenizer
* xdebug
* xhprof
* xml
* xmlreader
* xmlwriter
* zip
* zlib


