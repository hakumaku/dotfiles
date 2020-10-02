#!/usr/bin/env bash

dotfiles="$HOME/workspace/ubuntu-fresh/dotfiles"
workspace="$HOME/workspace"

dependencies=(
	"libcairo2-dev"
	"libxcb1-dev"
	"libxcb-xkb-dev"
	"libxcb-util0-dev"
	"libxcb-randr0-dev"
	"libxcb-composite0-dev"
	"libxcb-xrm-dev"
	"libxcb-cursor-dev"
	"python3-xcbgen"
	"xcb-proto"
	"libxcb-image0-dev"
	"libxcb-ewmh-dev"
	"libxcb-icccm4-dev"
	"libpulse-dev"
	"libasound2-dev"
	"libmpdclient-dev"
	"libcurl4-openssl-dev"
	"libnl-genl-3-dev"
	"unifont"
)

packages=(
	"compton"
	"feh"
)

sudo apt install ${packages[@]} ${dependencies[@]} &&
	git clone "https://github.com/polybar/polybar" "$workspace" &&
	cd "$workspace/polybar" &&
	mkdir build &&
	cd build &&
	cmake .. &&
	make -j4 &&
	sudo make install && {
		(cd $HOME/.config && ln -s "$dotfiles/bspwm" . && ln -s "$dotfiles/sxhkd" .) &&
		(cd $HOME && ln -s "$dotfiles/xprofile" .xprofile) &&
		(cd $HOME/.config && ln -s "$dotfiles/polybar" .)
	}
