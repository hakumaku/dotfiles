#!/usr/bin/env bash

clone_or_pull_ranger_devicons() {
  msg info "installing ranger devicons"
  local dest="$HOME/.config/ranger/plugins/ranger_devicons"
  clone_or_pull "alexanderjeurissen/ranger_devicons" $dest
}

install_ueberzug() {
  install_dependencies \
    "python3" \
    "python-is-python3" \
    "python3-pip" \
    "libjpeg-dev" \
    "zlib1g-dev" \
    "libxcomposite-dev" \
    "libx11-dev" \
    "ffmpegthumbnailer"

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
    sed -in 's/flag f = sxiv/& -abfsh/' $config
  fi
}

clone_or_pull_ranger() {
  clone_or_pull "ranger/ranger"
  if ! command -v ranger &>/dev/null; then
    config_ranger
    clone_or_pull_ranger_devicons
    install_ueberzug
  fi
  msg info "make install"
  sudo make install >/dev/null 2>&1
  clone_or_pull_done
}

clone_or_pull_ranger
