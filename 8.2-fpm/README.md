 # 镜像说明
基础镜像: **php:8.2-fpm-alpine3.20**

### 扩展版本说明:
* amqp: 2.1.2
* apcu: 5.1.24
* bcmath: 8.2.24
* bz2: 8.2.24
* Core: 8.2.24
* ctype: 8.2.24
* curl: 8.2.24
* date: 8.2.24
* dom: 20031129
* ev: 1.2.0
* event: 3.1.4
* exif: 8.2.24
* fileinfo: 8.2.24
* filter: 8.2.24
* gd: 8.2.24
* gettext: 8.2.24
* gmp: 8.2.24
* grpc: 1.65.5
* hash: 8.2.24
* iconv: 8.2.24
* imagick: 3.7.0
* imap: 8.2.24
* inotify: 3.0.0
* intl: 8.2.24
* json: 8.2.24
* ldap: 8.2.24
* libxml: 8.2.24
* mbstring: 8.2.24
* mongodb: 1.19.4
* mysqli: 8.2.24
* mysqlnd: mysqlnd 8.2.24
* openssl: 8.2.24
* pcntl: 8.2.24
* pcre: 8.2.24
* PDO: 8.2.24
* pdo_mysql: 8.2.24
* pdo_pgsql: 8.2.24
* pdo_sqlite: 8.2.24
* pgsql: 8.2.24
* Phar: 8.2.24
* posix: 8.2.24
* protobuf: 4.27.3
* random: 8.2.24
* rdkafka: 6.0.3
* readline: 8.2.24
* redis: 6.0.2
* Reflection: 8.2.24
* session: 8.2.24
* SimpleXML: 8.2.24
* soap: 8.2.24
* sockets: 8.2.24
* sodium: 8.2.24
* SPL: 8.2.24
* sqlite3: 8.2.24
* standard: 8.2.24
* sync: 1.1.3
* sysvmsg: 8.2.24
* sysvsem: 8.2.24
* sysvshm: 8.2.24
* tokenizer: 8.2.24
* xdebug: 3.3.2
* xml: 8.2.24
* xmlreader: 8.2.24
* xmlwriter: 8.2.24
* zip: 1.21.1
* zlib: 8.2.24


### build
允许通过代理加速pecl扩展的下载

```shell
docker build -t tag --network host --build-arg pecl_http_proxy=proxy_addr .
```