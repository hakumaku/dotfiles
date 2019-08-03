#!/usr/bin/env bash

export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
fcitx -d
setxkbmap -layout us -option ctrl:nocaps
setxkbmap -layout us -option korean:ralt_rctrl
xset +fp /home/haku/.fonts
xset fp rehash

# Monitor
compton &
plank &
# exec --no-startup-id feh --bg-fill /home/haku/Pictures/house.png
# exec --no-startup-id xrandr --output eDP-1-1 --off

