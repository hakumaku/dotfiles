#!/usr/bin/env bash

packages=(
  "com.github.tchx84.Flatseal"
  "com.mattjakeman.ExtensionManager"
  "com.slack.Slack"
  "io.github.celluloid_player.Celluloid"
  "io.missioncenter.missioncenter"
  "com.transmissionbt.Transmission"
  "io.github.flattool.Warehouse"
  "io.mpv.Mpv"
  "md.obsidian.Obsidian"
  "org.gnome.Geary"
  "org.mozilla.firefox"
)
flatpak install "${packages[@]}"
