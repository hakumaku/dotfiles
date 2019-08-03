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

while [[ $# -gt 0 ]]; do
	arg="$1"

	case "$arg" in
		-i|--increase)
			sum=$( printf "%.0f" $( echo "$brightness + $stride" | bc -l ) )
			shift
		;;
		-d|--decrease)
			sum=$( printf "%.0f" $( echo "$brightness - $stride" | bc -l ) )
			shift
		;;
		-g|--get)
			echo "Current brightness: $brightness / $max_brightness"
			exit 0
		;;
		-r|--rule)
			sudo bash -c 'cat << EOF > /etc/udev/rules.d/90-backlight.rules
			ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"
			ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"
			ACTION=="add", SUBSYSTEM=="leds", RUN+="/bin/chgrp video /sys/class/leds/%k/brightness"
			ACTION=="add", SUBSYSTEM=="leds", RUN+="/bin/chmod g+w /sys/class/leds/%k/brightness"
			EOF'
			exit 0;
		;;
		*)
		shift
		;;
	esac

	sum=$(( sum<0 ? 0 : sum ))
	sum=$(( sum>max_brightness ? max_brightness : sum ))
	echo $sum > $path
done

