#!/usr/bin/env bash

change_icons() {
	if [ -z $1 ]; then
		return 1
	fi

	local app=$1
	local path="/var/lib/snapd/desktop/applications"
	local icon=""

	if [ "$app" = "lol" ] || [ "$app" = "leagueoflegends" ]; then
		icon="leagueoflegends"
		app="leagueoflegends_leagueoflegends.desktop"

	elif [ "$app" = "discord" ]; then
		icon="discord"
		app="discord_discord.desktop"

	elif [ "$app" = "system" ]; then
		icon="system"
		app="gnome-system-monitor_gnome-system-monitor.desktop"

	elif [ "$app" = "code" ] || [ "$app" = "vscode" ]; then
		icon="visual-studio-code"
		app="code_code.desktop"

	elif [ "$app" = "alacritty" ]; then
		icon="terminal"
		app="com.alacritty.Alacritty.desktop"
		path="/usr/share/applications"

	elif [ "$app" = "thunderbird" ]; then
		app="thunderbird.desktop"
		path="/usr/share/applications"
		sudo sed -ri '/(StartupNotify=.*)/a StartupWMClass=Thunderbird' "$path/$app"
		return 0

	else
		return 2
	fi

	sudo sed -ri 's/(Icon=)(.*)/\1'$icon'/' "$path/$app"
}

change_icons "$@"
