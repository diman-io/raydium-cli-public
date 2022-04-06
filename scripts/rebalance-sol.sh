#!/bin/bash

AIM=$1
VAULT=$2

if [[ -z ${URL} ]]; then
  URL=mainnet-beta
fi

for keypair in keys/*.json
do
  address=$(solana address -k $keypair)
  balance=$(solana -u $URL balance -k $keypair | grep -o '[0-9.]*')
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
    echo $address: $balance SOL. $job
    continue
  fi
  echo $address: $balance SOL. $job $amount SOL...
  solana -u $URL transfer -k $from $to $amount --fee-payer $VAULT --allow-unfunded-recipient
done
