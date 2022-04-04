#!/bin/bash

raydium_cli=../raydium

POOL=$1

for keypair in keys/*.json
do
  $raydium_cli ido $POOL stake MAX -k $keypair 
done
