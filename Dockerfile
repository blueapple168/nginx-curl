FROM nginx:1.16.0-alpine
MAINTAINER blueapple <blueapple1120@qq.com>

RUN apk add --no-cache tzdata curl && \
    cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    apk del tzdata && \
    sed -i -r \
    -e '/^\s*(#|$)/d' \
    -e 's/listen\s.+/listen 8080;/' \
    -e 's#index  index.html index.htm;#try_files $uri $uri/ /index.html;#' \
    /etc/nginx/conf.d/default.conf

WORKDIR /usr/share/nginx/html
EXPOSE 8080
