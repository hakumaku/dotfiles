local terminal = "alacritty"
local editor = os.getenv("EDITOR") or "nano"

return {
    terminal = terminal,
    editor = editor,
    editor_cmd = terminal .. " -e " .. editor,
    modkey = "Mod4"
}
