#!/usr/bin/env bash

here="$(dirname "$0")"

source ./libs/std.sh
source ./libs/token-list.sh
source ./libs/rebalance.sh

POOL=$1
VAULT=$2

TOKEN_NAME=USDC
TOKEN=${!TOKEN_NAME}

usdc_per_ticket=$($raydium_cli -u $URL ido $POOL pool-info --output json-compact | jq '.allocationPerWinningTicket')

for keypair in ${KEYS}/*.json
do
  eligible_tickets=$($raydium_cli -u $URL ido $POOL user-info $keypair --output json-compact | jq '.eligibleTickets')
  AIM=$(echo "$eligible_tickets * $usdc_per_ticket" | bc)
  rebalance
done
