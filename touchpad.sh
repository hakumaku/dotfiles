#!/usr/bin/env bash

# xinput
touchpad=$(xinput | sed -nE "s/^.*Touchpad\s*id=([0-9]*).*/\1/p" )
state=$(xinput list-props $touchpad | sed -nE "s/^.*Device Enabled.*([0-9])/\1/p")

if [ $state == 1 ]; then
	xinput --disable $touchpad
else
	xinput --enable $touchpad
fi

