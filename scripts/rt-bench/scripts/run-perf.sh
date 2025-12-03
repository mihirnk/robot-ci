#!/bin/bash
set -e

DUR=${1:-60}  # perf can't run too long due to huge output

OUT=~/rt-bench/results/perf-stat-$(uname -r)-$(date +"%Y%m%d-%H%M%S").txt

echo "Running perf stat for $DUR seconds"
sudo perf stat -a sleep $DUR 2> "$OUT"

echo "Wrote $OUT"
