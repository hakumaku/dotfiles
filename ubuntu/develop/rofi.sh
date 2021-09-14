#!/usr/bin/env bash

install_rofi() {
  local dest="$PREFIX/rofi"
  if [ ! -d "$dest" ]; then
    local dependencies=(
      "libglib2.0-dev" "bison" "flex"
      "libxcb-xkb-dev" "libxcb-randr0-dev" "libxcb-xinerama0-dev"
      "libxkbcommon-x11-dev" "libxcb-ewmh-dev" "libxcb-icccm4-dev" "libxcb-cursor-dev"
      "libxcb-util-dev" "libpango1.0-dev" "libpangocairo-1.0-0" "libstartup-notification0-dev"
      "libgdk-pixbuf-2.0-dev"
    )
    sudo apt install ${dependencies[@]}
    git clone --recursive https://github.com/DaveDavenport/rofi
  else
    git pull
    git submodule update --init
  fi

  autoreconf -i
  mkdir build
  pushd build
  ../configure --disable-check
  make
  sudo make install
  popd
}

install_rofi
