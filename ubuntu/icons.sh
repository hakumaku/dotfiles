#!/usr/bin/env bash

application=""

search_app() {
	local default_path="/usr/share/applications"
	local snap_path="/var/lib/snapd/desktop/applications"
	local local_path="$HOME/.local/share/applications"

	while [ $# -gt 0 ]; do
		local app=$1
		if [ -f "${snap_path}/${app}_${app}.desktop" ]; then
			application="${snap_path}/${app}_${app}.desktop"
		elif [ -f "${default_path}/${app}.desktop" ]; then
			application="${default_path}/${app}.desktop"
		elif [ -f "${local_path}/${app}.desktop" ]; then
			application="${local_path}/${app}.desktop"
		fi
		if [ ! -z "$application" ]; then
			return
		fi
		shift
	done
}

change_icons() {
	while [ $# -gt 0 ]; do
		local input=$1
		local icon=""

		case "$input" in
			"lol"|"leagueoflegends")
				icon="leagueoflegends"
				search_app "leagueoflegends"
				;;
			"discord")
				icon="discord"
				search_app "discord"
				;;
			"system"|"gnome-system-monitor")
				icon="system"
				search_app "gnome-system-monitor"
				;;
			"code"|"vscode")
				icon="visual-studio-code"
				search_app "code"
				;;
			"zenkit")
				icon="zenkit"
				search_app "zenkit"
				;;
			"alacritty")
				icon="terminal"
				search_app "com.alacritty.Alacritty"
				;;
			"slack")
				icon="slack"
				search_app "slack"
				;;
			"gitkraken"|"kraken")
				icon="gitkraken"
				search_app "gitkraken"
				;;
			"thunderbird")
				icon="thunderbird"
				search_app "thunderbird"
				if [ ! -z $application ]; then
					sudo sed -ri '/(StartupNotify=.*)/a StartupWMClass=Thunderbird' "$application"
					shift
					continue
				fi
				;;
				# Jetbrains applications
				"pycharm")
				icon="$input"
				search_app "${input}-community" "${input}-professional" "jetbrains-${input}-community" "jetbrains-${input}-professional"
				;;
			"toolbox")
				icon="jetbrains-$input"
				search_app "$input" "jetbrains-$input"
				;;
			"clion"|"datagrip")
				icon="$input"
				search_app "$input" "jetbrains-$input"
				;;
		esac

		if [ ! -z "$application" ]; then
			sudo sed -ri 's/(Icon=)(.*)/\1'${icon}'/' "${application}"
		else
			echo "Cannot find such application: ${input}"
		fi

		shift
	done
}

change_icons "$@"
