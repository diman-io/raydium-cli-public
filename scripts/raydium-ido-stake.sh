#!/usr/bin/env bash

here="$(dirname "$0")"

source ${here}/libs/std.sh

POOL=$1

for keypair in ${KEYS}/*.json
do
  $raydium_cli ido $POOL stake MAX -k $keypair -u $URL
done
