#!/usr/bin/env bash

config_fcitx() {
	im-config -n fcitx
	if [[ ! -d "$HOME/.config/fcitx" ]]; then
		( exec fcitx -d & )
	fi

	local profile="$HOME/.config/fcitx/profile"
	local config="$HOME/.config/fcitx/config"
	# A bit buggy, don't know why yet.
	sed -Ei "s/#(IMName=)/\1Hangul/" "$profile"
	sed -Ei "s/(hangul:)False/\1True/" "$profile"
	sed -Ei "s/#(TriggerKey=).*/\1HANGUL/" "$config"
	sed -Ei "s/#(SwitchKey=).*/\1Disabled/" "$config"
	sed -Ei "s/#(IMSwitchKey=).*/\1False/" "$config"
}

sudo apt install fcitx-hangul && config_fcitx
