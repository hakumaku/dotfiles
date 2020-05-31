#!/usr/bin/env bash

install() {
	local fonts=(
		"https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Ubuntu.zip"
	)
	local font_dir="$HOME/.local/share/fonts"
	mkdir -p $font_dir && {
		for font in "${fonts[@]}"; do
			wget -q "$font" -P "$font_dir" && {
			font=${font##*/}
			unzip -qq -d "$font_dir/${font%.zip}" "$font_dir/$font"
			rm "$font_dir/$font"; }
		done
	} && fc-cache -fv
}

install
