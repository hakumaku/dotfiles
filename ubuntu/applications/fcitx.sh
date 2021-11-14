#!/usr/bin/env bash

config_fcitx() {
  if ! command -v fcitx &>/dev/null; then
    msg info "installing fcitx-hangul"
    # A bit buggy, don't know why yet.
    sudo apt -qq install fcitx-hangul

    # im-config -n fcitx
    msg info "configuring input method"
    sed -i "s/run_im (.*)/run_im fcitx/" /etc/X11/xinit/xinputrc

    msg info "executing fcitx to generate config"
    local conf="$HOME/.config/fcitx"
    if [[ ! -d "$conf" ]]; then
      fcitx -d &
      sleep 3
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
  else
    msg info "everything is up to date"
  fi
}

config_fcitx
