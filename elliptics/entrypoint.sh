#!/usr/bin/env bash

set -e

mkdir -p /var/lib/elliptics/{history,blobdata}

CMD="$@"
if [ -z "$CMD" ]; then
  CMD="$CMD /usr/bin/dnet_ioserv"
  CMD="$CMD -c /etc/ioserv.json"
fi

exec $CMD