# raydium-cli

Tool for interacting with raydium.io via CLI

## How to use

1. Download the [latest release](https://github.com/diman-io/raydium-cli-public/releases/latest)
2. Unpack it and put in this folder
3. Put your keypairs in `scripts/keys`
4. Enjoy the scripts in `scripts`

## Friendly scripts

All scripts support
 - `URL` variable for use another rpc end-point (default is api.mainnet-beta.solana.com)
 - `KEYS` variable for use another folder as `keys` folder

Examples:
```
URL=https://localhost:8899/ KEYS=/mnt/solana/raydium ./balance.sh SOL
URL=https://free.rpcpool.com/ scripts/rebalance.sh SOL 0.1
```

### Raydium scripts

Possible values for `<POOL>` are available by `../raydium ido --help` :
```
SNY, SLRS, LIKE, POLIS, ATLAS, GRAPE, GENE, DFL, TTT, RUN, REAL, FCON, YAW, ZBC, prANA, HAWK
```

`<VAULT>` is your transit keypair

```
./raydium-ido-check-win.sh <POOL> - show winning accounts

./raydium-ido-claim.sh <POOL> - smart claim USDC or/and TOKEN from your accounts

./raydium-ido-stake.sh <POOL> - stake USDC for max eligible tickets

./raydium-rebalance-usdc-for-ido.sh <POOL> <VAULT> - rebalance USDC exactly for eligible tickets

./raydium-farm-ray-harvest.sh - harvest RAY
```

### General scripts

`<TOKEN>` is any `<POOL>` value or `SOL`, `RAY` or `USDC` or token address (for `./balance.sh` `SOL` is default)

`<AIM>` is a number - the target value of the tokens

```
./balance.sh <TOKEN>

./rebalance.sh <TOKEN> <AIM> <VAULT>

./spl-close-zero-accounts.sh <VAULT> - close all zero accounts except USDC and RAY
```

### Other scripts

#### keygen.sh

```
./keygen.sh
```
Restore your 100500+ wallets from Phantom.

The results will be saved as `keys/[prefix]_[index]-[address].json`

You need to use `solana` v9. This doesn't work with 10th version.
