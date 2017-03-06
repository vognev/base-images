FROM vognev/base

RUN apt-get update && apt-get install -y beanstalkd && \
  apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

VOLUME /var/lib/beanstalkd
EXPOSE 11300

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

