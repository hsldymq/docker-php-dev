 # 镜像说明
基础镜像: **php:7.0-fpm-alpine**

### 个别扩展版本说明:
* amqp: 1.9.1
* ev: 1.0.4
* event: 2.3.0
* gd: 2.1.0(开启FreeType,GIF,JPEG,PNG,WBMP,XBM支持)
* memcached: 3.0.3
* mongodb: 1.2.9
* pdo_sqlsrv: 4.1.6.1
* redis: 3.1.2
* swoole: 1.9.13
* imagick 3.4.3
* xdebug: 2.5.4
* xhprof: 来自[longxinH/xhprof](https://github.com/longxinH/xhprof)

### xhprof
> output_dir: /var/tmp/xhprof

### xdebug
> profiler_output_dir: /var/tmp/xdebug/profiler

> trace_output_dir: /var/tmp/xdebug/trace

> idekey: PHPDEBUG


