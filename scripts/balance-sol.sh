#!/bin/bash

if [[ -z ${URL} ]]; then
  URL=mainnet-beta
fi

fmt="%-45s%s\n"
for keypair in keys/*.json
do
  address=$(solana address -k $keypair)
  balance=$(solana -u $URL balance -k $keypair | grep -o '[0-9.]*')
  printf "$fmt" $address $balance
done
