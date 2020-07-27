FROM vognev/base:stretch

USER root
RUN apt-get update && apt-get install -y nginx-light\
 && rm -rf /var/lib/apt/lists/*
ADD nginx.conf /etc/nginx/nginx.conf

ADD docker-entrypoint.sh /docker-entrypoint.sh
EXPOSE 80
ENTRYPOINT ["/docker-entrypoint.sh"]

