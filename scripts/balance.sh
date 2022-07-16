#!/usr/bin/env bash

here="$(dirname "$0")"

source ${here}/libs/std.sh
source ${here}/libs/token-list.sh

TOKEN=${!1}
TOKEN_NAME=$1
if [[ $TOKEN_NAME == "" ]]; then
  TOKEN="SOL"
elif [[ $TOKEN == "" ]]; then
  TOKEN=$1 # token address
fi

fmt="%-45s%s %s %s\n"
for keypair in ${KEYS}/*.json
do
  address=$(solana address -k $keypair)
  if [[ $TOKEN == "SOL" ]]; then
    balance=$(solana -u $URL balance -k $keypair | grep -o '[0-9.]*')
  else
    balance=$(spl-token -u $URL balance $TOKEN --owner $keypair 2>/dev/null)
  fi
  if [[ $balance == "" ]]; then
    balance=0
  fi
  printf "$fmt" $address $balance
done
