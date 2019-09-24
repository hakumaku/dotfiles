#!/usr/bin/env bash

install_terminate () {
	local dep=(
		"libgtk-3-dev" "gtk-doc-tools" "gnutls-bin" "valac" "intltool" "libpcre2-dev"
		"libglib3.0-cil-dev" "libgnutls28-dev" "libgirepository1.0-dev"
		"libxml2-utils" "gperf" "libtool" "libtool-bin"
	)
	local url_vte="https://github.com/thestinger/vte-ng.git"
	cal url_termite="https://github.com/thestinger/termite.git"
	local bool=false
	# Install dependencies for Termite
	if ! { sudo apt -qq update && sudo apt install -qq -y "${dep[@]}"; }; then
		exit 1
	fi

	( git clone $url_vte &&
	echo export LIBRARY_PATH="/usr/include/gtk-3.0:$LIBRARY_PATH" &&
	cd vte-ng && ./autogen.sh && make && sudo make install && bool=true )

	if [ "$bool" = false ]; then
		exit 1
	fi

	( git clone --recursive $url_termite && cd termite &&
	make && sudo make install && sudo ldconfig &&
	sudo mkdir -p /lib/terminfo/x &&
	sudo ln -s /usr/local/share/terminfo/x/xterm-termite \
		/lib/terminfo/x/xterm-termite &&
	sudo update-alternatives --install \
		/usr/bin/x-terminal-emulator x-terminal-emulator \
		/usr/local/bin/termite 60 )
}

install_terminate

