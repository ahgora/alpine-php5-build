FROM        alpine:3.4
MAINTAINER  Weslley Camilo

RUN apk update && apk upgrade && \
mkdir -p /run/apache2/ &&\
apk add apache2=2.4.23-r1 apache2-utils=2.4.23-r1 php5-apache2 php5-gettext php5-cgi php5-gd php5-intl php5-mcrypt patch php5-imap php5-json &&\
rm /var/cache/apk/* 


EXPOSE 80 443

ENTRYPOINT ["/usr/sbin/apachectl"]