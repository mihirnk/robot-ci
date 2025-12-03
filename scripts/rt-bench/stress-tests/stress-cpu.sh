#!/bin/bash
set -e

DUR=${1:-120}
CPUS=$(nproc)

echo "Running CPU stress for $DUR seconds on $CPUS CPUs"
stress-ng --cpu $CPUS --timeout ${DUR}s --metrics-brief
