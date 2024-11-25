# How many new outputs were created by block 123,456?
block_hash=$(bitcoin-cli getblockhash 123456)
vouts=$(bitcoin-cli getblock "$block_hash" 2 | jq '[.tx[].vout[]] | length')
echo $vouts
