FROM nginx:1.20.0-alpine

COPY nginx-upstream-fair /tmp/

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories ; \
    apk add --no-cache tzdata; \
    cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
    apk add --no-cache --virtual .build-deps \
                gcc \
                libc-dev \
                make \
                openssl-dev \
                pcre-dev \
                zlib-dev \
                linux-headers \
                libxslt-dev \
                gd-dev \
                geoip-dev \
                perl-dev \
                libedit-dev \
                mercurial \
                bash \
                alpine-sdk \
                findutils; \
    ./configure --prefix=/etc/nginx  --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --pid-path=/var/run/nginx.pid  --add-module=/tmp/nginx-upstream-fair  --with-http_ssl_module ; \
    make; \
    make install -j`nproc`
