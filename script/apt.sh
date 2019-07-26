#!/usr/bin/env bash

PPA=(
	# "ppa:rvm/smplayer"					# smplayer
	"ppa:nilarimogard/webupd8"			# gnome-twitch
	# "ppa:umang/indicator-stickynotes"	# indicator-stickynotes
	"ppa:graphics-drivers"				# nvidia graphics drivers
	"ppa:oguzhaninan/stacer"			# Stacer
)

PACKAGE=(
	"git" "vim" "vim-gnome" "g++" "curl" "ctags"
	"gdebi" "valgrind" "htop" "tmux" "screenfetch" "autogen"
	"automake" "cmake" "snap" "fcitx-hangul" "gufw"
	"cmus" "sxiv" "vlc" "cheese" "transmission" "stacer"
	"gnome-tweak-tool" "gnome-shell-extensions"
	"python3-dev" "python3-pip" "python-apt"
	"w3m-img" "compton" "feh" "moreutils" "plank"
	"ffmpeg" "ffmpegthumbnailer"
	"$(check-language-support)"
	# wine League of Legends
	"winbind"
	# "smplayer" "smtube" "smplayer-themes" "smplayer-skins"
	# "indicator-stickynotes"
	# blueman
	# Laptop power saving utility.
	# "tlp"

	# Steam
	"steam"

	# Suckless Terminal & Dmenu
	"libx11-dev" "libxext-dev" "libxft-dev"
	"libxinerama-dev" "libfreetype6-dev"
	# "libxft2" "libfontconfig1-dev" "libpam0g-dev"
	# "libxrandr2" "libxss1"

	# The following two are associated with NNN. (https://github.com/jarun/nnn)
	# "libncursesw5-dev" "moreutils" "nnn"

	# Google Chrome
	# "google-chrome-stable" "chrome-gnome-shell"

	# Twitch
	# "gnome-twitch"
	# "gnome-twitch-player-backend-gstreamer-cairo"
	# "gnome-twitch-player-backend-gstreamer-clutter"
	# "gnome-twitch-player-backend-gstreamer-opengl"
	# "gnome-twitch-player-backend-mpv-opengl"
)

EXTERNAL_PACKAGE=(
	# "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
	"http://media.steampowered.com/client/installer/steam.deb"
)

# Add repository
for ppa in "${PPA[@]}"; do
	sudo add-apt-repository -n -y "$ppa"
done

# Google Chrome
# wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

sudo apt -qq update && sudo ubuntu-drivers autoinstall &&
sudo apt -qq -y --ignore-missing install ${PACKAGE[*]}

# UniMatrix
sudo curl -L https://raw.githubusercontent.com/will8211/unimatrix/master/unimatrix.py -o /usr/local/bin/unimatrix
sudo chmod a+rx /usr/local/bin/unimatrix

