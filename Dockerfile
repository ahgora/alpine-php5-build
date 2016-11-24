FROM        alpine:3.4
MAINTAINER  Weslley Camilo

RUN apk update && \
mkdir -p /run/apache2/ &&\
apk add apache2=2.4.23-r3 apache2-utils=2.4.23-r3 php5-apache2 php5-gettext php5-cgi php5-gd php5-intl php5-mcrypt patch php5-imap php5-json wget ca-certificates &&\
apk add fabric  --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted &&\
wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-php5-mongo/master/sgerrand.rsa.pub &&\
wget https://github.com/sgerrand/alpine-pkg-php5-mongo/releases/download/1.16.4-r0/php5-mongo-1.6.14-r0.apk &&\
apk add php5-mongo-1.6.14-r0.apk &&\
rm php5-mongo-1.6.14-r0.apk &&\
apk add php5-zlib php5-zip &&\
rm /var/cache/apk/* 


EXPOSE 80 443


CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
