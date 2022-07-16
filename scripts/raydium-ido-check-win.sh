#!/usr/bin/env bash

here="$(dirname "$0")"

source ${here}/libs/std.sh

POOL=$1

fmt="%-45s%s\n"
for keypair in ${KEYS}/*.json
do
  address=$(solana address -k $keypair)
  winning_tickets=$($raydium_cli ido $POOL user-info $address -u $URL --output json-compact | jq -c '.winningTickets')
  printf "$fmt" $address $winning_tickets
done
