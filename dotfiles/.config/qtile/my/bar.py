from libqtile import bar, widget


class MyBar:
    def __init__(self):
        ...

    def __call__(self) -> bar.Bar:
        b = bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Spacer(),
                widget.Clock(format="%a %H:%M %Y-%m-%d"),
                widget.Spacer(),
                widget.Systray(),
                widget.QuickExit(),
            ],
            56,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        )

        return b
