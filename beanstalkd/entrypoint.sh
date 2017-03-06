#!/usr/bin/env bash

set -e

ADDR=${BEANSTALKD_ADDR:-0.0.0.0}
PORT=${BEANSTALKD_PORT:-11300}
USER=${BEANSTALKD_USER:-debian}

CMD="$@"
if [ -z "$CMD" ]; then
  CMD="$CMD /usr/bin/beanstalkd"
  CMD="$CMD -l $ADDR"
  CMD="$CMD -p $PORT"
  CMD="$CMD -u $USER"
fi

exec $CMD