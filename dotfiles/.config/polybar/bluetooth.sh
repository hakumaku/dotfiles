#!/usr/bin/env bash
# Determine whether bluetooth is powered on / off.

if [ $(bluetoothctl show | grep "Powered" | awk '{print $2}') == 'yes' ]; then
	echo ""
else
	echo ""
fi
