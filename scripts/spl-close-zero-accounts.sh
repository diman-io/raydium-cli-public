#!/usr/bin/env bash

here="$(dirname "$0")"

source ${here}/libs/std.sh
source ${here}/libs/token-list.sh

VAULT=$1

for keypair in ${KEYS}/*.json
do
  address=$(solana address -k $keypair)
  accounts=$(spl-token -u $URL accounts --owner $keypair --output json-compact 2>/dev/null)
  if [[ $accounts == "None" ]]; then
    continue
  fi
  zero_accounts=$(jq -c ' .accounts[] | select(.tokenAmount.amount=="0" and .mint!="'$RAY'" and .mint!="'$USDC'") | .address' <<< $accounts | sed s/\"//g)
  if [[ $zero_accounts == "" ]]; then
    echo "$address: Nothing to do"
  else
    for account_address in ${zero_accounts[@]}
    do
      echo "$address: Closing $account_address ..."
      spl-token -u $URL close --address $account_address --owner $keypair --fee-payer $VAULT --recipient $VAULT
    done
  fi
done
