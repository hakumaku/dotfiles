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
run gnome-keyring-daemon --daemonize --login

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

# polybar
# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar top 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Bars launched..."
