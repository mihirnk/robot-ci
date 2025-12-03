#!/bin/bash
set -e

DUR=${1:-120}

echo "Running context-switch stress for $DUR seconds"
stress-ng --switch 4 --timeout ${DUR}s --metrics-brief
