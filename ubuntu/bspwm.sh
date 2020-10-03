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
	"xss-lock"
	"compton"
	"feh"
)

install_polybar() {
	sudo apt install ${packages[@]} ${dependencies[@]} &&
		git clone "https://github.com/polybar/polybar" "$workspace" &&
		cd "$workspace/polybar" &&
		mkdir build &&
		cd build &&
		cmake .. &&
		make -j4 &&
		sudo make install
}

install_polybar_theme() {
	if [[ ! -d $HOME/.config/polybar ]]; then
		mkdir -p $HOME/.config/polybar
	fi

	git clone "https://github.com/adi1090x/polybar-themes" "$workspace" &&
		cd "${workspace}/polybar-themes/polybar-12" &&
		cp -r fonts/* $HOME/.local/share/fonts && fc-cache -v &&
		sudo rm /etc/fonts/conf.d/70-no-bitmaps.conf &&
		cp -r * $HOME/.config/polybar
}

config_bspwm() {
	(cd $HOME/.config && ln -s "$dotfiles/bspwm" . && ln -s "$dotfiles/sxhkd" .) &&
	(cd $HOME && ln -s "$dotfiles/xprofile" .xprofile)
}

sudo apt install bspwm && config_bspwm && install_polybar && install_polybar_theme
