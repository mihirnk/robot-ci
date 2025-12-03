#!/bin/bash
# usage: scripts/tune-isolate-irq.sh 0   => set all IRQ affinity to cpu0
set -e
if [ -z "$1" ]; then
  echo "usage: $0 <hex-mask-or-cpu-num>"
  echo "Example: $0 1   (cpu0 -> mask 1)"
  exit 1
fi
TARGET=$1
# if a simple CPU number, convert to hex mask
if [[ "$TARGET" =~ ^[0-9]+$ ]]; then
  mask=$(printf "%x" $((1 << TARGET)))
else
  mask="$TARGET"
fi

for irq in /proc/irq/*/smp_affinity ; do
  echo "$mask" | sudo tee $irq >/dev/null
done
echo "Set /proc/irq/*/smp_affinity -> $mask"
