#!/usr/bin/env bash

sudo apt install "python3" "python-is-python3" &&
	sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl &&
	sudo chmod a+rx /usr/local/bin/youtube-dl
