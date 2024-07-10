local M = {}

-- Catppuccin Mocha
---@class Palette
M.colours = {
  rosewater = "#f5e0dc",
  flamingo = "#f2cdcd",
  pink = "#f5c2e7",
  mauve = "#cba6f7",
  red = "#f38ba8",
  maroon = "#eba0ac",
  peach = "#fab387",
  yellow = "#f9e2af",
  green = "#a6e3a1",
  teal = "#94e2d5",
  sky = "#89dceb",
  sapphire = "#74c7ec",
  blue = "#89b4fa",
  lavender = "#b4befe",
  text = "#cdd6f4",
  subtext1 = "#bac2de",
  subtext0 = "#a6adc8",
  overlay2 = "#9399b2",
  overlay1 = "#7f849c",
  overlay0 = "#6c7086",
  surface2 = "#585b70",
  surface1 = "#45475a",
  surface0 = "#313244",
  base = "#1e1e2e",
  mantle = "#181825",
  crust = "#11111b",
}

---@class Palette
M.dracula_colours = {
  bg = nil,
  fg = "#F8F8F2",

  black = "#191A21",
  cyan = "#8BE9FD",
  green = "#50fa7b",
  orange = "#FFB86C",
  pink = "#FF79C6",
  purple = "#BD93F9",
  red = "#FF5555",
  white = "#ABB2BF",
  yellow = "#F1FA8C",

  bright_blue = "#D6ACFF",
  bright_cyan = "#A4FFFF",
  bright_green = "#69FF94",
  bright_magenta = "#FF92DF",
  bright_red = "#FF6E6E",
  bright_white = "#FFFFFF",
  bright_yellow = "#FFFFA5",

  comment = "#6272A4",
  selection = "#44475A",
  menu = "#21222C",
  visual = "#3E4452",
  gutter_fg = "#4B5263",
  nontext = "#3B4048",
}

-- Can name to colours to switch pallete
---@type Palette
M.dracula_soft = {
  bg = "#292A35", --
  fg = "#F6F6F5",
  transparent_bg = nil,
  -- ANSI
  black = "#1C1C1C", -- ANSI 0
  cyan = "#A7DFEF",
  green = "#87E58E",
  orange = "#FDC38E",
  pink = "#E48CC1",
  purple = "#BAA0E8", -- used as ANSI 4 (blue)
  white = "#F6F6F5", -- ANSI 7, 'selection' used for ANSI 8
  red = "#DD6E6B",
  yellow = "#E8EDA2",
  -- indexes 9-15
  bright_blue = "#D0B5F3",
  bright_cyan = "#BCF4F5",
  bright_green = "#97EDA2",
  bright_magenta = "#E7A1D7",
  bright_red = "#E1837F",
  bright_white = "#FFFFFF", -- index 15
  bright_yellow = "#F6F6B6",

  comment = "#70747f",
  selection = "#7C7F8A",
  menu = "#21222C",
  visual = "#3E4452",
  gutter_fg = "#4B5263",
  nontext = "#3B4048",
}

M.icons = {
  diagnostics = {
    error = "",
    warn = "",
    hint = "󰌵",
    info = "",
    other = "",
    prefix = "●",
  },
  cmp = {
    Text = " ",
    Method = "󰆧",
    Function = "ƒ ",
    Constructor = " ",
    Field = "󰜢 ",
    Variable = " ",
    Constant = " ",
    Class = " ",
    Interface = "󰜰 ",
    Struct = " ",
    Enum = "了 ",
    EnumMember = " ",
    Module = "",
    Property = " ",
    Unit = " ",
    Value = "󰎠 ",
    Keyword = "󰌆 ",
    Snippet = " ",
    File = " ",
    Folder = " ",
    Color = " ",
  },
  mason = {
    package_installed = "✓",
    package_pending = "➜",
    package_uninstalled = "✗",
  },
}

local colours = M.colours
M.lualine = function()
  return {
    normal = {
      a = { fg = colours.black, bg = colours.purple, gui = "bold" },
      b = { fg = colours.purple, bg = colours.bg },
      c = { fg = colours.white, bg = colours.bg },
    },
    command = {
      a = { fg = colours.black, bg = colours.cyan, gui = "bold" },
      b = { fg = colours.cyan, bg = colours.bg },
    },
    visual = {
      a = { fg = colours.black, bg = colours.pink, gui = "bold" },
      b = { fg = colours.pink, bg = colours.bg },
    },
    inactive = {
      a = { fg = colours.white, bg = colours.visual, gui = "bold" },
      b = { fg = colours.black, bg = colours.white },
    },
    replace = {
      a = { fg = colours.black, bg = colours.yellow, gui = "bold" },
      b = { fg = colours.yellow, bg = colours.bg },
      c = { fg = colours.white, bg = colours.bg },
    },
    insert = {
      a = { fg = colours.black, bg = colours.green, gui = "bold" },
      b = { fg = colours.green, bg = colours.bg },
      c = { fg = colours.white, bg = colours.bg },
    },
  }
end

return M
