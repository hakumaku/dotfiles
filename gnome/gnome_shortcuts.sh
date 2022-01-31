#!/usr/bin/env bash

GNOME_CUSTOM_SHORTCUT_SETTINGS="./gnome/shortcuts.json"

set -eo pipefail

set_gsettings_custom_shortcuts_init() {
  local property="org.gnome.settings-daemon.plugins.media-keys custom-keybindings"
  local profile="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom"
  local profiles=()

  local length=$(jq '.shortcuts | length' $GNOME_CUSTOM_SHORTCUT_SETTINGS)
  for ((i = 0; i < $length; i++)); do
    profiles+=("$profile/custom$i/")
  done

  profiles=$(printf ",'%s'" "${profiles[@]}")
  profiles=${profiles:1}
  gsettings set $property "[$profiles]"
}

set_gsettings_custom_shortcuts() {
  local property="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding"
  local profiles=($(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings | tr -d "[]',"))

  while IFS= read -r name \
    && IFS= read -r command \
    && IFS= read -r binding; do

    gsettings set "$property:${profiles[0]}" name "$name"
    gsettings set "$property:${profiles[0]}" command "$command"
    gsettings set "$property:${profiles[0]}" binding "$binding"
    # Pop item
    profiles=("${profiles[@]:1}")
  done < <(jq -r '.shortcuts[] | (.name, .command, .binding)' $GNOME_CUSTOM_SHORTCUT_SETTINGS)
}

set_gsettings_custom_shortcuts_init
set_gsettings_custom_shortcuts
