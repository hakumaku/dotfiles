.PHONY: aur cargo fcitx fonts cmake clang fzf icons lazygit \
	mpv numix nvim neovim steam ranger rofi streamlink tmux \
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

lazygit:
	@./main.sh lazygit

mpv:
	@./main.sh mpv

numix:
	@./main.sh numix

nvim neovim:
	@./main.sh nvim

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