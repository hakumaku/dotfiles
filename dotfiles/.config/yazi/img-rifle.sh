#!/usr/bin/env bash

main() {
  local path="$1"
  local dir="${path%/*}"
  local filename="${path##*/}"
  feh --image-bg black \
    --borderless \
    --hide-pointer \
    --scale-down "$dir"

  # local files
  # readarray -t files < <(ls -1 "$dir" | sort)
  #
  # for i in "${!files[@]}"; do
  #   if [[ "${files[$i]}" = "${filename}" ]]; then
  #     if [[ "$XDG_SESSION_TYPE" = "x11" ]]; then
  #       imv-x11 "$dir" -n $((i + 1))
  #     else
  #       imv-wayland "$dir" -n $((i + 1))
  #     fi
  #   fi
  # done
}

main "$@"
