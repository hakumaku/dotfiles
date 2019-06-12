#!/usr/bin/env bash

disable_autostart () {
	# $1: full path to ".desktop"
	local src="$1"
	local dest="$HOME/.config/autostart/""$(basename -- $src)"
	if [ ! -f $src ]; then
		return
	fi
	mkdir -r "$HOME/.config/autostart" && cp "$src" "$dest" &&
	echo "X-GNOME-Autostart-enabled=false" >> $dest
}

disable_autostart /etc/xdg/autostart/gnome-software-service.desktop

