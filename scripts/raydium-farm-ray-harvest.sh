#!/usr/bin/env bash

here="$(dirname "$0")"

source ${here}/libs/std.sh

POOL=RAY

for keypair in ${KEYS}/*.json
do
  $raydium_cli farm $POOL harvest -k $keypair -u $URL
done
