.PHONY: list aur cargo fcitx fonts clang \
	firefox fzf icons kitty lua \
	numix nvim xbox zsh

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

firefox:
	@./main.sh firefox

fzf:
	@./main.sh fzf

icons:
	@./main.sh icons

kitty:
	@./main.sh kitty

lua:
	@./main.sh lua

numix:
	@./main.sh numix

nvim:
	@./main.sh nvim

xbox:
	@./main.sh xpadneo

zsh:
	@./main.sh zsh

list:
	@LC_ALL=C $(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | grep -E -v -e '^[^[:alnum:]]' -e '^$@$$'
