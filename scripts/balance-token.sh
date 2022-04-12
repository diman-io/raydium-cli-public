#!/bin/bash

TOKEN=$1

if [[ -z ${URL} ]]; then
  URL=mainnet-beta
fi

fmt="%-45s%s\n"
for keypair in keys/*.json
do
  address=$(solana address -k $keypair)
  balance=$(spl-token -u $URL balance $TOKEN --owner $keypair 2>/dev/null)
  if [[ $balance == "" ]]; then
    balance=0
  fi
  printf "$fmt" $address $balance
done
