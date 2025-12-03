#!/bin/bash
set -e
OUTDIR=~/rt-bench/results
mkdir -p "$OUTDIR"
DUR=${1:-120}   # per-test duration
CPU_RT=${2:-2}  # CPU to pin RT test process

# helper to log uname
echo "=== Experiment run $(date) ===" | tee -a $OUTDIR/experiment-log.txt
uname -a | tee -a $OUTDIR/experiment-log.txt

# list of variants: "stock", "rt-untuned", "rt-basic", "rt-aggressive"
VARIANTS=("stock" "rt-untuned" "rt-basic" "rt-aggressive")

for V in "${VARIANTS[@]}"; do
  echo "==== Variant: $V ====" | tee -a $OUTDIR/experiment-log.txt
  if [ "$V" = "stock" ]; then
    echo "Assume currently running stock kernel; run tests now"
  elif [ "$V" = "rt-untuned" ]; then
    echo "Boot into RT kernel with default params and retest"
    # user must reboot into RT kernel before continuing
    echo "Please reboot into RT kernel now, then re-run this script for remaining variants."
    exit 0
  elif [ "$V" = "rt-basic" ]; then
    echo "Applying basic runtime tuning..."
    bash ~/rt-bench/scripts/tune-basic-runtime.sh $CPU_RT 0
    bash ~/rt-bench/scripts/tune-isolate-irq.sh 0
  elif [ "$V" = "rt-aggressive" ]; then
    echo "Applying aggressive tuning: ensure grub contains isolcpus/nohz_full/rcu_nocbs before boot"
    # Optionally remind user to set grub cmdline to include isolcpus,nohz_full,rcu_nocbs before reboot
    echo "Make sure you have rebooted with kernel cmdline including: isolcpus=${CPU_RT} nohz_full=${CPU_RT} rcu_nocbs=${CPU_RT}"
    sleep 2
    # apply other runtime adjustments:
    bash ~/rt-bench/scripts/set-cpu-cstates.sh || true
    sudo sysctl -w kernel.timer_migration=0 || true
    sudo sysctl -w kernel.sched_rt_runtime_us=-1 || true
  fi

  # run stress + latency tests
  stamp=$(date +%Y%m%d-%H%M%S)
  echo "Running rtla timerlat (duration ${DUR}) for $V"
  sudo rtla timerlat --duration $DUR --cpu $CPU_RT --period 1000 --quiet > $OUTDIR/timerlat-${V}-${stamp}.txt & pid_timer=$!

  echo "Run cyclictest for $V"
  sudo cyclictest --mlockall --smp --priority=95 --threads=1 --affinity=$CPU_RT --duration=${DUR}s --interval=1000 > $OUTDIR/cyclictest-${V}-${stamp}.txt & pid_cyc=$!

  # run a representative stress-ng load concurrently (cpu + irq + vm)
  echo "Starting combined stress-ng load"
  stress-ng --cpu 2 --matrix 1 --irq 2 --vm 1 --vm-bytes 256M --timeout ${DUR}s --metrics-brief > $OUTDIR/stressng-${V}-${stamp}.txt 2>&1 & pid_stress=$!

  # wait for tests
  wait $pid_timer $pid_cyc $pid_stress || true
  echo "Completed variant $V"
done

echo "All variants invoked or user-intervention required. Check $OUTDIR"
