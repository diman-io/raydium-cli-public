#!/bin/bash

raydium_cli=../raydium

POOL=$1

if [[ -z ${URL} ]]; then
  URL=mainnet-beta
fi

fmt="%-45s%s\n"
for keypair in keys/*.json
do
  address=$(solana address -k $keypair)
  winning_tickets=$($raydium_cli ido $POOL user-info $address -u $URL --output json-compact | jq -c '.winningTickets')
  printf "$fmt" $address $winning_tickets
done
