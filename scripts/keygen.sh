#!/usr/bin/env bash

solana_version=$(solana --version | cut -f 2 -d' ')
minor_version=$(echo $solana_version | cut -f 2 -d'.')
if [[ $minor_version != "9" ]]; then
  echo "Please use Solana cli with version 1.9.*. Your version is $solana_version"
  exit 1
fi

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
