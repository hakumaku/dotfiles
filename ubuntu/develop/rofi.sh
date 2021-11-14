#!/usr/bin/env bash

fetch_from_git_rofi() {
  local tmpdir=$(dirname $(mktemp -u))
  if ! command -v rofi &>/dev/null; then
    install_dependencies \
      "bison" \
      "flex" \
      "libgdk-pixbuf-2.0-dev" \
      "libglib2.0-dev" \
      "libpango1.0-dev" \
      "libpangocairo-1.0-0" \
      "libstartup-notification0-dev" \
      "libxcb-cursor-dev" \
      "libxcb-ewmh-dev" \
      "libxcb-icccm4-dev" \
      "libxcb-randr0-dev" \
      "libxcb-util-dev" \
      "libxcb-xinerama0-dev" \
      "libxcb-xkb-dev" \
      "libxkbcommon-x11-dev"

    fetch_from_git "davatorium/rofi" \
      "rofi-.*\.tar\.gz" \
      $tmpdir
  else
    local local_version=$(rofi -v | cut -d' ' -f2)
    fetch_from_git "davatorium/rofi" \
      "rofi-.*\.tar\.gz" \
      $tmpdir \
      $local_version
  fi

  local output="$(compgen -G $tmpdir/rofi-*)"
  if [[ -f $output ]]; then
    msg info "extracting source"
    tar -xzf $output --directory "$tmpdir"
    rm $output
    local src="$(compgen -G $tmpdir/rofi-*)"

    cd $src
    msg progress "autoreconf"
    (cd $src && autoreconf --install >/dev/null 2>&1)
    msg progress "configure"
    (mkdir $src/build && cd $src/build && ../configure --disable-check >/dev/null 2>&1)
    msg progress "make"
    make --directory=$src/build >/dev/null 2>&1
    msg progress "make install"
    sudo make --directory=$src/build install >/dev/null 2>&1

    rm -rf $src
  fi
}

fetch_from_git_rofi
