FROM vognev/debian-stretch

RUN apt-get update && apt-get install -y apache2 && rm -rf /var/lib/apt/lists/*
RUN a2enmod proxy_connect proxy_http cache_disk

ADD overlay /
