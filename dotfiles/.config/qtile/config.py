# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
from libqtile import layout
from libqtile.config import Click, Drag, Match, Screen
from libqtile.lazy import lazy

from my.autostart import autostart
from my.bar import MyBar
from my.config import Config

config = Config(
    mod="mod4",
    terminal="alacritty",
    group_names=["1", "2", "3", "4", "5", "6", "7", "8"],
    group_rules={
        1: [Match(wm_class="Alacritty")],
        2: [],
        3: [Match(wm_class="Firefox")],
        4: [],
        5: [Match(wm_class="Thunderbird")],
        6: [Match(wm_class="streamlink-twitch-gui")],
        7: [Match(wm_class="Spotify")],
        8: [Match(wm_class="Steam")],
    },
)
layouts = [
    layout.Spiral(
        border_focus_stack=["#d75f5f", "#8f3d3d"],
        border_width=2,
        main_pane="left",
        clockwise=True,
        margin=8,
        ratio=0.5,
    ),
    layout.Max(),
]
floating_layout = layout.Floating(float_rules=config.float_rules)

mod = config.mod
terminal = config.terminal
keys = config.keys
groups = config.groups

"""
Onedark color palatte
#282C34
#E06C75
#98C379
#E5C07B
#61AFEF
#C678DD
#56B6C2
#ABB2BF
"MesloLGS Nerd Font Mono 12"
"""

widget_defaults = dict(
    font="MesloLGS Nerd Font Mono",
    fontsize=40,
    padding=3,
)
extension_defaults = widget_defaults.copy()

my_bar = MyBar()
screens = [
    Screen(
        top=my_bar(),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

autostart(scripts=["autostart.sh"])
