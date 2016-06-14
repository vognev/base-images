FROM vognev/base

RUN echo "deb [arch=amd64] http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y openjdk-8-jre-headless && \
  apt-get autoremove -y && rm -rf /var/lib/apt/lists/*  

RUN mkdir /app && chown debian:debian /app
WORKDIR /app
USER debian
