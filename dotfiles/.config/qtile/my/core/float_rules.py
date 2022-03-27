import re
from typing import List

from libqtile import layout
from libqtile.config import Match


def create_float_rules() -> List[Match]:
    jetbrains_regex = re.compile("jetbrains-.*")

    return [
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        # Jetbrains
        Match(title=" ", wm_class=jetbrains_regex),
        Match(title="Welcome", wm_class=jetbrains_regex),
        # Media
        Match(wm_class="Sxiv"),
        Match(wm_class="Nsxiv"),
        Match(wm_class="mpv"),
        # Browser
        Match(wm_class="firefox"),
        # Steam
        Match(title=re.compile("Steam - News.*"), wm_class="Steam"),
    ]
