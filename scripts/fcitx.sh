#!/usr/bin/env bash

set -euo pipefail

config_fcitx() {
  local conf="$HOME/.config/fcitx5"
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
}

config_fcitx
