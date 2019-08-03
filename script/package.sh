#!/usr/bin/env bash
# Script for installing packages.
# It will use apt in Ubuntu, and pacman in Arch.

PPA=(
	"ppa:nilarimogard/webupd8"			# gnome-twitch
	"ppa:graphics-drivers"				# nvidia graphics drivers
	"ppa:oguzhaninan/stacer"			# Stacer
)
UBUNTU_PACKAGE=(
	"git" "vim" "vim-gnome" "g++" "curl" "ctags"
	"valgrind" "htop" "tmux" "screenfetch" "autogen"
	"automake" "cmake" "snap" "fcitx-hangul" "gufw"
	"cmus" "sxiv" "ffmpeg" "ffmpegthumbnailer"
	"gnome-tweak-tool" "gnome-shell-extensions"
	"python3-dev" "python3-pip" "python-apt"
	"w3m-img" "compton" "feh" "moreutils"
	"plank" "steam" "vlc" "cheese" "transmission" "transmission-cli" "stacer"
	"winbind"						# wine League of Legends

	# Suckless Terminal & Dmenu
	# "libx11-dev" "libxext-dev" "libxft-dev"
	# "libxinerama-dev" "libfreetype6-dev"
	# "libxft2" "libfontconfig1-dev" "libpam0g-dev"
	# "libxrandr2" "libxss1"

	# Google Chrome
	# "google-chrome-stable" "chrome-gnome-shell"

	# Twitch
	# "gnome-twitch"
	# "gnome-twitch-player-backend-gstreamer-cairo"
	# "gnome-twitch-player-backend-gstreamer-clutter"
	# "gnome-twitch-player-backend-gstreamer-opengl"
	# "gnome-twitch-player-backend-mpv-opengl"
)

AUR=(
	"ttf-d2coding" "ttf-unfonts-core-ibx"
	"stacer" "yaru" "snapd"
)
ARCH_PACKAGE=(
	"base-devel" "gdm" "gnome" "plank"
	"networkmanager" "bluez" "bluez-utils"
	"fcitx-im" "tar" "unzip"
	"adobe-source-han-sans-kr-fonts"
	"git" "gvim" "wget" "curl" "valgrind" "htop" "screenfetch" "feh" "compton"
	"autogen" "ctags" "automake" "cmake" "gufw" "moretutils" "snap" "python-pip"
	"cmus" "sxiv" "vlc" "cheese" "transmission" "transmission-cli"
)

PIP_PACKAGE=(
	"virtualenv"
	"powerline-status"
	"ranger-fm"
)

pip_install () {
	local packages="$@"
	local os=$( cat /etc/os-release | sed -n 's/^NAME=//p' )
	os=${os,,}
	if [[ $os == *"arch"* ]]; then
		local cmd="pip"
	elif [[ $os == *"ubuntu"* ]]; then
		local cmd="pip3"
	else
		echo "Cannot determine what os it is: $os"
		exit 1
	fi
	for pack in ${packages[@]}; do
		echo $cmd install --user -q "$pack"
	done
}

pacman_aur () {
	local packages="$@"
	for aur in "${AUR[@]}"; do
		git clone "https://aur.archlinux.org/""$aur"".git" &&
		( cd $aur && makepkg -sri )
	done
}

ubuntu_install_chrome () {
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
}

install_unimatrix () {
	sudo curl -L https://raw.githubusercontent.com/will8211/unimatrix/master/unimatrix.py -o /usr/local/bin/unimatrix
	sudo chmod a+rx /usr/local/bin/unimatrix
}

while [[ $# -gt 0 ]]; do
	arg="$1"

	case "$arg" in
		Arch|arch)
			sudo pacman -Syu && sudo pacman -S ${ARCH_PACKAGE[*]} &&
			pacman_aur "${AUR[*]}"
		;;
		Ubuntu|ubuntu)
			for ppa in ${PPA[@]}; do
				sudo add-apt-repository -n -y "$ppa"
			done
			UBUNTU_PACKAGE+=("$(check-language-support)")
			sudo apt -qq update && sudo ubuntu-drivers autoinstall &&
			sudo apt -qq -y --ignore-missing install ${UBUNTU_PACKAGE[*]}
		;;
		etc)
			shift
			arg="$1"
			case "$arg" in
				unimatrix)
					install_unimatrix
				;;
				*);;
			esac
		;;
		*)
			exit 1
		;;
	esac
	exit 0
done

