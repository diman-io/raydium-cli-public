#!/usr/bin/env bash

here="$(dirname "$0")"

source ${here}/libs/std.sh
source ${here}/libs/token-list.sh
source ${here}/libs/rebalance.sh

TOKEN=${!1}
TOKEN_NAME=$1
if [[ $TOKEN == "" ]]; then
  TOKEN=$1 # token address
fi
AIM=$2
VAULT=$3

for keypair in ${KEYS}/*.json
do
  rebalance
done
