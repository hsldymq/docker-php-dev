 # 镜像说明
基础镜像: **php:7.4-fpm-alpine3.15**

### 非PECL扩展信息:
tideways_xhprof: 来自[tideways/php-xhprof-extension](https://github.com/tideways/php-xhprof-extension)

xhprof: 来自[longxinH/xhprof](https://github.com/longxinH/xhprof)

### 扩展版本说明:
* amqp: 1.11.0
* apcu: 5.1.21
* bcmath: 7.4.27
* bz2: 7.4.27
* Core: 7.4.27
* ctype: 7.4.27
* curl: 7.4.27
* date: 7.4.27
* dom: 20031129
* ev: 1.1.5
* event: 3.0.6
* exif: 7.4.27
* fileinfo: 7.4.27
* filter: 7.4.27
* ftp: 7.4.27
* gd: 7.4.27
* gettext: 7.4.27
* gmp: 7.4.27
* grpc: 1.44.0
* hash: 7.4.27
* iconv: 7.4.27
* imagick: 3.7.0
* imap: 7.4.27
* inotify: 3.0.0
* intl: 7.4.27
* json: 7.4.27
* ldap: 7.4.27
* libxml: 7.4.27
* mbstring: 7.4.27
* memcached: 3.1.5
* mongodb: 1.12.1
* mysqli: 7.4.27
* mysqlnd: mysqlnd 7.4.27
* openssl: 7.4.27
* pcntl: 7.4.27
* pcre: 7.4.27
* PDO: 7.4.27
* pdo_mysql: 7.4.27
* pdo_pgsql: 7.4.27
* pdo_sqlite: 7.4.27
* pgsql: 7.4.27
* Phar: 7.4.27
* posix: 7.4.27
* protobuf: 3.19.4
* rdkafka: 6.0.1
* readline: 7.4.27
* redis: 5.3.7
* Reflection: 7.4.27
* session: 7.4.27
* SimpleXML: 7.4.27
* soap: 7.4.27
* sockets: 7.4.27
* sodium: 7.4.27
* SPL: 7.4.27
* sqlite3: 7.4.27
* standard: 7.4.27
* swoole: 4.8.5
* sync: 1.1.2
* sysvmsg: 7.4.27
* sysvsem: 7.4.27
* sysvshm: 7.4.27
* tideways_xhprof: 5.0.0
* tokenizer: 7.4.27
* xdebug: 3.0.4
* xhprof: 2.1.3
* xml: 7.4.27
* xmlreader: 7.4.27
* xmlwriter: 7.4.27
* zip: 1.15.6
* zlib: 7.4.27

### build
允许通过代理加速pecl扩展的下载

```shell
docker build -t tag --network host --build-arg pecl_http_proxy=proxy_adrr .
```