# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

TXID="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"

RAW_TX=$(bitcoin-cli getrawtransaction "$TXID" true)
PUBKEYS=$(echo "$RAW_TX" | jq -r '.vin[].txinwitness[1]' | sort -u)

PUBKEY_ARRAY=$(echo "$PUBKEYS" | jq -R . | jq -s .)
MULTISIG=$(bitcoin-cli createmultisig 1 "$PUBKEY_ARRAY" "p2sh-segwit")

P2SH_ADDRESS=$(echo "$MULTISIG" | jq -r '.address')
REDEEM_SCRIPT=$(echo "$MULTISIG" | jq -r '.redeemScript')

echo "$P2SH_ADDRESS"
