#!/usr/bin/env bash

set -euo pipefail

config_fcitx() {
  sudo locale-gen en_US.utf8 ko_KR.utf8

  msg info "executing fcitx to generate config"
  if [[ -d "$HOME/.config/fcitx5" ]]; then
    local conf="$HOME/.config/fcitx5"
  else
    local conf="$HOME/.config/fcitx"
  fi

  if [[ ! -d "$conf" ]]; then
    fcitx -d &
    sleep 3
    pkill "fcitx"
  fi

  msg info "configuring fcitx"
  # Set input method
  local profile="$conf/profile"
  sed -Ei "s/#(IMName=)/\1Hangul/" "$profile"
  sed -Ei "s/(hangul:)False/\1True/" "$profile"
  # Disable some keys and set TriggerKey to 'hangul'
  local config="$conf/config"
  sed -Ei "s/#(TriggerKey=).*/\1HANGUL CTRL_SHIFT_SPACE/" "$config"
  sed -Ei "s/#(SwitchKey=).*/\1Disabled/" "$config"
  sed -Ei "s/#(IMSwitchKey=).*/\1False/" "$config"
  # Disable ctrl+5 key (ReloadConfig)
  sed -Ei "s/#(ReloadConfig=).*/\1/" "$config"
  # Disable ctrl+; key in fcitx-clipboard.config
  local clipboard="$conf/conf/fcitx-clipboard.config"
  sed -Ei "s/#(TriggerKey=).*/\1/" "$clipboard"

  # im-config -n fcitx
  msg info "configuring input method"
  sudo sed -i "s/run_im (.*)/run_im fcitx/" /etc/X11/xinit/xinputrc
}

config_fcitx
