#!/bin/bash

MOVING=( 10 1 1 5 2 5 1 1 10 1 1 1 1 5 7 1 1 19 1 1 5 7 1 1 12 1 1 5 2 5 1 1 )

adjust() {
date -d "$1" +%s | xargs -I% sudo date -s "@%"

if [[ "$2" != "0" ]]; then
for i in $(seq 0 $2); do
	date -d "+ 1 minute" +%s | xargs -I% sudo date -s "@%"
	echo "$RANDOM" | tee nonce
	git add nonce
	git commit -am "adjusting nonce"
done
date -d "0:00" +%s | xargs -I% sudo date -s "@%"
fi
}

adjust "8 october 2017" 0
for i in "${MOVING[@]}"; do
	echo $i
	adjust "+ $i days" 100
done
