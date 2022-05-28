#!/usr/bin/env bash

set -euo pipefail

clone_or_pull_ranger_devicons() {
  msg info "installing ranger devicons"
  local dest="$HOME/.config/ranger/plugins/ranger_devicons"
  clone_or_pull "alexanderjeurissen/ranger_devicons" $dest
}

install_ueberzug() {
  install_dependencies ueberzug

  msg info "installing pillow-simd"
  CC="cc -mavx2" pip install --quiet -U --force-reinstall pillow-simd

  msg info "installing ueberzug"
  pip install --quiet ueberzug
}

config_ranger() {
  msg info "generating default ranger config"
  ranger --copy-config=all

  # Enable video preview option.
  # Find 'video/*)' ~ 'exit 1;;' text and uncomment them.
  msg info "enabling video preview option"
  local scope="$HOME/.config/ranger/scope.sh"
  if [[ -f "$scope" ]]; then
    sed -in '/video\/\*)/,/exit 1;;/s/# //' $scope
  fi

  # Enable sxiv -a option.
  # Find 'flag f = sxiv' text and append '-a' option.
  msg info "configuring sxiv options"
  local config="$HOME/.config/ranger/rifle.conf"
  if [[ -f "$config" ]]; then
    local rifle="$XDG_CONFIG_HOME/nsxiv/nsxiv-rifle"
    sed -in "s#\(flag f = \)sxiv#\1$rifle#" $config
  fi
}

clone_or_pull_ranger() {
  local fresh=false
  # clone_or_pull "ranger/ranger"
  # checkout_latest
  if ! command -v ranger &>/dev/null; then
    fresh=true
    clone_or_pull_ranger_devicons
    install_ueberzug
    install_dependencies ranger

    # Mount to '/media' directory instead of '/run/media'
    # https://wiki.archlinux.org/title/udisks#Mount_to_/media_(udisks2)
    if [[ "$DISTRO" = "arch" ]]; then
      sudo cp $RESOURCE/99-udisks2.rules /etc/udev/rules.d/99-udisks2.rules
      sudo cp $RESOURCE/media.conf /etc/tmpfiles.d/media.conf
    fi
  fi
  pip install --quiet --user ranger-fm
  # msg info "make install"
  # sudo make install >/dev/null 2>&1
  if [[ $fresh = true ]]; then
    config_ranger
  fi
  # clone_or_pull_done

  whereis ranger
  ranger --version
}

clone_or_pull_ranger
