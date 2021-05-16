#!/usr/bin/env bash

workspace="$HOME/workspace"

install_xow() {
	local output="${workspace}/xow"
	if [ ! -d "$output" ]; then
		local dependencies=("cabextract" "libusb-1.0-0-dev")
		sudo apt install ${dependencies[@]} &&
			git clone https://github.com/medusalix/xow "$workspace/xow"
	fi
	(cd $output && make BUILD=RELEASE -j8 && sudo make install) &&
		sudo systemctl enable xow &&
		sudo systemctl start xow
}

install_xow
