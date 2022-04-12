#!/bin/bash

TOKEN=$1
AIM=$2
VAULT=$3

if [[ -z ${URL} ]]; then
  URL=mainnet-beta
fi

for keypair in keys/*.json
do
  address=$(solana address -k $keypair)
  balance=$(spl-token -u $URL balance $TOKEN --owner $keypair 2>/dev/null)
  if [[ $balance == "" ]]; then
    balance=0
  fi
  if (( $(echo "$balance < $AIM" | bc -l) )); then
    amount=$(echo "$AIM - $balance" | bc -l)
    from=$VAULT
    to=$keypair
    job=Funding
  elif (( $(echo "$balance > $AIM" | bc -l) )); then
    amount=$(echo "$balance - $AIM" | bc -l)
    from=$keypair
    to=$VAULT
    job=Refunding 
  else
    amount=0
    job="Nothing to do"
  fi
  if [[ "$amount" == .* ]]; then
    amount="0$amount"
  fi
  if [[ "$amount" == 0 ]]; then
    echo $address: $balance Tokens. $job
    continue
  fi
  echo $address: $balance Tokens. $job $amount Tokens...
  spl-token -u $URL transfer $TOKEN $amount $to --owner $from --fee-payer $VAULT --allow-unfunded-recipient --fund-recipient
done
