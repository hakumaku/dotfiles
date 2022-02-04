#!/usr/bin/env bash

set -eo pipefail

repo="streamlink/streamlink-twitch-gui"
expr="streamlink-twitch-gui-v.*-x86_64.AppImage"

fetch_from_git_streamlink_twitch_gui() {
  msg info "installing streamlink-twitch-gui"

  local appdir="$XDG_DATA_HOME/applications"
  local tmpdir=$(dirname $(mktemp -u))
  if [[ -f "$appdir/twitch-version.txt" ]]; then
    local local_version=$(cat "$appdir/twitch-version.txt")
    fetch_from_git "$repo" "$expr" $tmpdir $local_version
  else
    fetch_from_git "$repo" "$expr" $tmpdir
  fi

  msg info "chmod +x streamlink-twitch-gui"
  local output="$(compgen -G $tmpdir/streamlink-twitch-gui*)"
  if [[ -f $output ]]; then
    chmod +x $output
    mv $output "$HOME/.local/bin/streamlink-twitch-gui"
    # Log version to file.
    local ver=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/$repo/releases/latest")
    ver=${ver##*/}
    echo $ver >"$appdir/twitch-version.txt"
  fi

  if [[ ! -f ${XDG_DATA_HOME:-$HOME/.local/share}/applications/twitch.desktop ]]; then
    msg info "copying twitch.desktop to $XDG_DATA_HOME"
    cp $SCRIPT_HOME/scripts/twitch.desktop ${XDG_DATA_HOME:-$HOME/.local/share}/applications/
  fi
}

pip_install_streamlink() {
  msg info "installing streamlink"
  pip install --quiet --user --upgrade streamlink

  whereis streamlink
  streamlink --version
}

pip_install_streamlink
fetch_from_git_streamlink_twitch_gui
