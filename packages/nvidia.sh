#!/usr/bin/env bash

set -euo pipefail

config_nvidia_settings() {
  # TODO: WIP
  nvidia-settings -a CurrentMetaMode="${s//\}/, ForceFullCompositionPipeline=On ForceCompositionPipeline=On\}}"
}

config_nvidia_settings
