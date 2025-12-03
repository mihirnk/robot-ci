#!/bin/bash
set -e

DUR=${1:-120}

echo "Running VM/page-fault stress for $DUR seconds"
stress-ng --page-in 4 --page-out 4 --mmap 4 --timeout ${DUR}s --metrics-brief
