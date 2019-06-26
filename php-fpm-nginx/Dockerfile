FROM vognev/debian-stretch

RUN apt-get update && apt-get install -y curl apt-transport-https && rm -rf /var/lib/apt/lists/*

RUN curl -o /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
echo "deb https://packages.sury.org/php/ stretch main" > /etc/apt/sources.list.d/php.list && \
apt-get update && apt-get install -y php7.0-cli php7.0-curl php7.0-fpm php7.0-zip \
php7.0-dom php7.0-mbstring php7.0-intl php7.0-mysql && \
apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y supervisor nginx-light && \
apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

RUN mkdir /app && chown debian:debian /app
WORKDIR /app

ADD overlay/ /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]