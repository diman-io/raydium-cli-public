All this scripts support `$URL` variable for set another rpc end-point (default is api.mainnet-beta.solana.com).

Examples:
```
URL=https://localhost:8899/ ./rebalance-sol.sh 0.1
URL=https://free.rpcpool.com/ ./rebalance-sol.sh 0.1
URL=https://solana-api.projectserum.com/ ./rebalance-sol.sh 0.1

```

# Raydium scripts

For possible values for POOL use `../raydium ido --help`

## stake.sh

```
./stake.sh <POOL>
```

## claim.sh

```
./claim.sh <POOL>
```

Claim is smart. It try to do all possible actions and doesn't do not needed actions. Though if you want the transactions looks like as the official site make it you could use optional flags for this. `../raydium ido claim --help` helps you.

# Keypairs scripts

## keygen.sh

```
./keygen.sh
```
Restore your 100500 wallets from Phantom.

The results will be saved as `keys/[prefix]_[index]-[address].json`

You need to use `solana` v9. This doesn't work with 10th version.

# Balance management scripts

## rebalance-sol.sh

```
./rebalance-sol.sh <AIM> <VAULT>
```

`AIM` - the target value in SOLs in `keys/*.json` keypairs

`VAULT` - path to vault keypair

## rebalance-token.sh

```
./rebalance-token.sh <TOKEN> <AIM> <VAULT>
```

`TOKEN` - token mint address

`AIM` - the target value in Tokens in `keys/*.json` wallets

`VAULT` - path to vault keypair

## rebalance-token-usdc.sh

Just a helper for USDC rebalancing.

```
./rebalance-token-usdc.sh <AIM> <VAULT>
```

`AIM` - the target value in Tokens in `keys/*.json` wallets

`VAULT` - path to vault keypair

## balance-*.sh

They are like rebalance-* but only to show your accounts balances. `AIM` and `VAULT` aren't needed.

