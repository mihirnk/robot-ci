#!/bin/bash
set -e
if [ -f /etc/default/grub.bak ]; then
  sudo cp /etc/default/grub.bak /etc/default/grub
  echo "Restored /etc/default/grub from backup /etc/default/grub.bak"
else
  echo "No /etc/default/grub.bak found; check backups in /etc/default/"
fi
