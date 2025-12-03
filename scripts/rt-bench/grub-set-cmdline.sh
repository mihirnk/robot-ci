#!/bin/bash
# usage: scripts/grub-set-cmdline.sh "isolcpus=2 nohz_full=2 rcu_nocbs=2"
set -e
if [ -z "$1" ]; then
  echo "usage: $0 \"<cmdline-options>\""
  exit 1
fi
sudo cp /etc/default/grub /etc/default/grub.bak.$(date +%s)
# append to GRUB_CMDLINE_LINUX_DEFAULT if not present
sudo sed -i -E "s|^GRUB_CMDLINE_LINUX_DEFAULT=\"(.*)\"|GRUB_CMDLINE_LINUX_DEFAULT=\"\1 $1\"|" /etc/default/grub
echo "Updated /etc/default/grub; run sudo update-grub and reboot"
