 # 镜像说明
基础镜像: **php:7.2-fpm-alpine3.7**

### 个别扩展版本说明:
* amqp: 1.9.1
* ev: 1.0.4
* event: 2.3.0
* gd: 2.1.0(开启FreeType,GIF,JPEG,PNG,WBMP,XBM支持)
* memcached: 3.0.3
* mongodb: 1.4.2
* pdo_sqlsrv: 4.1.6.1
* redis: 3.1.2
* swoole: 1.9.13
* imagick 3.4.3
* xdebug: 2.6.0
* xhprof: 来自[longxinH/xhprof](https://github.com/longxinH/xhprof)
* inotify: 2.0.0
* grpc: 1.11.0
* protobuf: 3.6.1
* sync: 1.1.1

### xhprof
> output_dir: /var/tmp/xhprof

### xdebug
> profiler_output_dir: /var/tmp/xdebug/profiler

> trace_output_dir: /var/tmp/xdebug/trace

> idekey: PHPDEBUG

