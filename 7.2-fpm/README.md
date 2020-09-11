 # 镜像说明
基础镜像: **php:7.2-fpm-alpine3.10**

### 非PECL扩展信息:
tideways_xhprof: 来自[tideways/php-xhprof-extension](https://github.com/tideways/php-xhprof-extension)

xhprof: 来自[longxinH/xhprof](https://github.com/longxinH/xhprof)

### 个别扩展版本说明:
* amqp: 1.9.4
* apcu: 5.1.18
* bcmath: 7.2.21
* bz2: 7.2.21
* Core: 7.2.21
* ctype: 7.2.21
* curl: 7.2.21
* date: 7.2.21
* dom: 20031129
* ev: 1.0.6
* event: 2.5.3
* exif: 7.2.21
* fileinfo: 1.0.5
* filter: 7.2.21
* ftp: 7.2.21
* gd: 7.2.21
* gettext: 7.2.21
* gmp: 7.2.21
* grpc: 1.26.0
* hash: 1.0
* iconv: 7.2.21
* imagick: 3.4.4
* imap: 7.2.21
* inotify: 2.0.0
* intl: 1.1.0
* json: 1.6.0
* ldap: 7.2.21
* libxml: 7.2.21
* mbstring: 7.2.21
* memcached: 3.1.3
* mongodb: 1.5.5
* mysqli: 7.2.21
* mysqlnd: mysqlnd 5.0.12-dev - 20150407 - $Id: 3591daad22de08524295e1bd073aceeff11e6579 $
* openssl: 7.2.21
* pcntl: 7.2.21
* pcre: 7.2.21
* PDO: 7.2.21
* pdo_mysql: 7.2.21
* pdo_pgsql: 7.2.21
* pdo_sqlite: 7.2.21
* pgsql: 7.2.21
* Phar: 2.0.2
* posix: 7.2.21
* protobuf: 3.11.2
* rdkafka: 4.0.0
* readline: 7.2.21
* redis: 5.0.2
* Reflection: 7.2.21
* session: 7.2.21
* SimpleXML: 7.2.21
* soap: 7.2.21
* sockets: 7.2.21
* sodium: 7.2.21
* SPL: 7.2.21
* sqlite3: 7.2.21
* standard: 7.2.21
* swoole: 4.5.3
* sync: 1.1.1
* sysvmsg: 7.2.21
* sysvsem: 7.2.21
* sysvshm: 7.2.21
* tideways_xhprof: 5.0.0
* tokenizer: 7.2.21
* xdebug: 2.7.2
* xhprof: 2.1.0
* xml: 7.2.21
* xmlreader: 7.2.21
* xmlwriter: 7.2.21
* zip: 1.15.4
* zlib: 7.2.21

### build
允许通过代理加速pecl扩展的下载

```shell
docker build -t tag --network host --build-arg pecl_http_proxy=proxy_adrr .
```