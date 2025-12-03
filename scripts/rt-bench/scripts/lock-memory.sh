#!/bin/bash
# elevate RLIMIT_MEMLOCK
ulimit -l unlimited
echo "Set memlock unlimited for this shell. To enforce globally, edit /etc/security/limits.conf"
