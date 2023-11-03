local wezterm = require("wezterm")

local default_prog
local font_size = 17.0
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  default_prog = { "powershell", "-NoLogo" }
  font_size = 10.0
end

return {
  -- font = wezterm.font("JetBrains Mono", { weight = "Bold", italic = false }),
  font = wezterm.font("ComicShannsMono Nerd Font Mono", { weight = "Bold", italic = false }),
  color_scheme = "Gruvbox dark, soft (base16)",
  colors = {
    cursor_bg = "Red",
    cursor_fg = "black",
  },
  font_size = font_size,

  window_background_opacity = 0.90,

  -- Disable ligatures
  -- ref: https://wezfurlong.org/wezterm/config/font-shaping.html
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  default_prog = default_prog,
  -- Search in copy mode
  -- ref: https://github.com/wez/wezterm/issues/1592
  -- key_tables = {
  --   copy_mode = {
  --     { key = "Escape", mods = "NONE", action = wezterm.action({ CopyMode = "Close" }) },
  --     { key = "h", mods = "NONE", action = wezterm.action({ CopyMode = "MoveLeft" }) },
  --     { key = "j", mods = "NONE", action = wezterm.action({ CopyMode = "MoveDown" }) },
  --     { key = "k", mods = "NONE", action = wezterm.action({ CopyMode = "MoveUp" }) },
  --     { key = "l", mods = "NONE", action = wezterm.action({ CopyMode = "MoveRight" }) },
  --     -- Enter search mode to edit the pattern.
  --     -- When the search pattern is an empty string the existing pattern is preserved
  --     { key = "/", mods = "NONE", action = wezterm.action({ Search = { CaseSensitiveString = "" } }) },
  --     -- navigate any search mode results
  --     { key = "n", mods = "NONE", action = wezterm.action({ CopyMode = "NextMatch" }) },
  --     { key = "N", mods = "SHIFT", action = wezterm.action({ CopyMode = "PriorMatch" }) },
  --   },
  --   search_mode = {
  --     { key = "Escape", mods = "NONE", action = wezterm.action({ CopyMode = "Close" }) },
  --     -- Go back to copy mode when pressing enter, so that we can use unmodified keys like "n"
  --     -- to navigate search results without conflicting with typing into the search area.
  --     { key = "Enter", mods = "NONE", action = "ActivateCopyMode" },
  --   },
  -- },
}
