#!/usr/bin/env bash

install_meslo() {
  local fonts=(
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
  )
  local font_dir="$HOME/.local/share/fonts/MesloLGS"
  mkdir -p $font_dir
  for font in "${fonts[@]}"; do
    wget -q "$font" -P "$font_dir"
  done
  fc-cache -fv
}

install_fonts() {
  local fonts=(
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Ubuntu.zip"
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip"
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

install_fonts
install_meslo
