import os
import pathlib
import subprocess
from typing import List

from libqtile import hook


@hook.subscribe.startup_once
def autostart(scripts: List[str]):
    config_home = os.environ.get("XDG_CONFIG_HOME", os.path.expanduser("~/.config"))
    qtile_config_path = pathlib.Path(config_home) / "qtile"

    for script in scripts:
        subprocess.run([qtile_config_path / script])
