#!/usr/bin/env bash

workspace="$HOME/workspace"

dependencies=(
	"libxdamage-dev"
	"libxrandr-dev"
	"libxinerama-dev"
	"libconfig-dev"
	"libdbus-1-dev"
	"libgl-dev"
	"libdrm-dev"
)

sudo apt install ${dependencies[@]} &&
	sudo apt --no-install-recommends install asciidoc &&
	sudo apt install xsltproc &&
	git clone "https://github.com/GabrielTenma/compton-kawase-blur" $workspace &&
	(cd $workspace && make && make docs && sudo make install)
