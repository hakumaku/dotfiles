#!/usr/bin/env bash

set -eo pipefail

install_kitty() {
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
  ln -s $HOME/.local/kitty.app/bin/kitty $HOME/.local/bin
  cp $HOME/.local/kitty.app/share/applications/kitty.desktop ${XDG_DATA_HOME}/applications/
  cp $HOME/.local/kitty.app/share/applications/kitty-open.desktop ${XDG_DATA_HOME}/applications/
  sed -i \
      's/^\(Exec=\)kitty/\1env GLFW_IM_MODULE=ibus kitty --single-instance/' \
      ${XDG_DATA_HOME}/applications/kitty.desktop
}

install_kitty
