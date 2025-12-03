#!/bin/bash
set -e

DUR=${1:-600}
THREADS=${2:-1}
CPU=${3:-0}

OUT=~/rt-bench/results/cyclictest-$(uname -r)-t${THREADS}-cpu${CPU}-$(date +"%Y%m%d-%H%M%S").txt

echo "Running cyclictest for $DUR seconds on CPU $CPU with $THREADS thread(s)"
sudo cyclictest \
    --mlockall \
    --priority=95 \
    --threads=${THREADS} \
    --affinity=${CPU} \
    --duration=${DUR}s \
    --interval=1000 \
    > "$OUT"

echo "Wrote $OUT"
