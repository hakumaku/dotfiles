#!/usr/bin/env bash

main() {
  local path="$1"
  local dir="${path%/*}"
  local filename="${path##*/}"

  local files=($(ls -1 $dir | sort))
  for i in "${!files[@]}"; do
    if [[ "${files[$i]}" = "${filename}" ]]; then
      imv $dir -n $((i + 1))
    fi
  done
}

main "$@"
