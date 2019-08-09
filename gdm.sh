#!/usr/bin/env bash

theme="$1"
if [ ! -f "$theme" ]; then
	echo "Not a file: $theme"
	exit 0
fi

css="/usr/share/gnome-shell/theme/Yaru/gnome-shell.css"
url="url(file://$theme)"
url="${url//\//\\\/}"
string="background-image: $url; background-position: center; background-size: cover; background-repeat: no-repeat; "
sudo sed -i "/#lockDialogGroup/,/}/ s/background[^}]*/$string/" "$css"

