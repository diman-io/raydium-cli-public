raydium_cli=${here}/../raydium

if [[ -z ${URL} ]]; then
  URL=mainnet-beta
fi

if [[ -z ${KEYS} ]]; then
  KEYS=${here}/keys
fi
