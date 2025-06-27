local M = {}

---@class PaletteBackground
---@field bg_dim string
---@field bg0 string
---@field bg1 string
---@field bg2 string
---@field bg3 string
---@field bg4 string
---@field bg5 string
---@field bg_visual string
---@field bg_red string
---@field bg_green string
---@field bg_blue string
---@field bg_yellow string

---@class PaletteBase
---@field fg string
---@field red string
---@field orange string
---@field yellow string
---@field green string
---@field aqua string
---@field blue string
---@field purple string
---@field grey0 string
---@field grey1 string
---@field grey2 string
---@field statusline1 string
---@field statusline2 string
---@field statusline3 string
---@field none string

---@class Palette: PaletteBase,PaletteBackground

---@alias Backgrounds "light" | "dark"
---@alias PaletteBackgrounds table<Backgrounds, PaletteBackground>

---@type PaletteBackgrounds
local hard_background = {
  dark = {
    bg_dim = "#121519",
    bg0 = "#121519",
    bg1 = "#181d21",
    bg2 = "#1f2529",
    bg3 = "#262d31",
    bg4 = "#2c3539",
    bg5 = "#323d41",
    bg_visual = "#4a5a5d",
    bg_red = "#211718",
    bg_green = "#192620",
    bg_blue = "#172728",
    bg_yellow = "#25201a",
  },
  light = {
    -- Optional: Mirror dark as placeholder if not using light mode
    bg_dim = "#ffffff",
    bg0 = "#ffffff",
    bg1 = "#f0f0f0",
    bg2 = "#e0e0e0",
    bg3 = "#d0d0d0",
    bg4 = "#c0c0c0",
    bg5 = "#b0b0b0",
    bg_visual = "#aaaaaa",
    bg_red = "#ffdede",
    bg_green = "#ddffdd",
    bg_blue = "#ddeeff",
    bg_yellow = "#fff8dc",
  },
}

---@type PaletteBackgrounds
local medium_background = hard_background -- Using same as hard for now
local soft_background = hard_background -- Using same as hard for now

---@type table<Backgrounds, PaletteBase>
local base_palette = {
  dark = {
    fg = "#AAB3B8",
    red = "#944F50",
    orange = "#C36B6C", -- closest to a bright red-orange
    yellow = "#C8A15D",
    green = "#538068",
    aqua = "#6A8584",
    blue = "#5F7A82",
    purple = "#7E4F6E",
    grey0 = "#6E777B",
    grey1 = "#8AADAC",
    grey2 = "#D0D7DB",
    statusline1 = "#6CA687",
    statusline2 = "#80969E",
    statusline3 = "#C36B6C",
    none = "NONE",
  },
  light = {
    fg = "#121519",
    red = "#944F50",
    orange = "#C36B6C",
    yellow = "#C8A15D",
    green = "#538068",
    aqua = "#6A8584",
    blue = "#5F7A82",
    purple = "#7E4F6E",
    grey0 = "#6E777B",
    grey1 = "#8AADAC",
    grey2 = "#D0D7DB",
    statusline1 = "#6CA687",
    statusline2 = "#80969E",
    statusline3 = "#C36B6C",
    none = "NONE",
  },
}

---Generates the colour palette based on the user's config
---@param options Config The package configuration table
---@param theme "light" | "dark" The user's background preference
---@return Palette
M.generate_palette = function(options, theme)
  local background = options.background or "medium"
  local base = base_palette[theme]
  ---@type PaletteBackground
  local background_palette

  if background == "soft" then
    background_palette = soft_background[theme]
  elseif background == "hard" then
    background_palette = hard_background[theme]
  else
    background_palette = medium_background[theme]
  end

  ---@type Palette
  local combined_palette = vim.tbl_extend("force", base, background_palette)
  options.colours_override(combined_palette)

  return combined_palette
end

return M
