#!/bin/bash

raydium_cli=../raydium

POOL=$1

if [[ -z ${URL} ]]; then
  URL=mainnet-beta
fi

for keypair in keys/*.json
do
  $raydium_cli ido $POOL claim -k $keypair -u $URL
done
