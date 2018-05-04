FROM vognev/base

ADD https://getcomposer.org/composer.phar /usr/local/bin/composer

ARG PHP=7.0
ENV PHP ${PHP:-7.0}

RUN apt-get update && apt-get install -y wget apt-transport-https && \
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
echo "deb https://packages.sury.org/php/ jessie main" > /etc/apt/sources.list.d/php.list && \
apt-get update && apt-get install -y php${PHP}-cli php${PHP}-mysql php${PHP}-xdebug php${PHP}-curl && \
apt-get remove --purge -y wget && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

RUN echo "xdebug.remote_enable = 1"       >> /etc/php/${PHP}/mods-available/xdebug.ini
RUN echo "xdebug.remote_connect_back = 1" >> /etc/php/${PHP}/mods-available/xdebug.ini
RUN echo "xdebug.remote_port = 9000"      >> /etc/php/${PHP}/mods-available/xdebug.ini
RUN echo "xdebug.max_nesting_level = 512" >> /etc/php/${PHP}/mods-available/xdebug.ini

RUN apt-get update && apt-get install -y wget apt-transport-https && \
wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
echo 'deb https://deb.nodesource.com/node_8.x jessie main' > /etc/apt/sources.list.d/nodesource.list && \
apt-get update && apt-get install -y nodejs && \
npm install -g gulp-cli yarn && \
apt-get remove --purge -y wget && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

RUN mkdir /app && chown debian:debian /app

WORKDIR /app
USER debian
