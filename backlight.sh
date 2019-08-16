#!/usr/bin/env bash

# If it does not work, please check rules in udev path:
#	/usr/lib/udev/rules.d/90-backlight.rules
#	/etc/udev/rules.d/90-backlight.rules
# ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"
# ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"
# ACTION=="add", SUBSYSTEM=="leds", RUN+="/bin/chgrp video /sys/class/leds/%k/brightness"
# ACTION=="add", SUBSYSTEM=="leds", RUN+="/bin/chmod g+w /sys/class/leds/%k/brightness"
# Also, you need to check whether you are in 'video' group.
# $ groups yourname
# If you are not in, run the command
# $ sudo usermod -a -G video yourname

video="intel_backlight"
path="/sys/class/backlight/$video/brightness"
max_brightness=$( cat "/sys/class/backlight/$video/max_brightness" )
brightness=$( cat $path )
current_value=$( printf "%.2f" $( echo "$brightness / $max_brightness" | bc -l ) )

division=20
stride=$( printf "%.2f" $( echo "$max_brightness / $division" | bc -l ) )

if [[ $# -gt 0 ]]; then
	arg="$1"

	case "$arg" in
		-i|--increase)
			sum=$( printf "%.0f" $( echo "$brightness + $stride" | bc -l ) )
		;;
		-d|--decrease)
			sum=$( printf "%.0f" $( echo "$brightness - $stride" | bc -l ) )
		;;
		-g|--get)
			printf "%.0f%%" $( echo "$current_value * 100" | bc -l )
			exit 0;
		;;
		-r|--rule)
			sudo tee "/etc/udev/rules.d/90-backlight.rules" <<- END
			ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"
			ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"
			ACTION=="add", SUBSYSTEM=="leds", RUN+="/bin/chgrp video /sys/class/leds/%k/brightness"
			ACTION=="add", SUBSYSTEM=="leds", RUN+="/bin/chmod g+w /sys/class/leds/%k/brightness"
			END
			exit 0;
		;;
		*)
			exit 0;
		;;
	esac

	sum=$(( sum<0 ? 0 : sum ))
	sum=$(( sum>max_brightness ? max_brightness : sum ))
	echo $sum > $path
fi

