FROM vognev/base

ADD https://getcomposer.org/composer.phar /usr/local/bin/composer

RUN chmod a+rx /usr/local/bin/composer && \
  apt-get update && apt-get install -y wget && \
  wget -O - https://www.dotdeb.org/dotdeb.gpg | apt-key add - && \
  echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list && \
  apt-get update && apt-get install -y php7.0-cli php7.0-mysql php7.0-xdebug php7.0-curl && \
  apt-get remove --purge -y wget && \
  rm -rf /var/lib/apt/lists/*

RUN echo "xdebug.remote_enable = 1"       >> /etc/php/7.0/mods-available/xdebug.ini
RUN echo "xdebug.remote_connect_back = 1" >> /etc/php/7.0/mods-available/xdebug.ini
RUN echo "xdebug.remote_port = 9000"      >> /etc/php/7.0/mods-available/xdebug.ini
RUN echo "xdebug.max_nesting_level = 512" >> /etc/php/7.0/mods-available/xdebug.ini

RUN apt-get update && apt-get install -y wget apt-transport-https && \
  wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
  echo 'deb https://deb.nodesource.com/node_5.x jessie main' > /etc/apt/sources.list.d/nodesource.list && \
  apt-get update && apt-get install -y nodejs && \
  npm install -g gulp-cli && \
  apt-get remove --purge -y wget && \
  apt-get autoremove -y && rm -rf /var/lib/apt/lists/*  

RUN mkdir /app && chown debian:debian /app

WORKDIR /app
USER debian
