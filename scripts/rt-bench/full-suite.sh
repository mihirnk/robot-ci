#!/bin/bash
set -e

CPU=${1:-0}
DUR=${2:-600}

bash ~/rt-bench/scripts/system-info.sh
bash ~/rt-bench/scripts/run-osnoise.sh $DUR $CPU
bash ~/rt-bench/scripts/run-timerlat.sh $DUR $CPU
bash ~/rt-bench/scripts/run-cyclictest.sh $DUR 1 $CPU
bash ~/rt-bench/scripts/run-perf.sh 60
echo "Full suite completed."