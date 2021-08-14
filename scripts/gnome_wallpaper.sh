#!/usr/bin/env bash

main() {
  readarray -t wallpapers < <(fd . $HOME/Pictures/feh)
  size=${#wallpapers[*]}

  while true; do
    indices=$(seq $size | shuf)
    for index in ${indices[@]}; do
      echo gsettings set org.gnome.desktop.background picture-options "scaled"
      echo gsettings set org.gnome.desktop.background picture-uri "${wallpapers[$index-1]}"
      sleep 1m
    done
  done
}

main "$@"
