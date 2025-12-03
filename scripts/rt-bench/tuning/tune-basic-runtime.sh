#!/bin/bash
set -e
# Example: Basic tuning: isolate CPU 2 for RT usage (assumes you previously set isolcpus in grub or you'll still get scheduler interference).
RT_CPU=${1:-2}
HOUSEKEEPING_CPU=${2:-0}

echo "Basic runtime tuning: RT_CPU=$RT_CPU, HOUSEKEEPING_CPU=$HOUSEKEEPING_CPU"

# Stop cpufreq service (if present)
sudo systemctl stop ondemand || true
# Set governor to performance on all CPUs
for cpu in /sys/devices/system/cpu/cpu[0-9]*; do
  echo performance | sudo tee $cpu/cpufreq/scaling_governor >/dev/null || true
done

# Set kernel.sched_rt_runtime_us to -1 (disable throttling)
sudo sysctl -w kernel.sched_rt_runtime_us=-1

# Optionally pin kernel threads (ksoftirqd, kworker) to housekeeping CPU
for k in $(pgrep -f ksoftirqd || true); do
  sudo taskset -pc $HOUSEKEEPING_CPU $k || true
done

echo "Basic runtime tuning applied. Use taskset/chrt to pin your real-time process to CPU $RT_CPU with high priority."
