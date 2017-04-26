FROM        alpine:3.4
MAINTAINER  Weslley Camilo

RUN apk update && apk upgrade && \
mkdir -p /run/apache2/ &&\
apk add apache2=2.4.25-r0 apache2-utils=2.4.25-r0 php5-zlib php5-zip php5-apache2 php5-gettext php5-cgi php5-gd php5-intl php5-iconv php5-mcrypt patch php5-imap php5-json php5-curl php5-xml php5-soap php5-dom php5-calendar wget php5-openssl &&\
apk add fabric --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted &&\
apk add --update --no-cache libgcc libstdc++ libx11 glib libxrender libxext libintl ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family zip openssl &&\
apk update && apk add wget ca-certificates &&\
wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-php5-mongo/master/sgerrand.rsa.pub &&\
wget https://github.com/sgerrand/alpine-pkg-php5-mongo/releases/download/1.16.4-r0/php5-mongo-1.6.14-r0.apk --no-check-certificate &&\
apk add php5-mongo-1.6.14-r0.apk --allow-untrusted &&\
rm php5-mongo-1.6.14-r0.apk &&\
echo "LoadModule rewrite_module modules/mod_rewrite.so" >> /etc/apache2/httpd.conf &&\
sed -i 's/^short_open_tag = Off$/short_open_tag = On/' /etc/php5/php.ini &&\
sed -i 's/^memory_limit = 128M$/memory_limit = 1536M/' /etc/php5/php.ini &&\
sed -i 's/^upload_max_filesize = 2M$/upload_max_filesize = 100M/' /etc/php5/php.ini &&\
sed -i 's/^post_max_size = 8M$/post_max_size = 100M/' /etc/php5/php.ini &&\
wget https://github.com/ahgora/wkhtmltopdf/raw/master/wkhtmltopdf &&\
chmod +x wkhtmltopdf &&\
mv wkhtmltopdf /usr/bin/ &&\
apk del wget &&\
rm /var/cache/apk/* &&\
cd /tmp && rm -Rf *

RUN apk update && apk upgrade &&\
    apk add git libuv php5-pear cmake bash libuv-dev openssl-dev php5-dev \
    autoconf gmp-dev make gcc g++ boost
RUN git clone https://github.com/datastax/php-driver.git && cd php-driver && git submodule update --init
RUN cd /php-driver/ext && bash install.sh
RUN echo 'extension=cassandra.so' >> /etc/php5/php.ini
RUN apk del git php5-pear cmake bash libuv-dev openssl-dev php5-dev \
    autoconf gmp-dev make gcc g++ boost
RUN rm /var/cache/apk/* && rm -Rf /php-driver\
cd /tmp && rm -Rf *

EXPOSE 80 443

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
