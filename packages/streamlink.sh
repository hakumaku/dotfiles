#!/usr/bin/env bash

set -euo pipefail

fetch_from_git_streamlink_twitch_gui() {
  msg info "installing streamlink-twitch-gui"
  local dir="$HOME/.local/bin"
  fetch_from_git "streamlink/streamlink-twitch-gui" \
    "streamlink-twitch-gui-v.*-x86_64.AppImage" \
    "$dir"

  msg info "chmod +x streamlink-twitch-gui"
  local output="$(compgen -G $dir/streamlink-twitch-gui*)"
  chmod +x $output
  mv $output $dir/streamlink-twitch-gui

  msg info "copying twitch.desktop to $XDG_DATA_HOME"
  cp $SCRIPT_HOME/scripts/twitch.desktop ${XDG_DATA_HOME:-$HOME/.local/share}/applications/
}

pip_install_streamlink() {
  msg info "installing streamlink"
  pip install --quiet --user --upgrade streamlink

  if ! command -v streamlink-twitch-gui &>/dev/null; then
    fetch_from_git_streamlink_twitch_gui
  fi

  whereis streamlink
  streamlink --version
}

pip_install_streamlink
