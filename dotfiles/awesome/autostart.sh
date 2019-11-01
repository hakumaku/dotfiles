#!/usr/bin/env bash
export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
PATH=$PATH:"$HOME/.local/bin"

function run {
	if ! pgrep -f $1; then
		$@&
	fi
}

run xrandr --setprovideroutputsource modesetting NVIDIA-0
run xrandr --auto
run fcitx -d
run setxkbmap -layout us -option ctrl:nocaps -option korean:ralt_rctrl
run xset s on
run xset s 300
run xss-lock $HOME/workspace/ubuntu-fresh/unimatrix.sh
run compton
run plank
run $HOME/.fehbg

