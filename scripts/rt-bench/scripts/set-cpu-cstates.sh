#!/bin/bash
# Disable deep cstates (may be vendor-dependent)
echo 0 | sudo tee /sys/module/intel_idle/parameters/max_cstate >/dev/null || true
echo 1 | sudo tee /sys/module/processor/parameters/max_cstate >/dev/null || true
echo "Attempted to set max C-state; check /sys/module/*/parameters/max_cstate"
