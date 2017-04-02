FROM vognev/base

ENV ELLIPTICS_VERSION 2.26.10.3

RUN apt-get update && apt-get install -y curl &&\
 apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

RUN curl http://repo.reverbrain.com/REVERBRAIN.GPG | apt-key add - &&\
 echo 'deb http://repo.reverbrain.com/jessie/ current/amd64/' > /etc/apt/sources.list.d/elliptics.list &&\
 apt-get update && apt-get install -y elliptics-client=$ELLIPTICS_VERSION elliptics=$ELLIPTICS_VERSION &&\
 apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

ADD ioserv.json /etc/ioserv.json
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

