.PHONY: list aur cargo fcitx fonts cmake clang fzf icons \
	lazygit lazydocker lua \
	mpv numix nvim neovim shfmt sh steam \
	ranger rofi streamlink tmux \
	youtube-dl youtube yt xpadneo xbox zsh

aur:
	@./main.sh aur

cargo:
	@./main.sh cargo

fcitx:
	@./main.sh fcitx

fonts:
	@./main.sh fonts

cmake:
	@./main.sh cmake

clang:
	@./main.sh clang

fzf:
	@./main.sh fzf

icons:
	@./main.sh icons

lazydocker:
	@./main.sh lazydocker

lazygit:
	@./main.sh lazygit

lua:
	@./main.sh lua

mpv:
	@./main.sh mpv

numix:
	@./main.sh numix

nvim neovim:
	@./main.sh nvim

shfmt sh:
	@./main.sh shfmt

steam:
	@./main.sh steam

ranger:
	@./main.sh ranger

rofi:
	@./main.sh rofi

streamlink:
	@./main.sh streamlink

tmux:
	@./main.sh tmux

youtube-dl youtube yt:
	@./main.sh youtube

xpadneo xbox:
	@./main.sh xpadneo

zsh:
	@./main.sh zsh

list:
	@LC_ALL=C $(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'
