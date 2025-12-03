#!/bin/bash
set -e

DUR=${1:-600}
CPU=${2:-0}

OUT=~/rt-bench/results/timerlat-$(uname -r)-cpu${CPU}-$(date +"%Y%m%d-%H%M%S").txt

echo "Running rtla timerlat for $DUR seconds on CPU ${CPU}"
sudo rtla timerlat \
    --duration $DUR \
    --cpu $CPU \
    --period 1000 \
    --quiet \
    > "$OUT"

echo "Wrote $OUT"
