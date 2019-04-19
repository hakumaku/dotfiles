#!/usr/bin/env bash

# Script for miscellaneous configurations

LOCAL_TOTEM="/usr/share/thumbnailers/totem.thumbnailer"
REMOTE_TOTEM="$HOME"`
	`"/workspace/ubuntu-fresh/dotfiles/gif/totem.thumbnailer"

LOCAL_SMPLAYER="$HOME/.config/smplayer/smplayer.ini"
REMOTE_SMPLAYER="$HOME"`
	`"/workspace/ubuntu-fresh/dotfiles/smplayer/smplayer.ini"

LOCAL_VLC="$HOME/.config/vlc/vlcrc"
REMOTE_VLC="$HOME"`
	`"/workspace/ubuntu-fresh/dotfiles/vlc/vlcrc"
LOCAL_VLC_SKINS="$HOME/.local/share/vlc"
REMOTE_VLC_SKINS="$HOME"`
	`"/workspace/ubuntu-fresh/dotfiles/vlc/skins2"

smplayer () {
	[ -f $REMOTE_SMPLAYER ] && mkdir -p $HOME/.config/smplayer &&
	cp "$REMOTE_SMPLAYER" "$LOCAL_SMPLAYER"
}

vlc_player () {
	[ -f $REMOTE_VLC ] && mkdir -p $HOME/.config/vlc &&
	cp "$REMOTE_VLC" "$LOCAL_VLC"

	[ -f $REMOTE_VLC_SKINS ] && mkdir -p $HOME/.local/share/vlc &&
	cp -r "$REMOTE_VLC_SKINS" "$LOCAL_VLC_SKINS"
}

thumbnailer () {
	[ -f $TOTEM_SOURCE ] && sudo cp "$REMOTE_TOTEM" "$LOCAL_TOTEM"
}

git_config () {
	git config --global user.email "gentlebuuny@gmail.com"
	git config --global user.name "hakumaku"
}

clear_unwanted_extension () {
	local dir="/usr/share/gnome-shell/extensions"
	sudo rm -rf "$dir/screenshot-window-sizer"*
	sudo rm -rf "$dir/apps-menu"*
	sudo rm -rf "$dir/auto-move-window"*
	sudo rm -rf "$dir/ubuntu-dock"*
	sudo rm -rf "$dir/launch-new-instance"*
	sudo rm -rf "$dir/window-list"*
	sudo rm -rf "$dir/native-window-placement"*
	sudo rm -rf "$dir/windowsNavigator"*
	sudo rm -rf "$dir/places-menu"*
	sudo rm -rf "$dir/workspace-indicator"*
	sudo rm -rf "$dir/drive-menu"*
}

while getopts "is" opt; do
	case "$opt" in
		"i")
			vlc_player
			# smplayer
			thumbnailer
			git_config
			clear_unwanted_extension
			break;;
		"s")
			# import sync_dotfile ()
			source "$(dirname "$0")""/sync.sh"
			sync_dotfile "$LOCAL_TOTEM" "$REMOTE_TOTEM"
			# sync_dotfile "$LOCAL_SMPLAYER" "$REMOTE_SMPLAYER"
			sync_dotfile "$LOCAL_VLC" "$REMOTE_VLC"
			break;;
		*)
			break;;
	esac
done

