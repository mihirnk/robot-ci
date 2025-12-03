#!/bin/bash
set -e

TEST=$1
DUR=${2:-120}
CPU=${3:-0}

if [ -z "$TEST" ]; then
    echo "Usage: ./rt-under-stress.sh <cpu|irq|sched|context|fork|vm> [duration] [cpu]"
    exit 1
fi

LOG=~/rt-bench/results/rtla-${TEST}-$(uname -r)-$(date +"%Y%m%d-%H%M%S").txt

echo "Starting ${TEST} stress + rtla timerlat on CPU ${CPU} for ${DUR}s"

# start stress-ng in background
stress-ng --${TEST} 4 --timeout ${DUR}s --metrics-brief &
STRESS_PID=$!

# run latency detector
sudo rtla timerlat --cpu $CPU --duration $DUR --period 1000 --quiet > "$LOG"

wait $STRESS_PID
echo "Wrote $LOG"
