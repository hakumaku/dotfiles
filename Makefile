.PHONY: list aur cargo fcitx fonts cmake clang \
	firefox fzf icons \
	lazygit lazydocker k9s kitty lua \
	mpv numix nvim shfmt steam \
	ranger rofi streamlink tmux \
	youtube xbox zsh

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

firefox:
	@./main.sh firefox

fzf:
	@./main.sh fzf

icons:
	@./main.sh icons

k9s:
	@./main.sh k9s

kitty:
	@./main.sh kitty

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

nvim:
	@./main.sh nvim

shfmt:
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

youtube:
	@./main.sh youtube

xbox:
	@./main.sh xpadneo

zsh:
	@./main.sh zsh

list:
	@LC_ALL=C $(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | grep -E -v -e '^[^[:alnum:]]' -e '^$@$$'
