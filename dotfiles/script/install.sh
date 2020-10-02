#!/usr/bin/env bash
OS=$( cat /etc/os-release | sed -n 's/^NAME=//p' )
OS=${OS,,}
declare -A DIR=(
	["source"]="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"
	["home"]="$( git rev-parse --show-toplevel )"
	["parent"]="${DIR[home]}/.."
	["dot"]="${DIR[home]}/dotfiles"
	["config"]="$HOME/.config"
)
# {{{ dotfiles
declare -A DOTFILES=(
	# (remote, local) pair
	["vlc"]="${DIR[config]}/vlc/vlcrc,${DIR[dot]}/vlc/vlcrc"
	["vim"]="$HOME/.vimrc,${DIR[dot]}/vim/.vimrc"
	["st"]="${DIR[parent]}/st/config.h,${DIR[dot]}/st/config.h"
	# ["dmenu"]="${DIR[parent]}/dmenu/config.h,${DIR[dot]}/dmenu/config.h"
	["powerline"]="${DIR[config]}/powerline/config.json,`
		`${DIR[dot]}/powerline/config.json"
	["tmux"]="$HOME/.tmux.conf,${DIR[dot]}/tmux/.tmux.conf"
	["ranger"]="${DIR[config]}/ranger/rc.conf,${DIR[dot]}/ranger/rc.conf"
	["awesome"]="${DIR[config]}/awesome,${DIR[dot]}/awesome"
	["rofi"]="${DIR[config]}/rofi,${DIR[dot]}/rofi"
	["i3"]="${DIR[config]}/i3,${DIR[dot]}/i3"
	["bspwm"]="${DIR[config]}/bspwm,${DIR[dot]}/bspwm"
	["sxhkd"]="${DIR[config]}/sxhkd,${DIR[dot]}/sxhkd"
	["polybar"]="${DIR[config]}/polybar,${DIR[dot]}/polybar"
	["compton"]="${DIR[config]}/compton.conf,${DIR[dot]}/compton/compton.conf"
	["xinit"]="$HOME/.xprofile,${DIR[dot]}/xprofile"
	["zsh"]="$HOME/.zshrc,${DIR[dot]}/zsh/.zshrc"
	["p10k"]="$HOME/.p10k.zsh,${DIR[dot]}/zsh/.p10k.zsh"
)
# }}}

# {{{ Arch Packages
AUR=(
	"ttf-d2coding" "ttf-unfonts-core-ibx"
	# "stacer"
	"snapd" "gotop"
	"humanity-icon-theme" "yaru"
)
ARCH_PACKAGE=(
	"xorg" "base-devel" "linux-firmware"
	"libva" "libva-vdpau-driver" "libva-utils"
	"gdm" "gnome" "gnome-tweaks"
	"networkmanager" "bluez" "bluez-utils" "mesa-demos"
	"alsa-utils" "pavucontrol" "udisks2"
	"alacritty" "zsh" "diff-so-fancy" "bat" "ripgrep" "exa" "fd" "xclip"
	"man-pages"
	"bash-completion" "tmux" "rofi" "plank" "htop" "neofetch" "wget" "curl"
	"clang" "gdb" "valgrind" "git" "gvim" "autogen" "ctags" "automake" "cmake"
	"tar" "unzip" "dnsutils" "moreutils" "python-pip"
	"xss-lock" "cmus" "sxiv" "exiv2" "imagemagick"
	"feh" "xautolock" "compton" "ffmpeg" "ffmpegthumbnailer" "w3m"
	"network-manager-applet" "blueman" "redshift" "cbatticon"
	"fcitx-im" "fcitx-hangul" "fcitx-configtool"
	"adobe-source-han-sans-kr-fonts" "ttf-dejavu"
	"transmission-gtk" "transmission-cli" "transmission-remote-gtk"
	"xpad" "vlc" "cheese" "nautilus" "firefox" "gufw" "lxappearance"
	"inetutils" # suru++ requires 'hostname' command.
)
install_arch_package () {
	local dir=""
	# is it Intel cpu?
	local cpu=$( lscpu | grep "Model name" | awk '{print $3}' )
	if [[ "$cpu" = "Intel"* ]]; then
		ARCH_PACKAGE+=("libva-intel-driver" "intel-media-driver")
	else
		echo "AMD cpu"
	fi

	if sudo pacman -Syu && sudo pacman -Sq --noconfirm ${ARCH_PACKAGE[*]}; then
		for aur in "${AUR[@]}"; do
			dir="${DIR[parent]}/$aur"
			git clone "https://aur.archlinux.org/""$aur"".git" "$dir" &&
				( cd "$dir" && makepkg -sri --noconfirm )
		done
	else
		echo "Cannot execute 'pacman'."
		echo "Check the names of arch packages."
		exit 1
	fi


	# Genereate locale
	local conf="/etc/locale.gen"
	sudo sed -Ei "s/^#(en_US.UTF-8)/\1/" "$conf" &&
		sudo sed -Ei "s/^#(ko_KR.UTF-8)/\1/" "$conf" && sudo locale-gen
	# Enable color in pacman
	conf="/etc/pacman.conf"
	sudo sed -i 's/^#Color$/Color/' "$conf"

	sudo systemctl enable bluetooth
	sudo systemctl enable NetworkManager
	sudo systemctl enable gdm
	sudo systemctl enable --now snapd.socket
	sudo echo "static domain_name_servers=1.1.1.1 1.0.0.1" >> "/etc/dhcpcd.conf"
}
install_optimus () {
	local optimus=(
		"optimus-manager" "optimus-manager-qt"
	)
	for aur in "${optimus[@]}"; do
		local dir="${DIR[parent]}/$aur"
		git clone "https://aur.archlinux.org/""$aur"".git" "$dir" &&
			( cd "$dir" && makepkg -sri --noconfirm )
	done
	sudo pacman -Sq --noconfirm "bbswitch"
}
install_wine () {
	local optional_deps=(
		"wine-mono" "wine_gecko" "winetricks"
		"lib32-opencl-icd-loader" "opencl-icd-loader"
		"lib32-libxslt" "lib32-libva" "lib32-sdl2"
		"lib32-giflib" "lib32-mpg123" "lib32-openal"
		"lib32-v4l-utils" "lib32-libpulse"
		"lib32-gtk3" "lib32-gst-plugins-base-libs" "lib32-vulkan-icd-loader"
		"vkd3d" "lib32-vkd3d" "vulkan-intel" "lib32-vulkan-intel"
	)
	sudo pacman -Sq --noconfirm wine-staging "${optional_deps[@]}"
}
install_steam () {
	# Enable multilib
	local conf="/etc/pacman.conf"
	local pack=(
		"nvidia" "nvidia-utils" "lib32-nvidia-utils" "ttf-liberation" "steam"
	)
	sudo sed -Ei "/^#\[multilib\]/,/^#Include/ s/#(.*)/\1/" "$conf" &&
		sudo pacman -Syy && sudo pacman -Sq --noconfirm "${pack[@]}"
}
# }}}
# {{{ Arch linux config
config_mntpt () {
	# By default, udisks2 mounts removable drives under
	# the ACL controlled directory /run/media/$USER/.
	# If you wish to mount to /media instead, use this rule:
	local rule="/etc/udev/rules.d/99-udisks2.rules"
	local conf="/etc/tmpfiles.d/media.conf"
	if [[ ! -d $( dirname "$rule" ) ]]; then
		return 1
	fi

	sudo bash -c "cat > $rule" <<-END
	# UDISKS_FILESYSTEM_SHARED
	# ==1: mount filesystem to a shared directory (/media/VolumeName)
	# ==0: mount filesystem to a private directory (/run/media/$USER/VolumeName)
	# See udisks(8)
	ENV{ID_FS_USAGE}=="filesystem|other|crypto", ENV{UDISKS_FILESYSTEM_SHARED}="1"
	END

	if [[ ! -d $( dirname "$conf" ) ]]; then
		return 1
	fi

	sudo bash -c "cat > $conf" <<- END
	D /media 0755 root root 0 -
	END
}

config_bluetooth () {
	sudo rfkill block bluetooth
	local profiles="/var/lib/bluetooth/"
	if [[ ! -z $( sudo ls $profiles ) ]]; then
		sudo rm -rf "$profiles"/*
	fi
	sudo echo 0 > /sys/kernel/debug/bluetooth/hci0/conn_latency
	sudo echo 6 > /sys/kernel/debug/bluetooth/hci0/conn_min_interval
	sudo echo 7 > /sys/kernel/debug/bluetooth/hci0/conn_max_interval
	sudo rfkill unblock bluetooth
}

config_grub () {
	local fontpath="/usr/share/fonts/TTF/DejaVuSansMono.ttf"
	local font=${fontpath##*/}
	local size=20
	local grub_font="/boot/grub/fonts/${font%.*}$size.pf2"
	local file="/etc/default/grub"
	local custom="/etc/grub.d/40_custom"

	sudo bash -c "cat >> $custom" <<- END
	menuentry "System shutdown" {
		echo "System shutting down..."
		halt
	}
	if [ ${grub_platform} == "efi" ]; then
		menuentry "Firmware setup" {
			fwsetup
		}
	fi
	END

	sudo grub-mkfont --output="$grub_font" --size="$size" "$fontpath"
	sudo sed -i '/#GRUB_THEME/a '"GRUB_FONT=\"$grub_font\"" $file
	sudo grub-mkconfig -o /boot/grub/grub.cfg
}
# }}}

# {{{ Ubuntu Packages
PPA=(
	# "ppa:nilarimogard/webupd8"			# gnome-twitch
	"ppa:graphics-drivers"				# nvidia graphics drivers
	"ppa:oguzhaninan/stacer"			# Stacer
)
UBUNTU_PACKAGE=(
	"git" "vim" "vim-gnome" "g++" "curl" "ctags"
	"valgrind" "htop" "tmux" "screenfetch" "autogen" "most"
	"automake" "cmake" "snap" "fcitx-hangul" "gufw"
	"cmus" "sxiv" "exiv2" "imagemagick" "ffmpeg" "ffmpegthumbnailer"
	"gnome-tweak-tool" "gnome-shell-extensions"
	"python3-dev" "python3-pip" "python-apt"
	"w3m-img" "compton" "feh" "moreutils" "rofi" "lxappearance"
	"vlc" "cheese" "transmission" "transmission-cli" "stacer"
	"steam" "steam-devices"
	"winbind"						# wine League of Legends

	# Suckless Terminal & Dmenu
	"libx11-dev" "libxext-dev" "libxft-dev"
	# "libfreetype6-dev"
	# "libxft2" "libfontconfig1-dev" "libpam0g-dev"
	# "libxrandr2" "libxss1"
	# Dwm
	"libxinerama-dev"

	# Google Chrome
	# "google-chrome-stable" "chrome-gnome-shell"

	# Twitch
	# "gnome-twitch"
	# "gnome-twitch-player-backend-gstreamer-cairo"
	# "gnome-twitch-player-backend-gstreamer-clutter"
	# "gnome-twitch-player-backend-gstreamer-opengl"
	# "gnome-twitch-player-backend-mpv-opengl"
)
install_ubuntu_package () {
	for ppa in ${PPA[@]}; do
		sudo add-apt-repository -n -y "$ppa"
	done
	UBUNTU_PACKAGE+=("$(check-language-support)")
	sudo apt -qq update && sudo ubuntu-drivers autoinstall &&
		sudo apt -qq -y --ignore-missing install ${UBUNTU_PACKAGE[*]}

}
# }}}

sync_dotfile () {
	IFS=','
	local arg=($1)
	unset IFS

	local machine="${arg[0]}"		# desktop dotfile
	local remote="${arg[1]}"		# github dotfile
	local filename="$(dirname "$machine")"
	filename="${filename##*/}/$(basename -- "$machine")"
	local dir=""

	# Copy a single file.
	if [ -f "$remote" ]; then
		# if empty then copy
		if [ ! -f "$machine" ]; then
			dir="${machine%/*}"
			mkdir -p $dir &&
				cp "$remote" "$machine"
			return 0
		fi
		# Synch
		if ! cmp -s "$machine" "$remote"; then
			cp "$machine" "$remote"
			printf "\e[4m* $filename\e[24m\n"
		else
			printf "  $filename\e[24m\n"
		fi

	# Copy multiple files in the directory.
	elif [ -d "$remote" ]; then
		# if empty then copy
		if [ ! -d "$machine" ]; then
			dir="$machine"
			cp -r "$remote" "$machine"
			return 0
		fi
		# Synch
		# Note that it does not handle if either the directory to the file or
		# the file contains white spaces.
		local type=""
		local file=""
		echo "  $(basename $machine)/"
		while read line; do
			type="${line: -1}"
			case "$type" in
				# identica'l'
				"l")
					file=$( sed -nE "s/Files (.*) and .*/\1/p" <<< "$line" )
					printf "\t  \"${file##*/}\"\n"
				;;
				# diffe'r': copy $machine to $remote
				"r")
					file=$( sed -nE "s/Files (.*) and .*/\1/p" <<< "$line" )
					file="${file##*/}"
					printf "\t* \e[4m\"$file\"\e[24m\n"
					cp "$machine/$file" "$remote"
				;;
				# Only in ...: ...
				# copy $machine to $remote
				# remove $remote
				*)
					file=$( sed -E "s/^(.*): //" <<< "$line" )
					if [ -f "$machine/$file" ]; then
						printf "\t\e[32m+ \"$file\"\e[39m\n"
						cp "$machine/$file" "$remote"
					elif [ -f "$remote/$file" ]; then
						printf "\t\e[31m- \"$file\"\e[39m\n"
						rm "$remote/$file"
					else
						exit 1
					fi
				;;
			esac
		done <<< "$( diff -rsq "$remote" "$machine" )"
		return 0

	else
		return 1
	fi
}

# {{{ Install Suckless Software
install_suckless () {
	# $1: install directory
	# $2: remote config.h
	# $3: url
	# $4: package
	local dir="$1"
	local config="$2"
	local url="$3"
	local package="$4"

	mkdir -p "$dir" &&
	wget -q "$url$package" -P "$dir" &&
	tar xf "$dir/$package" -C "$dir" --strip-components=1 &&
	cp $config $dir &&
	(cd "$dir" && make && sudo make install && make clean)
}

install_st_terminal () {
	IFS=','
	local arg=(${DOTFILES[st]})
	unset IFS
	local dir="${arg[0]/config.h}"
	local config="${arg[1]}"
	local url="https://dl.suckless.org/st/"
	local package="$(wget -q "$url" -O - | grep -o "st-\([0-9].\)*tar.gz" |
		sort -V | tail -1)"
	if [ -z "$package" ]; then
		echo "Cannot parse the link."
		return
	fi

	install_suckless "$dir" "$config" "$url" "$package" &&
	if [[ ! -d "$HOME/.local/share/applications" ]]; then
		mkdir -p "$HOME/.local/share/applications"
	fi
	cp "${DIR[dot]}/st/st.desktop" "$HOME/.local/share/applications"
}

install_dmenu () {
	IFS=','
	local arg=(${DOTFILES[dmenu]})
	unset IFS
	local dir="${arg[0]/config.h}"
	local config="${arg[1]}"
	local url="https://dl.suckless.org/tools/"
	local package="$(wget -q "$url" -O - | grep -o "dmenu-\([0-9].\)*tar.gz" |
		sort -V | tail -1)"
	if [ -z "$package" ]; then
		echo "Cannot parse the link."
		return
	fi

	install_suckless "$dir" "$config" "$url" "$package"
}
# }}}

# {{{ Youtubedl
install_youtubedl () {
	local url="https://yt-dl.org/downloads/latest/youtube-dl"
	sudo wget "$url" -O /usr/local/bin/youtube-dl
	sudo chmod a+rx /usr/local/bin/youtube-dl
}
# }}}

# {{{ Unimatrix
install_unimatrix () {
	local url="https://raw.githubusercontent.com/will8211/`
		`unimatrix/master/unimatrix.py"
	sudo curl -L "$url" -o /usr/local/bin/unimatrix
	sudo chmod a+rx /usr/local/bin/unimatrix
}
# }}}

# {{{ Vim Vundle
install_vundle () {
	local ycmpy = "$HOME/.vim/bundle/YouCompleteMe/install.py"
	local url="https://github.com/VundleVim/Vundle.vim.git"
	git clone -q "$url" ~/.vim/bundle/Vundle.vim &&
		sync_dotfile "${DOTFILES[vim]}" && vim +PluginInstall +qall &&
		python3 "$ycmpy" --all &&
		python3 "$ycmpy" --clang-completer --system-libclang
}
# }}}

# {{{ Tmux Theme
install_tmux_theme () {
	local url="https://github.com/jimeh/tmux-themepack.git"
	git clone -q "$url" ~/.tmux-themepack
}
# }}}

# {{{ Suru++
install_suru () {
	local url="https://raw.githubusercontent.com/gusbemacbe/suru-plus/master/install.sh"
	{ wget -qO- $url | sh; } && { wget -qO- https://git.io/fhQdI | sh; } &&
		suru-plus-folders -C orange --theme Suru++
}
# }}}

# {{{ i3-gaps
install_i3gaps () {
	if [[ $OS == *"ubuntu"* ]]; then
		local dep=(
			"libxcb1-dev" "libxcb-keysyms1-dev" "libpango1.0-dev"
			"libxcb-util0-dev" "libxcb-icccm4-dev" "libyajl-dev"
			"libstartup-notification0-dev" "libxcb-randr0-dev" "libev-dev"
			"libxcb-cursor-dev" "libxcb-xinerama0-dev" "libxcb-xkb-dev"
			"libxkbcommon-dev" "libxkbcommon-x11-dev" "autoconf"
			"libxcb-xrm0" "libxcb-xrm-dev" "automake" "libxcb-shape0-dev"
		)

	cd /tmp && git clone https://www.github.com/Airblader/i3 i3-gaps &&
		cd i3-gaps && autoreconf --force --install && rm -rf build/ &&
		mkdir -p build && cd build/ &&
		../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers &&
		make && sudo make install
	elif [[ $OS == *"arch"* ]]; then
		sudo pacman -Sy i3-gaps
	else
		return 1
	fi
}
# }}}

# {{{ bspwm
install_bspwm () {
	local dep=()
	if [[ $OS == *"ubuntu"* ]]; then
		dep=(
			"libxcb-xinerama0-dev" "libxcb-icccm4-dev" "libxcb-randr0-dev"
			"libxcb-util0-dev" "libxcb-ewmh-dev" "libxcb-keysyms1-dev"
			"libxcb-shape0-dev"
		)
		sudo apt install -qq -y ${dep[@]}
	elif [[ $OS == *"arch"* ]]; then
		dep=(
			"libxcb" "xcb-util" "xcb-util-wm" "xcb-util-keysyms"
		)
		sudo pacman -S ${dep[@]}
	else
		return 1
	fi
	IFS=','
	local bspwm_config=(${DOTFILES[bspwm]})
	local sxhkd_config=(${DOTFILES[sxhkd]})
	unset IFS

	( cd ${DIR[parent]} &&
		git clone https://github.com/baskerville/bspwm.git &&
		git clone https://github.com/baskerville/sxhkd.git &&
		cd bspwm && make && sudo make install &&
		cd ../sxhkd && make && sudo make install &&
		mkdir -p ~/.config/{bspwm,sxhkd} &&
		cp "${bspwm_config[1]}"  "${bspwm_config[0]}" &&
		cp "${sxhkd_config[1]}" "${sxhkd_config[0]}" )
}
# }}}

# {{{ Polybar
install_polybar () {
	if [[ $OS == *"arch"* ]]; then
		local polybargit="https://aur.archlinux.org/polybar.git"
		local dir="${DIR[parent]}/polybar"
		git clone "$polybargit" "$dir" &&
			( cd "$dir" && makepkg -sri --noconfirm )

	elif [[ $OS == *"ubuntu"* ]]; then
		local url="https://github.com/jaagr/polybar.git"
		local dep=(
			"cmake" "cmake-data" "libcairo2-dev" "libxcb1-dev" "libxcb-ewmh-dev"
			"libxcb-icccm4-dev" "libxcb-image0-dev" "libxcb-randr0-dev"
			"libxcb-util0-dev" "libxcb-xkb-dev" "pkg-config" "python-xcbgen"
			"xcb-proto" "libxcb-xrm-dev" "libasound2-dev" "libmpdclient-dev"
			"libiw-dev" "libcurl4-openssl-dev" "libpulse-dev"
			"libxcb-composite0-dev" "xcb" "libxcb-ewmh2" "libanyevent-i3-perl"
			"libanyevent-perl" "libasync-interrupt-perl" "libcommon-sense-perl"
			"libev-perl" "libguard-perl" "libjson-xs-perl"
			"libtypes-serialiser-perl" "libjson-glib-dev"
		)
		sudo apt -qq -y install ${dep[*]} &&
			git clone -q "$url" "${DIR[parent]}/polybar" &&
			( cd "${DIR[parent]}/polybar" && ./build.sh )
	else
		exit 1
	fi
}
# }}}

# {{{ Lemonbar
install_lemonbar () {
	local dir="${DIR[parent]}""/lemonbar"
	local url="https://github.com/LemonBoy/bar.git"
	git clone "$url" "$dir" &&
		( cd "$dir" && make && sudo make install )
}
# }}}

# {{{ Nerd Font
install_nerdfont () {
	local fonts=(
		"https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/SourceCodePro.zip"
		"https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/Inconsolata.zip"
		"https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/UbuntuMono.zip"
		"https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/Mononoki.zip"
		"https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/AnonymousPro.zip"
	)
	local font_dir="$HOME/.local/share/fonts"
	mkdir -p $font_dir && {
	for font in "${fonts[@]}"; do
		wget -q "$font" -P "$font_dir" && {
		font=${font##*/}
		unzip -qq -d "$font_dir/${font%.zip}" "$font_dir/$font"
		rm "$font_dir/$font"
		}
	done
	} && fc-cache -fv
}
# }}}

# {{{ Ranger Devicons
install_ranger_devicons () {
	local url="https://github.com/alexanderjeurissen/ranger_devicons"
	git clone -q "$url" "${DIR[parent]}/ranger_devicons" &&
		(cd "${DIR[parent]}/ranger_devicons" && make install)
}
# }}}

# {{{ Pip
install_pip () {
	local packages=(
		"virtualenv"
		"ranger-fm"
		"ueberzug"
	)
	for pack in ${packages[@]}; do
		pip3 install --user "$pack"
	done

	PATH=$PATH:"$HOME/.local/bin"
}
# }}}

# {{{ ranger config
config_ranger () {
	if [[ ! $(command -v ranger) ]]; then
		return 1
	fi
	ranger --copy-config=all

	# Enable video preview option.
	local config="$HOME/.config/ranger/scope.sh"
	if [[ -f "$config" ]]; then
		sed -in '/video\/\*)/,/exit 1;;/s/# //' $config
	fi

	# Enable sxiv -a option.
	config="$HOME/.config/ranger/rifle.conf"
	if [[ -f "$config" ]]; then
		sed -in 's/flag f = sxiv/& -a/' $config
	fi

	# Copy rc.conf to the local directory.
	IFS=','
	local config=(${DOTFILES[ranger]})
	unset IFS
	cp "${config[1]}" "${config[0]}"
}
# }}}

# {{{ sxiv config
config_sxiv () {
	# Use sxiv as a default application.
	local rifle="/usr/local/bin"
	local desktop="/usr/share/applications/sxiv.desktop"
	sudo cp "${DIR[dot]}/sxiv/sxiv-rifle" "$rifle"
	sudo sed -i 's/\(Exec=sxiv\).*$/\1-rifle/' "$desktop"
	xdg-mime default sxiv.desktop image/jpeg

	# image-info
	mkdir -p ~/.config/sxiv/exec
	cp "${DIR[dot]}/sxiv/exec/image-info" "$HOME/.config/sxiv/exec/"
}
# }}}

# {{{ fcitx config
fcitx_config () {
	if [[ ! -d "$HOME/.config/fcitx" ]]; then
		( exec fcitx -d & )
	fi

	local profile="$HOME/.config/fcitx/profile"
	local config="$HOME/.config/fcitx/config"
	sed -Ei "s/#(IMName=)/\1Hangul/" "$profile"
	sed -Ei "s/(hangul:)False/\1True/" "$profile"
	sed -Ei "s/#(TriggerKey=).*/\1HANGUL/" "$config"
	sed -Ei "s/#(SwitchKey=).*/\1Disabled/" "$config"
	sed -Ei "s/#(IMSwitchKey=).*/\1False/" "$config"
	if [[ $OS = *"arch"* ]]; then
		cat >> $HOME/.pam_environment <<- END
			GTK_IM_MODULE=fcitx
			QT_IM_MODULE=fcitx
			XMODIFIERS=@im=fcitx
		END
	elif [[ $OS = *"ubuntu"* ]]; then
		im-config -n fcitx
	else
		return 0
	fi
}
# }}}

# {{{ zsh config
config_zsh () {
	# powerlevel10k
	local url="https://github.com/romkatv/powerlevel10k.git"
	git clone --depth=1 "$url" "${DIR[parent]}/powerlevel10k"

	# zsh-syntax-highlighting
	url="https://github.com/zsh-users/zsh-syntax-highlighting.git"
	git clone "$url" "${DIR[parent]}/zsh-syntax-highlighting"

	# zsh-dircolors-solarized
	url="https://github.com/joel-porquet/zsh-dircolors-solarized"
	git clone --recursive "$url" "${DIR[parent]}/zsh-dircolors-solarized"
}
# }}}

disable_gnome_software () {
	if [[ $OS != *"ubuntu"* ]]; then
		return 1
	fi
	local src="/etc/xdg/autostart/gnome-software-service.desktop"
	local dest="$HOME/.config/autostart/""$(basename -- $src)"
	if [ ! -f $src ]; then
		return
	fi
	mkdir -p "$HOME/.config/autostart" && cp "$src" "$dest" &&
	echo "X-GNOME-Autostart-enabled=false" >> $dest
}

package_install () {
	while [[ $# -gt 0 ]]; do
		arg="${1,,}"
		case "$arg" in
			default)
				local default_packages=(
					"${OS}" "pip" "nerdfont" "st" "vundle"
					"tmux_theme" "ranger_devicons" "suru"
					"youtubedl" "unimatrix" "sxiv" "git" "config" "sync"
				)
				set "${default_packages[@]}"
				continue
			;;
			*"arch"*)
				echo "########################"
				echo "Installing Arch pacakges"
				echo "########################"
				install_arch_package
				if [[ $( lspci | grep "NVIDIA" ) ]]; then
					install_optimus
					install_steam
					install_wine
				fi
			;;
			*"ubuntu"*)
				install_ubuntu_package
				config_ranger
			;;
			# The rest must be called after
			pip)
				echo "########################"
				echo "Installing Pip packages"
				echo "########################"
				install_pip
			;;
			st|st_terminal)
				echo "##########################"
				echo "Installing Simple Termianl"
				echo "##########################"
				install_st_terminal
			;;
			nerdfont|nerd|font)
				echo "#############################"
				echo "Installing Nerdfonts"
				echo "It will take a bit long time."
				echo "#############################"
				install_nerdfont
			;;
			vundle|vim)
				echo "###############################"
				echo "Installing Vundle & Vim Plugins"
				echo "###############################"
				install_vundle
			;;
			tmux_theme|tmux)
				echo "#####################"
				echo "Installing Tmux theme"
				echo "#####################"
				install_tmux_theme
			;;
			ranger_devicons)
				echo "##########################"
				echo "Installing Ranger Devicons"
				echo "##########################"
				install_ranger_devicons
			;;
			suru)
				echo "#######################"
				echo "Installing Suru++ icons"
				echo "#######################"
				install_suru
			;;
			youtubedl|youtube) install_youtubedl ;;
			polybar) install_polybar ;;
			lemonbar) install_lemonbar ;;
			i3-gaps) install_i3gaps ;;
			bspwm) install_bspwm ;;
			unimatrix) install_unimatrix ;;
			dmenu) install_dmenu ;;
			fcitx) fcitx_config ;;
			git)
				git config --global user.email "gentlebuuny@gmail.com"
				git config --global user.name "hakumaku"
				git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
			;;
			sxiv) config_sxiv ;;
			sync)
				for i in "${!DOTFILES[@]}"; do
					sync_dotfile "${DOTFILES[$i]}"
				done
			;;
			config)
				config_zsh
				config_mntpt
				# config_bluetooth
				config_grub
				config_ranger
			;;
			*)
				echo "Unknown arguments: $arg"
				echo "$@"
				exit 1
			;;
		esac
		shift
	done
}

package_install "$@"

