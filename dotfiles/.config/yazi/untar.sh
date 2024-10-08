#!/usr/bin/env bash

function untar_each_here() {
  local files
  readarray -t files < <(find ~+ -maxdepth 1 -type f -name "*.tar.gz")
  for file in "${files[@]}"; do
    mkdir -p "${file%%.*}"
    tar xzvf "$file" -C "${file%%.*}"
  done
}
  
untar_each_here
