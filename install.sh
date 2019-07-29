#!/usr/bin/env bash

dir="$(dirname "$0")/script"
main="${0##*/}"

help_message () {
	local file="$1"
	if [ -z $file ]; then
		echo "Usage: $main install Arch|arch|Ubuntu|ubuntu"
		echo "       $main sync"
		echo "       $main bash"
	else
		local target=$( find "$dir" -name "${file%%.sh}.sh" )
		if [ -z "$target" ]; then
			echo "Script file \"$target\" does not exist."
			return 1
		fi
		sed -n '2,/^$/p' $target
	fi
}

while [[ $# -gt 0 ]]; do
	arg="$1"

	case "$arg" in
		install)
			shift
			arg="$1"
			if [ "$arg" == "Arch" ] || [ "$arg" == "arch" ]; then
				echo "$dir/package.sh Arch"
				echo "$dir/package.sh common"
			elif [ "$arg" == "Ubuntu" ] || [ "$arg" == "ubuntu" ]; then
				echo "$dir/package.sh Ubuntu"
				echo "$dir/package.sh common"
			else
				echo "OS name is missing: $main install Arch|arch|Ubuntu|ubuntu"
				exit 1
			fi
		;;
		sync)
		;;
		source)
			printf "source $HOME/workspace/ubuntu-fresh/dotfiles/bashrc" >>\
				"$HOME/.bashrc"
		;;
		-h|--help|help|*)
			help_message "$2"
		;;
	esac
	exit 0
done

# while getopts "isb" opt; do
# 	case "$opt" in
# 		"i")
# 			echo "Apt" && bash "$dir""/apt.sh"
# 			echo "Nerd-font" && bash "$dir""/font.sh"
# 			echo "Suckless Terminal" && bash "$dir""/suckless.sh" -i st
# 			echo "Dmenu" && bash "$dir""/suckless.sh" -i dmenu
# 			echo "Powerline" && bash "$dir""/powerline.sh" -i
# 			echo "Ranger" && bash "$dir""/ranger.sh" -i ranger
# 			echo "Ranger_devicons" && bash "$dir""/ranger.sh" -i ranger_devicons
# 			echo "Sxiv" && bash "$dir""/sxiv.sh" -i
# 			echo "Youtube-dl" && bash "$dir""/youtube-dl.sh"

# 			echo "Vim" && bash "$dir""/vim.sh" -i
# 			echo "Tmux" && bash "$dir""/tmux.sh" -i
# 			# echo "Adapta" && bash "$dir""/adapta.sh"
# 			echo "Suru" && bash "$dir""/suru.sh"
# 			echo "gnome-shell-extension" && python3 "$dir""/gnome.py"
# 			echo "Gnome desktop environment configuration"
# 			bash "$dir""/config.sh" -i
# 			bash "$dir""/gsettings.sh"
# 			bash "$dir""/korean.sh"
# 			bash "$dir""/autostart.sh"
# 			break;;
# 		"s")
# 			bash "$dir""/config.sh" -s
# 			bash "$dir""/powerline.sh" -s
# 			bash "$dir""/ranger.sh" -s
# 			bash "$dir""/suckless.sh" -s
# 			bash "$dir""/sxiv.sh" -s
# 			bash "$dir""/tmux.sh" -s
# 			bash "$dir""/vim.sh" -s
# 			break;;
# 		"b")
# 			printf "source $HOME/workspace/ubuntu-fresh/dotfiles/bashrc" >>\
# 				"$HOME/.bashrc"
# 			break;;
# 		*)
# 			break;;
# 	esac
# done

