FROM scratch
MAINTAINER vitaliy.ognev@gmail.com

ADD rootfs.tar.gz /
ADD overlay/ /

CMD ["/usr/bin/runsvdir", "-P", "/etc/service"]