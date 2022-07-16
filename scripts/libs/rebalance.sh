# $keypair
# $URL
# $TOKEN
# $TOKEN_NAME
# $AIM
# $VAULT
rebalance() {
  address=$(solana address -k $keypair)
  if [[ $TOKEN == "SOL" ]]; then
    balance=$(solana -u $URL balance -k $keypair | grep -o '[0-9.]*')
  else
    balance=$(spl-token -u $URL balance $TOKEN --owner $keypair 2>/dev/null)
  fi
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
    echo $address: $balance $TOKEN_NAME. $job
    continue
  fi
  echo $address: $balance $TOKEN_NAME. $job $amount $TOKEN_NAME...
  if [[ $TOKEN == "SOL" ]]; then
    solana -u $URL transfer -k $from $to $amount --fee-payer $VAULT --allow-unfunded-recipient
  else
    spl-token -u $URL transfer $TOKEN $amount $to --owner $from --fee-payer $VAULT --allow-unfunded-recipient --fund-recipient
  fi
}
