#!/bin/bash
set -e

DUR=${1:-120}

echo "Running IRQ stress for $DUR seconds"
stress-ng --irq 4 --timeout ${DUR}s --metrics-brief
