#!/bin/bash

echo -n "Mnemonic: "
read -s mnemonic
echo
echo -n "Prefix: "
read prefix
echo -n "First index (usually 0): "
read first
echo -n "Last index (usually how_many-1): "
read last
echo ""

for i in $(seq $first $last)
do
  fn=$(printf %s_%03d "$prefix" "$i")
  printf "$mnemonic\n\ny" | solana-keygen recover "prompt://?key=$i/0" -o $fn.json > /dev/null 2>&1
  address=$(solana address -k $fn.json)
  mv $fn.json keys/$fn-$address.json
  echo $address
done
