#!/usr/bin/env bash

set -euo pipefail

install_steam() {
  install_dependencies steam
  install_package steam

  # Enable multilib on Arch Linux.
  if [[ -f /etc/pacman.conf ]]; then
    sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
  fi
  # Fix steam tray menu bug (https://github.com/ValveSoftware/steam-for-linux/issues/4428)
  if [[ -f /usr/share/themes/Adwaita/gtk-2.0/main.rc ]]; then
    sed -i "/direction[[:space:]]*=[[:space:]]*LTR/d" /usr/share/themes/Adwaita/gtk-2.0/main.rc
    sed -i "/direction[[:space:]]*=[[:space:]]*RTL/d" /usr/share/themes/Adwaita/gtk-2.0/main.rc
  fi
}

install_steam
