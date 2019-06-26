#!/bin/bash

set -e

confd -onetime -backend env -confdir /etc/confd

exec $@
