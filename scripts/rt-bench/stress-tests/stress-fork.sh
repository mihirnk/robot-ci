#!/bin/bash
set -e

DUR=${1:-120}

echo "Running fork/exec/clone stress for $DUR seconds"
stress-ng --fork 8 --exec 8 --timeout ${DUR}s --metrics-brief
