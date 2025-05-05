#!/usr/bin/env bash

packages=(
  "com.brave.Browser"
  "com.github.Matoking.protontricks"
  "com.github.tchx84.Flatseal"
  "com.google.Chrome"
  "com.mattjakeman.ExtensionManager"
  "com.slack.Slack"
  "de.haeckerfelix.Fragments"
  "dev.qwery.AddWater"
  "io.freetubeapp.FreeTube"
  "io.github.flattool.Warehouse"
  "io.github.seadve.Kooha"
  "io.missioncenter.MissionCenter"
  "md.obsidian.Obsidian"
  "org.gnome.Geary"
  "org.gnome.gitlab.YaLTeR.VideoTrimmer"
  "org.mozilla.firefox"
  "xyz.safeworlds.hiit"
)
flatpak install "${packages[@]}"
