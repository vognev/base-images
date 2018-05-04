#!/bin/bash

set -e

CMD="$@"
if [ -z "$CMD" ]; then
  CMD="$CMD nginx"
fi

exec $CMD
