#!/usr/bin/env bash

dotfiles="$HOME/workspace/ubuntu-fresh/dotfiles"
workspace="$HOME/workspace"

install_ranger_devicons() {
	local url="https://github.com/alexanderjeurissen/ranger_devicons"
	local output="$HOME/.config/ranger/plugins/ranger_devicons"
	git clone -q "$url" "$output"
}

config_ranger() {
	if [[ ! $(command -v ranger) ]]; then
		return 1
	fi
	ranger --copy-config=all

	# Enable video preview option.
	# Find 'video/*)' ~ 'exit 1;;' text and uncomment them.
	local config="$HOME/.config/ranger/scope.sh"
	if [[ -f "$config" ]]; then
		sed -in '/video\/\*)/,/exit 1;;/s/# //' $config
	fi

	# Enable sxiv -a option.
	# Find 'flag f = sxiv' text and append '-a' option.
	config="$HOME/.config/ranger/rifle.conf"
	if [[ -f "$config" ]]; then
		sed -in 's/flag f = sxiv/& -a/' $config
	fi

	# Set rc.conf
	(cd $HOME/.config/ranger && {
		# Remove rc.conf craeted by ranger_devicons if exists.
		if [[ -f rc.conf ]]; then
			rm rc.conf
		fi; } &&
		ln -s $dotfiles/ranger/rc.conf)
}

install_ueberzug() {
	local dependencies=(
		"python3" "python-is-python3" "python3-pip"
		"libjpeg-dev" "zlib1g-dev"
		"libxcomposite-dev" "libx11-dev"
		"ffmpegthumbnailer")
	sudo apt install ${dependencies[@]} &&
		CC="cc -mavx2" pip3 install -U --force-reinstall pillow-simd &&
		pip3 install ueberzug
}

sudo apt install python3-distutils &&
git clone https://github.com/ranger/ranger "${workspace}/ranger" && install_ueberzug &&
	(cd "${workspace}/ranger" && sudo make install && install_ranger_devicons &&
	config_ranger)
