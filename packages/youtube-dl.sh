#!/usr/bin/env bash

set -euo pipefail

msg info "installing youtube-dl"
pip install --quiet --user --upgrade youtube-dl
