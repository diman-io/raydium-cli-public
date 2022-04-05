## stake.sh

```
./stake.sh <POOL>
```
For possible values for POOL use `../raydium ido --help`

---
## claim.sh

```
./claim.sh <POOL>
```
For possible values for POOL use `../raydium ido --help`

Claim is smart. It try to do all possible actions and doesn't do not needed actions. Though if you want the transactions looks like as the official site make it you could use optional flags for this. `../raydium ido claim --help` helps you.

---

## keygen.sh

Restore your 100500 wallets from Phantom:
```
./keygen.sh
```
The results will be saved as `keys/[prefix]_[index]-[address].json`

You need to use `solana` v9. This doesn't work with 10th version.
