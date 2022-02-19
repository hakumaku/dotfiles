c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103

config.load_autoconfig()

config.source("themes/onedark.py")
config.bind(
    r"\r",
    "spawn --verbose --detach mpv {url}",
)
config.bind(r"\t", "config-cycle tabs.show always never")
config.bind(
    "<Ctrl-[>", "mode-leave;; jseval -q document.activeElement.blur()", mode="insert"
)

c.qt.highdpi = True
c.url.start_pages = ["https://gitlab.com/"]
c.url.searchengines = {
    "DEFAULT": "https://google.com/search?hl=en&q={}",
}
c.content.blocking.enabled = True
c.content.blocking.method = "both"
c.scrolling.smooth = True

# When to show the statusbar.
# Type: String
# Valid values:
#   - always: Always show the statusbar.
#   - never: Always hide the statusbar.
#   - in-mode: Show the statusbar when in modes other than normal mode.
c.statusbar.show = "in-mode"


def font(size: int) -> str:
    return f"{size}pt 'MesloLGS NF'"


c.fonts.completion.entry = font(14)
c.fonts.statusbar = font(14)
