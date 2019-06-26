FROM debian:stretch-slim

ARG VER=4.1
ARG SUB=4.1.9

RUN apt-get update && apt-get install -y runit gnupg2 wget apt-transport-https && rm -rf /var/lib/apt/lists/*

RUN wget -qO- "https://download.gluster.org/pub/gluster/glusterfs/${VER}/rsa.pub" | apt-key add - \
 && echo "deb https://download.gluster.org/pub/gluster/glusterfs/${VER}/${SUB}/Debian/stretch/amd64/apt stretch main" > /etc/apt/sources.list.d/gluster.list \
 && apt-get update && apt-get install -y glusterfs-server && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

ADD ./overlay /

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/usr/bin/runsvdir", "-P", "/etc/service"]
