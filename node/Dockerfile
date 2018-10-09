FROM vognev/base

RUN apt-get update && apt-get install -y wget apt-transport-https && \
wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
echo 'deb https://deb.nodesource.com/node_8.x jessie main' > /etc/apt/sources.list.d/nodesource.list && \
apt-get update && apt-get install -y nodejs && \
npm install -g gulp-cli yarn && \
apt-get remove --purge -y wget && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

RUN mkdir /app && chown debian:debian /app

WORKDIR /app
USER debian
