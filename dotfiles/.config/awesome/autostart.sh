#!/usr/bin/env bash

# 4K display settings
resolution=$(xdpyinfo | grep dimensions | awk '{print $2}')
if [ "$resolution" = "3840x2160" ]; then
  export GDK_DPI_SCALE=1.5
  export GDK_SCALE=1.5
  export QT_AUTO_SCREEN_SCALE_FACTOR=1.5
  export QT_SCALE_FACTOR=1.5
fi


export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
fcitx &
setxkbmap -layout us -option ctrl:nocaps -option korean:ralt_rctrl

xcompmgr -c -C &
tranmission-gtk &
plank &
# feh --bg-fill --randomize $HOME/Pictures/feh/* &
~/.fehbg
