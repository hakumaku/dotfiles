#!/usr/bin/env bash

sync_dotfile () {
	# $1: local file
	# $2: remote file
	local new="$1"
	local old="$2"
	local filename="$(basename "$(dirname "$new")")"/"$(basename -- "$new")"

	if [ -d "$new" ] && [ -d "$old" ]; then
		local equal=$( find "$new/" "$old/" -printf '%P\n' | sort | uniq -d )
		local plus=$( find "$new/" "$old/" "$old/" -printf '%P\n' | sort | uniq -u )
		local minus=$( find "$new/" "$new/" "$old/" -printf '%P\n' | sort | uniq -u )
		local modified=()
		for f in ${equal[@]}; do
			if ! cmp -s "$new/$f" "$old/$f"; then
				modified+=("$f")
			fi
		done
		if [ -z "$plus" ] && [ -z "$minus" ] && [ -z "$modified" ]; then
			echo $filename
		else
			echo "$filename*"
			for f in ${plus[@]}; do
				echo -e "\t+$f"
				cp "$new/$f" "$old/"
			done
			for f in ${modified[@]}; do
				echo -e "\t*$f"
				cp "$new/$f" "$old/"
			done
			for f in ${minus[@]}; do
				echo -e "\t-$f"
				rm "$old/$f"
			done
		fi
	elif [ -f "$new" ] && [ -f "$old" ]; then
		if cmp -s "$new" "$old"; then
			echo $filename
		else
			echo "$filename*"
			cp "$new" "$old"
		fi
	else
		echo "Invalid arguements:"
		echo -e "\t$( file -b $new ): $new"
		echo -e "\t$( file -b $old ): $old"
		echo "Both \$new and \$old must be of the same type."
	fi
}

