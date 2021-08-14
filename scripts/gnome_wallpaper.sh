#!/usr/bin/env bash

main() {
  readarray -t wallpapers < <(fd . $HOME/Pictures/feh)
  size=${#wallpapers[*]}

  while true; do
    temp=$(printf "%s\n" "${wallpapers[@]}" | sort -R)
    for wallpaper in "${temp[@]}"; do
      echo gsettings set org.gnome.desktop.background picture-uri "$wallpaper"
      echo gsettings set org.gnome.desktop.background picture-options "scaled"
      sleep 1m
    done
  done
}

main "$@"
