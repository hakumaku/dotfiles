#!/usr/bin/env bash
# nodes=($( bspc query -N -n .window.fullscreen ))
if bspc query -N -n .window.fullscreen; then
	xset s reset
	exit 0
else
	id=$( bspc query -D -d )
	font="SauceCodePro Nerd Font Mono:style=Bold:pixelsize=26:antialias=true:autohint=true"
	( unclutter --timeout 0 & ) &&
	st -c "unimatrix" -f "$font"  -e unimatrix -a -s 96 -c cyan &&
		( bspc desktop -f $id; pkill unclutter )
fi
