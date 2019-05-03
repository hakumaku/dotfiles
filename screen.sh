#!/usr/bin/env bash

val=($(gsettings get org.gnome.desktop.session idle-delay))
if [ ${val[1]} -gt  0 ]; then
	echo "Screen saver turned off"
	gsettings set org.gnome.desktop.session idle-delay 0
else
	echo "Screen saver turned on"
	gsettings set org.gnome.desktop.session idle-delay 300
fi

