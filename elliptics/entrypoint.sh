#!/usr/bin/env bash

set -e

mkdir -p /var/lib/elliptics/{history,blobdata}

REMOTE_IP=${REMOTE_IP:-autodiscovery:224.0.0.5}
AUTH_COOKIE=${AUTH_COOKIE:-elliptics}
REMOTE_PORT=${REMOTE_PORT:-1025}
sed \
    -e "s/{REMOTE_IP}/$REMOTE_IP/" \
    -e "s/{REMOTE_PORT}/$REMOTE_PORT/" \
    -e "s/{AUTH_COOKIE}/$AUTH_COOKIE/" \
    -i /etc/ioserv.json

CMD="$@"
if [ -z "$CMD" ]; then
  CMD="$CMD /usr/bin/dnet_ioserv"
  CMD="$CMD -c /etc/ioserv.json"
fi

exec $CMD