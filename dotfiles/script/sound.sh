#!/usr/bin/env bash

find_index () {
	local -n target="$1"
	local -n list="$2"
	local i=0
	for elem in "${list[@]}"; do
		if [ "$elem" == "$target" ]; then
			echo "$i"
			return
		fi
		let "i+=1"
	done
	echo "-1"
}

change_sink () {
	local info="$1"
	local sink_list=($(pactl list short sinks | awk '{print $2}'))
	local current_sink=$(echo "$info" | sed -n "s/Default Sink: //p")
	local current_index=$( find_index current_sink sink_list )
	local next_index=$(($current_index+1 == ${#sink_list[@]} ? 0 : $current_index+1 ))
	pactl set-default-sink "${sink_list[$next_index]}"
	local inputs=$( pactl list short sink-inputs | awk '{print $1}' )
	for i in ${inputs[@]}; do
		pacmd move-sink-input $i "${sink_list[$next_index]}"
	done
}

change_source () {
	local info="$1"
	local source_list=($(pactl list short sources | grep "input" | awk '{print $2}'))
	local current_source=$(echo "$info" | sed -n "s/Default Source: //p")
	local current_index=$( find_index current_source source_list )
	local next_index=$(($current_index+1 == ${#source_list[@]} ? 0 : $current_index+1 ))
	pactl set-default-source "${source_list[$next_index]}"
	local outputs=$( pactl list short source-outputs | awk '{print $1}' )
	for i in ${outputs[@]}; do
		pacmd move-source-output $i "${source_list[$next_index]}"
	done
}

if [[ $# -gt 0 ]]; then
	arg="$1"
	info="$(pactl info)"

	case "$arg" in
		-s|--sound|--sink)
			change_sink "$info"
		;;
		-m|--mic|--source)
			change_source "$info"
		;;
		-a|--all)
			change_sink "$info"
			change_source "$info"
		;;
	esac
fi

