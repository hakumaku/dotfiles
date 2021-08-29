#!/usr/bin/env bash

install_ranger_devicons() {
  local url="https://github.com/alexanderjeurissen/ranger_devicons"
  git clone -q "$url" "$HOME/.config/ranger/plugins/${url##*/}"
}

install_ueberzug() {
  local dependencies=(
    "python3" "python-is-python3" "python3-pip"
    "libjpeg-dev" "zlib1g-dev"
    "libxcomposite-dev" "libx11-dev"
    "ffmpegthumbnailer")
  sudo apt install ${dependencies[@]} \
    && CC="cc -mavx2" pip3 install -U --force-reinstall pillow-simd \
    && pip3 install ueberzug
}

config_ranger() {
  if [[ ! $(command -v ranger) ]]; then
    return 1
  fi
  ranger --copy-config=all

  # Enable video preview option.
  # Find 'video/*)' ~ 'exit 1;;' text and uncomment them.
  local config="$HOME/.config/ranger/scope.sh"
  if [[ -f "$config" ]]; then
    sed -in '/video\/\*)/,/exit 1;;/s/# //' $config
  fi

  # Enable sxiv -a option.
  # Find 'flag f = sxiv' text and append '-a' option.
  config="$HOME/.config/ranger/rifle.conf"
  if [[ -f "$config" ]]; then
    sed -in 's/flag f = sxiv/& -abfsh/' $config
  fi
}

install_ranger() {
  local url="https://github.com/ranger/ranger"
  local dest="${PREFIX}/${url##*/}"
  if [ ! -d "$dest" ]; then
    git clone "$url" "$dest"
    (cd "$dest" && sudo make install)
    install_ranger_devicons
    install_ueberzug
    config_ranger
  else
    git -C "$dest" pull
    (cd "$dest" && sudo make install)
  fi
}

install_ranger
