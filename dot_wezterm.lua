local wezterm = require("wezterm")

local os = (function()
  if string.find(wezterm.target_triple, "apple") then
    return "macOS"
  elseif string.find(wezterm.target_triple, "windows") then
    return "windows"
  elseif string.find(wezterm.target_triple, "linux") then
    return "linux"
  end
end)()

-- Common settings
local config = {

  -- kanagawa.nvim
  force_reverse_video_cursor = true,
  colors = {
    foreground = "#dcd7ba",
    background = "#1f1f28",

    cursor_bg = "#c8c093",
    cursor_fg = "#c8c093",
    cursor_border = "#c8c093",

    selection_fg = "#c8c093",
    selection_bg = "#2d4f67",

    scrollbar_thumb = "#16161d",
    split = "#16161d",

    ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
    brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
    indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
  },

  font = wezterm.font_with_fallback({
    "Cascadia Code",
    "Cascadia Mono",
    "JetBrains Mono",
  }),

  animation_fps = 120,
  max_fps = 120,
  prefer_egl = true,
  front_end = "WebGpu",
  webgpu_power_preference = "HighPerformance",

  -- window
  integrated_title_button_style = "Windows",
  window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  window_background_opacity = 1,
  window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
  window_frame = {
    active_titlebar_bg = "#0F2536",
    inactive_titlebar_bg = "#0F2536",
  },

  -- tab bar
  use_fancy_tab_bar = true,
  hide_tab_bar_if_only_one_tab = false,

  -- cursor
  default_cursor_style = "BlinkingBlock",
  cursor_blink_ease_in = "Constant",
  cursor_blink_ease_out = "Constant",
  cursor_blink_rate = 500,

  leader = { key = "Space", mods = "SHIFT|CTRL" },
  keys = {
    -- Window
    { key = "n", mods = "SHIFT|CTRL", action = wezterm.action.ToggleFullScreen },
    { key = "Enter", mods = "ALT", action = wezterm.action.DisableDefaultAssignment },
    { key = "s", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "v", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "c", mods = "SHIFT|CTRL", action = wezterm.action({ CopyTo = "Clipboard" }) },
    { key = "u", mods = "SHIFT|CTRL", action = wezterm.action.ScrollByPage(-0.5) },
    { key = "d", mods = "SHIFT|CTRL", action = wezterm.action.ScrollByPage(0.5) },
    { key = "g", mods = "SHIFT|CTRL", action = wezterm.action.ScrollToBottom },

    -- Tab
    { key = "{", mods = "SHIFT|ALT", action = wezterm.action.MoveTabRelative(-1) },
    { key = "}", mods = "SHIFT|ALT", action = wezterm.action.MoveTabRelative(1) },

    -- Keybinds of Copy and Paste
    { key = "C", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },
    { key = "V", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
    { key = "h", mods = "CTRL", action = wezterm.action.SendKey({ key = "LeftArrow" }) },
    { key = "j", mods = "CTRL", action = wezterm.action.SendKey({ key = "DownArrow" }) },
    { key = "k", mods = "CTRL", action = wezterm.action.SendKey({ key = "UpArrow" }) },
    { key = "l", mods = "CTRL", action = wezterm.action.SendKey({ key = "RightArrow" }) },

    -- Fonts
    { key = "+", mods = "CTRL|SHIFT", action = "IncreaseFontSize" },
    { key = "_", mods = "CTRL|SHIFT", action = "DecreaseFontSize" },
    { key = "Backspace", mods = "CTRL|SHIFT", action = "ResetFontSize" },

    --
    { key = "F5", action = "ReloadConfiguration" },
  },
}

-- macOS settings
if os == "macOS" then
  config["font_size"] = 11.0
  config["initial_cols"] = 320
  config["initial_rows"] = 100

-- Windows settings
elseif os == "windows" then
  -- config["default_prog"] = { 'msys2.cmd', '-defterm', '-no-start', '-full-path', '-shell', 'zsh' }
  config["font_size"] = 12.0
  config["initial_cols"] = 140
  config["initial_rows"] = 60

-- Linux settings
elseif os == "linux" then
end

return config
