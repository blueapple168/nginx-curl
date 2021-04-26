FROM nginx:1.20.0-alpine

WORKDIR /tmp
COPY nginx-upstream-fair /tmp/

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories ; \
    apk add --no-cache tzdata; \
    cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
    apk add --no-cache --virtual .build-deps \
                gcc \
                libc-dev \
                make \
                openssl-dev \
                perl-dev \
                libedit-dev \
                mercurial \
                bash \
                alpine-sdk \
                findutils \
                apr-dev \
                apr-util-dev \
                build-base \
                ca-certificates \
                gd-dev \
                geoip-dev \
                git \
                gnupg \
                icu-dev \
                libjpeg-turbo-dev \
                libpng-dev \
                libxslt-dev \
                linux-headers \
                libressl-dev \
                pcre-dev \
                tar \
                zlib-dev
 
 ARG NGINX_VERSION=1.20.0               
 ARG NGINX_BUILD_CONFIG="\
        --prefix=/etc/nginx \
        --sbin-path=/usr/sbin/nginx \
        --modules-path=/usr/lib/nginx/modules \
        --conf-path=/etc/nginx/nginx.conf \
        --error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log \
        --pid-path=/var/run/nginx.pid \
        --lock-path=/var/run/nginx.lock \
        --http-client-body-temp-path=/var/cache/nginx/client_temp \
        --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
        --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
        --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
        --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
        --user=nginx \
        --group=nginx \
        --with-http_ssl_module \        
        --with-http_realip_module \
        --with-http_addition_module \
        --with-http_sub_module \
        --with-http_dav_module \
        --with-http_flv_module \
        --with-http_mp4_module \
        --with-http_gunzip_module \
        --with-http_gzip_static_module \
        --with-http_random_index_module \
        --with-http_secure_link_module \
        --with-http_stub_status_module \
        --with-http_auth_request_module \
        --with-http_xslt_module=dynamic \
        --with-http_image_filter_module=dynamic \
        --with-http_geoip_module=dynamic \
        --with-threads \
        --with-stream \
        --with-stream_ssl_module \
        --with-stream_ssl_preread_module \
        --with-stream_realip_module \
        --with-stream_geoip_module=dynamic \
        --with-http_slice_module \
        --with-mail \
        --with-mail_ssl_module \
        --with-compat \
        --with-file-aio \
        --with-http_v2_module \
    "
 RUN wget https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
         https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz.asc && \
         (gpg --keyserver ha.pool.sks-keyservers.net --keyserver-options timeout=10 --recv-keys ${NGINX_PGPKEY} || \
         gpg --keyserver hkp://keyserver.ubuntu.com:80 --keyserver-options timeout=10 --recv-keys ${NGINX_PGPKEY} || \
         gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --keyserver-options timeout=10 --recv-keys $NGINX_PGPKEY} ) && \
         gpg --trusted-key ${NGINX_PGPKEY} --verify nginx-${NGINX_VERSION}.tar.gz.asc

WORKDIR /tmp/nginx

RUN tar zxf ../nginx-${NGINX_VERSION}.tar.gz --strip-components=1 -C . && \
    ./configure \
        ${NGINX_BUILD_CONFIG} \
        --add-module=/tmp/nginx-upstream-fair \
        --with-http_ssl_module \
        --with-ld-opt="-Wl,-z,relro,--start-group -lapr-1 -laprutil-1 -licudata -licuuc -lpng -lturbojpeg -ljpeg" ; \
    make install -j`nproc` ; \
    rm -rf /tmp/nginx
    
WORKDIR /usr/share/nginx/html   
