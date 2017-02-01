FROM debian:jessie

MAINTAINER François Fleur <francois@aparticula.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    curl \
    supervisor \
    # omeka dependencies
    imagemagick pdftk poppler-utils

# Add DotDeb repo to get PHP7 packages
RUN echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list && \
    wget -O- https://www.dotdeb.org/dotdeb.gpg | apt-key add -
# Add nginx repo to get latest version
RUN echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" > /etc/apt/sources.list.d/nginx.list && \
    wget -O- http://nginx.org/packages/keys/nginx_signing.key | apt-key add -

RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx \
    php7.0-bcmath \
    php7.0-cli \
    php7.0-common \
    php7.0-fpm \
    php7.0-gd \
    php7.0-intl \
    php7.0-json \
    php7.0-mbstring \
    php7.0-mysql \
    php7.0-opcache \
    php7.0-readline \
    php7.0-soap \
    php7.0-xml \
    && rm -rf /var/lib/apt/lists/*

# Configure PHP-FPM & Nginx
RUN sed -e 's/;daemonize = yes/daemonize = no/' -i /etc/php/7.0/fpm/php-fpm.conf \
    && echo "opcache.enable=1" >> /etc/php/7.0/mods-available/opcache.ini \
    && echo "opcache.enable_cli=1" >> /etc/php/7.0/mods-available/opcache.ini

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/supervisor.conf /etc/supervisor/conf.d/supervisor.conf
COPY conf/www.conf /etc/php/7.0/fpm/pool.d/www.conf

RUN usermod -u 1000 www-data

RUN rm -rf /app/*
VOLUME /app
WORKDIR /app

EXPOSE 80

CMD ["/usr/bin/supervisord"]