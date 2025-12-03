#!/bin/bash
set -e

DUR=${1:-120}

echo "Running scheduler stress for $DUR seconds"
stress-ng --sched 4 --timeout ${DUR}s --metrics-brief
