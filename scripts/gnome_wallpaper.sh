#!/usr/bin/env bash

shuffle() {
  local -n arr=$1

  for ((i = 0; i < 300; i++)); do
    local i1=$(($RANDOM % $size))
    local i2=$(($RANDOM % $size))
    local t="${arr[i1]}"
    arr[i1]="${arr[i2]}"
    arr[i2]="$t"
  done
}

main() {
  readarray -t wallpapers < <(fd . $HOME/Pictures/feh)
  size=${#wallpapers[*]}

  while true; do
    shuffle wallpapers
    for wallpaper in "${wallpapers[@]}"; do
      gsettings set org.gnome.desktop.background picture-uri "$wallpaper"
      gsettings set org.gnome.desktop.background picture-options "scaled"
      sleep 1m
    done
  done
}

main "$@"
