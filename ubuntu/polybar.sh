#!/usr/bin/env bash

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

sudo apt install ${dependencies[@]} &&
	git clone "https://github.com/polybar/polybar" "$workspace" &&
	cd "$workspace/polybar" &&
	mkdir build &&
	cd build &&
	cmake .. &&
	make -j4 &&
	sudo make install
