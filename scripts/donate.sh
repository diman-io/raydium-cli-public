#!/usr/bin/env bash

here="$(dirname "$0")"

source ${here}/libs/std.sh

for keypair in ${KEYS}/*.json
do
  $raydium_cli donate 0.01 -k $keypair 
done
