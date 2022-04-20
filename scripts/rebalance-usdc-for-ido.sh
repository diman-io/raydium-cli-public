#!/bin/bash

raydium_cli=../raydium

POOL=$1
VAULT=$2

USDC=EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v

if [[ -z ${URL} ]]; then
  URL=mainnet-beta
fi

usdc_per_ticket=$($raydium_cli -u $URL ido $POOL pool-info --output json-compact | jq '.allocationPerWinningTicket')

for keypair in keys/*.json
do
  address=$(solana address -k $keypair)
  balance=$(spl-token -u $URL balance $USDC --owner $keypair 2>/dev/null)
  if [[ $balance == "" ]]; then
    balance=0
  fi
  eligible_tickets=$($raydium_cli -u $URL ido $POOL user-info $address --output json-compact | jq '.eligibleTickets')
  aim=$(echo "$eligible_tickets * $usdc_per_ticket" | bc)
  if (( $(echo "$balance < $aim" | bc -l) )); then
    amount=$(echo "$aim - $balance" | bc -l)
    from=$VAULT
    to=$keypair
    job=Funding
  elif (( $(echo "$balance > $aim" | bc -l) )); then
    amount=$(echo "$balance - $aim" | bc -l)
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
    echo $address: $balance USDC. $job
    continue
  fi
  echo $address: $balance USDC. $job $amount USDC...
  spl-token -u $URL transfer $USDC $amount $to --owner $from --fee-payer $VAULT --allow-unfunded-recipient --fund-recipient
done
