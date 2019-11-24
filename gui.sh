#!/usr/bin/env bash

app_title="Arch Linux Fresh Setup"
menu_title="Applications to install"
install_functions=()

build_install_functions() {
	install_functions+=("Arch Linux Base")
	install_functions+=("Ubuntu Base")
	install_functions+=("pip packages")
	install_functions+=("Simple Terminal")
	install_functions+=("Nerdfont")
	install_functions+=("Vundle and Vim plugins")
	install_functions+=("Tmux")
	install_functions+=("Fcitx hangul")
	install_functions+=("Ranger Devicons")
	install_functions+=("Suru++ Icons")
	install_functions+=("Youtube-dl")
	install_functions+=("Unimatrix")
	install_functions+=("Window manager: i3-gaps")
	install_functions+=("Window manager: bspwm")
	install_functions+=("Bar: polybar")
	install_functions+=("Bar: lemonbar")
	install_functions+=("Launcher: dmenu")
	install_functions+=("Launcher: rofi")
}

main() {
	build_install_functions
	local height=30
	local width=60
	local height_list=10
	whiptail --backtitle "$app_title" --menu "$menu_title" \
			$height $width $height_list ${install_functions[@]}
}

main

