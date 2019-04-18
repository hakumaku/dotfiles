#!/usr/bin/env bash

bool=$(gsettings get org.gnome.settings-daemon.plugins.color night-light-enabled)
if [ $bool ==  "true" ]; then
	gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled false
else
	gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
fi
