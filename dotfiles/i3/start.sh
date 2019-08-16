#!/usr/bin/env bash
export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

fcitx -d &
setxkbmap -layout us -option ctrl:nocaps -option korean:ralt_rctrl
xset +fp /home/haku/.local/share/fonts
xset fp rehash
compton &
exec ~/.config/polybar/main.sh &
# Monitor
# exec --no-startup-id compton
# exec --no-startup-id xrandr --output eDP-1-1 --off
feh --bg-fill /home/haku/Pictures/house.png &
