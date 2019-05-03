#!/usr/bin/env bash

PPA=(
	# "ppa:rvm/smplayer"					# smplayer
	"ppa:nilarimogard/webupd8"			# gnome-twitch
	# "ppa:umang/indicator-stickynotes"	# indicator-stickynotes
	"ppa:graphics-drivers"				# nvidia graphics drivers
)

PACKAGE=(
	"git" "vim" "vim-gnome" "g++" "curl" "ctags"
	"gdebi" "valgrind" "htop" "tmux" "screenfetch" "autogen"
	"automake" "cmake" "snap" "fcitx-hangul" "gufw" "cheese"
	"rhythmbox" "sxiv" "vlc" "cmatrix"
	"chrome-gnome-shell" "gnome-tweak-tool" "gnome-shell-extensions"
	"python3-dev" "python3-pip" "python-apt" "w3m-img"
	# "smplayer" "smtube" "smplayer-themes" "smplayer-skins"
	# "indicator-stickynotes"
	# blueman

	# Suckless Terminal & Dmenu
	# Comment the line in "config.mk" when install Dwm:
	# FREETYPEINC = ${X11INC}/freetype2
	"libx11-dev" "libxext-dev" "libxft-dev"
	"libxinerama-dev" "libfreetype6-dev"
	# "libxft2" "libfontconfig1-dev" "libpam0g-dev"
	# "libxrandr2" "libxss1"

	# For thumbnails
	"ffmpeg" "ffmpegthumbnailer"

	# Laptop power saving utility.
	# "tlp"
	# The following two are associated with NNN. (https://github.com/jarun/nnn)
	# "libncursesw5-dev" "moreutils" "nnn"

	# Steam
	"steam"

	# Google Chrome
	"google-chrome-stable"

	# Twitch
	"gnome-twitch"
	"gnome-twitch-player-backend-gstreamer-cairo"
	"gnome-twitch-player-backend-gstreamer-clutter"
	"gnome-twitch-player-backend-gstreamer-opengl"
	"gnome-twitch-player-backend-mpv-opengl"
	"$(check-language-support)"
)

EXTERNAL_PACKAGE=(
	"https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
	"http://media.steampowered.com/client/installer/steam.deb"
)

# Add repository
for ppa in "${PPA[@]}"; do
	sudo add-apt-repository -n -y "$ppa"
done
# Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt -qq update && sudo ubuntu-drivers autoinstall &&
sudo apt -qq -y --ignore-missing install ${PACKAGE[*]}

