#!/usr/bin/env bash

main() {
  local path="$1"
  local dir="${path%/*}"
  local filename="${path##*/}"

  local files
  readarray -t files < <(ls "$dir")

  local playlist="$XDG_CACHE_HOME/playlist.m3u"
  echo "" > "$playlist"
  for file in "${files[@]}"; do
    echo "$dir/$file" >> "$playlist"
  done

  for i in "${!files[@]}"; do
    if [[ "${files[$i]}" = "${filename}" ]]; then
      flatpak run io.mpv.Mpv --playlist="$playlist" --playlist-start="$i"
    fi
  done
}

main "$@"
