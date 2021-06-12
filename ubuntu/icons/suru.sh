#!/usr/bin/env bash

url="https://raw.githubusercontent.com/gusbemacbe/suru-plus/master/install.sh"
wget -qO- $url | sh
wget -qO- https://git.io/fhQdI | sh
suru-plus-folders -C orange
