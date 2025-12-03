#!/bin/bash
set -e

DUR=${1:-600}   # default: 10 minutes
CPU=${2:-0}     # default: run on CPU 0

OUT=~/rt-bench/results/osnoise-$(uname -r)-cpu${CPU}-$(date +"%Y%m%d-%H%M%S").txt

echo "Running rtla osnoise for $DUR seconds on CPU ${CPU}"
sudo rtla osnoise \
    --duration $DUR \
    --cpu $CPU \
    --osnoise \
    --period 1000 \
    --quiet \
    > "$OUT"

echo "Wrote $OUT"
