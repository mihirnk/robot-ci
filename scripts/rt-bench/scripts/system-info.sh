#!/bin/bash
set -e

OUT=~/rt-bench/results/system-info-$(date +"%Y%m%d-%H%M%S").txt

{
    echo "===== SYSTEM INFO ====="
    uname -a
    echo

    echo "===== CPU INFO ====="
    lscpu
    echo

    echo "===== Kernel Config (relevant RT flags) ====="
    zgrep -E "PREEMPT|HZ_|IRQ|NO_HZ" /proc/config.gz
    echo

    echo "===== Running Services ====="
    systemctl list-units --type=service --state=running
    echo
} > "$OUT"

echo "Wrote $OUT"
