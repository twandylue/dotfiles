local wezterm = require("wezterm")

local default_prog
local font_size = 17.0
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  default_prog = { "powershell", "-NoLogo" }
  font_size = 10.0
end

return {
  font = wezterm.font("JetBrains Mono", { weight = "Bold", italic = false }),
  color_scheme = "Gruvbox dark, soft (base16)",
  colors = {
    cursor_bg = "Red",
    cursor_fg = "black",
  },
  font_size = font_size,

  window_background_opacity = 0.90,

  -- Disable ligatures
  -- https://wezfurlong.org/wezterm/config/font-shaping.html
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  default_prog = default_prog,
}
