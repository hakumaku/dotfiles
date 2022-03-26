#!/usr/bin/env bash

function run {
  if ! pgrep -f $1; then
    $@ &
  fi
}

# List autostart applications here
run fcitx
run xcompmgr -c -C
run tranmission-gtk -m
run thunderbird
run slack
run redshift

# List idempotent commands here
# background wallpaper
~/.fehbg
# 'capslock' to 'ctrl'
# 'r_alt' to 'hangul'
setxkbmap -layout us -option ctrl:nocaps -option korean:ralt_rctrl
# Prevent display from turning off
xset s off
xset s noblank
# The -dpms option disables DPMS (Energy Star) features.
xset -dpms
