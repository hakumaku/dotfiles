#!/usr/bin/env bash

function webp {
  mogrify -format jpg *.webp \
    && rm -rf *.webp
}

webp
