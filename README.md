# PHP开发用镜像

####基础镜像: php(alpine)

#### 获取镜像
> docker pull hsldymq/php-dev:7.0-fpm

> docker pull hsldymq/php-dev:7.1-fpm

> docker pull hsldymq/php-dev:7.2-fpm

> docker pull hsldymq/php-dev:7.4-fpm

#### 预定义环境变量
* PHP\_MAX\_EXECUTE\_TIME - php.ini配置: max_execution_time (默认: 30, 单位: 秒)
* PHP\_MEMORY\_LIMIT - php.ini配置: memory_limit (默认: 128M)
* PHP\_POST\_MAX\_SIZE - php.ini配置: post_max_size (默认: 8M)
* PHP\_UPLOAD\_MAX\_FILESIZE - php.ini配置: upload_max_filesize (默认: 8M)
* PHP\_MAX\_FILE\_UPLOADS - php.ini配置: max_file_uploads (默认: 20)
* PHP\_SESSION\_NAME - php.ini配置: session.name (默认: PHPSESSIONID)
* PHP\_SESSION\_SAVE\_HANDLER - php.ini配置: session.save_handler (默认: files)
* PHP\_SESSION\_SAVE\_PATH - php.ini配置: session.save_path (默认: "")
* PHP\_XDEBUG\_REMOTE_ENABLE - php.ini配置: xdebug.remote_enable (默认: 0)
* PHP\_XDEBUG\_REMOTE_HOST - php.ini配置: xdebug.remote_host (默认: localhost)
* PHP\_XDEBUG\_REMOTE_PORT - php.ini配置: xdebug.remote_port (默认: 9000)
* PHP\_XDEBUG\_IDEKEY - php.ini配置: xdebug.idekey (默认: PHPSTORM)
* XHPROF_OUT_DIR - xhprof数据保存路径, 同时也是php.ini配置: xhprof.output_dir的值 (默认: "")

#### 使用
##### docker-compose
```docker-compose
version: "3"
services:
    php:
        image: hsldymq/php-dev
        container_name: php
        restart: always
        logging:
            driver: journald
        environment:
            PHP_XDEBUG_REMOTE_ENABLE: 1
            PHP_XDEBUG_REMOTE_HOST: 192.168.1.2
            PHP_XDEBUG_REMOTE_PORT: 9000
            PHP_XDEBUG_IDEKEY: PHPSTORM
            XHPROF_OUTPUT_DIR: /path/to/xhprof/dir/in/container
        volumes:
            - /path/to/project:/path/to/project/in/container
            - xhprof:/path/to/xhprof/dir/in/container           # 如果不需要xhprof可以去掉这一行
        cap_add:
            - SYS_PTRACE
        privileged: true
        security_opt:
            - seccomp=unconfined

    # 如果想配合xhprof一起使用还可以我的另一个xhprof镜像(hsldymq/xhprof-reporter),并加入以下配置
    xhprof:
        image: hsldymq/xhprof-reporter
        container_name: xhprof
        restart: always
        logging:
            driver: journald
        environment:
            XHPROF_OUTPUT_DIR: /path/to/xhprof/dir/in/container
        volumes:
            - xhprof:/path/to/xhprof/dir/in/container
        ports:
            - 9527:9527
volumes:
    xhprof:
```

#### 启用的扩展: 查看每一个目录下的README.md