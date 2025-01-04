#!/usr/bin/env bash

main() {
  local path="$1"
  local dir="${path%/*}"
  local filename="${path##*/}"

  local files
  readarray -t files < <(
    find ./ -maxdepth 1 -type f -printf "%f\n" \
      | LC_COLLATE=c sort \
      | grep -E "\.webm$|\.flv$|\.vob$|\.ogg$|\.ogv$|\.drc$|\.gifv$|\.mng$|\.avi$|\.mov$|\.qt$|\.wmv$|\.yuv$|\.rm$|\.rmvb$|/.asf$|\.amv$|\.mp4$|\.m4v$|\.mp*$|\.m?v$|\.svi$|\.3gp$|\.flv$|\.f4v$"
    "$dir"
  )

  local playlist="$XDG_CACHE_HOME/playlist.m3u"
  cat >"$playlist"
  for file in "${files[@]}"; do
    echo "$dir/$file" >>"$playlist"
  done

  for i in "${!files[@]}"; do
    if [[ "${files[$i]}" = "${filename}" ]]; then
      # flatpak run io.mpv.Mpv --playlist="$playlist" --playlist-start="$i"
      mpv --playlist="$playlist" --playlist-start="$i"
    fi
  done
}

main "$@"
