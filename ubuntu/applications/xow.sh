#!/usr/bin/env bash

install_xow() {
  local url="https://github.com/medusalix/xow"
  local dest="${prefix}/${url##*/}"
  if [ ! -d "$dest" ]; then
    local dependencies=("cabextract" "libusb-1.0-0-dev")
    sudo apt install ${dependencies[@]}
    git clone "$url" "$dest"
  else
    git -C "$dest" pull
  fi

  (cd $dest && make BUILD=RELEASE -j8 && sudo make install)
}

install_xow
