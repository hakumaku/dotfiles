#!/usr/bin/env bash
url="https://riotgamespatcher-a.akamaihd.net/KR_CBT/installer/deploy/League%20of%20Legends%20installer%20KR.exe"
output="league_installer.exe"

wget -nc https://dl.winehq.org/wine-builds/winehq.key &&
	sudo apt-key add winehq.key
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ disco main'
# libfaudio0
sudo add-apt-repository ppa:cybermax-dexter/sdl2-backport
sudo apt install --install-recommends winehq-devel

sudo snap install leagueoflegends --edge --devmode
sudo snap refresh --candidate wine-platform-runtime
sudo snap refresh --candidate wine-platform-4-staging

wget $url -O /tmp/$output
WINEPREFIX=~/snap/leagueoflegends/common/.wine wine "/tmp/$output"
