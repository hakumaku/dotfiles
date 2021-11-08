#!/usr/bin/env bash

install_rofi() {
  local dest="$PREFIX/rofi"
  if [ ! -d "$dest" ]; then
    local url="https://github.com/DaveDavenport/rofi"
    local dependencies=(
      "libglib2.0-dev" "bison" "flex"
      "libxcb-xkb-dev" "libxcb-randr0-dev" "libxcb-xinerama0-dev"
      "libxkbcommon-x11-dev" "libxcb-ewmh-dev" "libxcb-icccm4-dev" "libxcb-cursor-dev"
      "libxcb-util-dev" "libpango1.0-dev" "libpangocairo-1.0-0" "libstartup-notification0-dev"
      "libgdk-pixbuf-2.0-dev"
    )
    sudo apt install ${dependencies[@]}
    git clone --recurse-submodules $url $dest

    pushd $dest
    autoreconf -i
    mkdir build && cd build
    ../configure --disable-check
    popd
  else
    git -C $dest pull --recurse-submodules
  fi

  pushd $dest/build
  make
  sudo make install
  popd
}

install_rofi
