---@class PaletteColors
---@field accent ColorSpec
local palette = {
  -- backgrounds
  ink0 = "#16161d",
  ink1 = "#181820",
  ink2 = "#1a1a22",
  ink3 = "#1f1f28",
  ink4 = "#2a2a37",
  ink5 = "#363646",
  ink6 = "#54546d",
  -- foregrounds
  white0 = "#d5cea3",
  white1 = "#dcd5ac",
  white2 = "#e5ddb0",
  white3 = "#f2ecbc",
  white4 = "#e7dba0",
  white5 = "#e4d794",
  -- comments and gutters
  gray0 = "#383733",
  gray1 = "#53524c",
  gray2 = "#7e7d74",
  -- red
  red_dark = "#430c12",
  red0 = "#db3a4d",
  red1 = "#e46876",
  red2 = "#e8808b",
  red3 = "#ec98a1",
  red4 = "#f0b0b7",
  -- amber
  amber_dark = "#552000",
  amber0 = "#ff7c2c",
  amber1 = "#ffa066",
  amber2 = "#ffb384",
  amber3 = "#fec5a3",
  amber4 = "#fed5bb",
  -- yellow
  yellow_dark = "#48330e",
  yellow0 = "#dcab53",
  yellow1 = "#e6c384",
  yellow2 = "#ebce9c",
  yellow3 = "#f0dbb5",
  yellow4 = "#f4e4c8",
  -- green
  green_dark = "#2d3d13",
  green0 = "#9bc754",
  green1 = "#b3d57d",
  green2 = "#c2dd96",
  green3 = "#d1e5b1",
  green4 = "#e3efd0",
  -- aqua
  aqua_dark = "#172b24",
  aqua0 = "#6a9589",
  aqua1 = "#6caf95",
  aqua2 = "#89bfaa",
  aqua3 = "#a6cfbf",
  aqua4 = "#bedbd0",
  -- blue
  blue_dark = "#13213f",
  blue0 = "#537bcb",
  blue1 = "#7e9cd8",
  blue2 = "#92abde",
  blue3 = "#acbfe6",
  blue4 = "#c6d3ed",
  -- violet
  violet_dark = "#221a30",
  violet0 = "#7a5ea6",
  violet1 = "#957fb8",
  violet2 = "#aa98c6",
  violet3 = "#bfb2d4",
  violet4 = "#d0c6df",
  -- magenta
  magenta_dark = "#37131f",
  magenta0 = "#c04c71",
  magenta1 = "#d27e99",
  magenta2 = "#da97ad",
  magenta3 = "#e4b1c1",
  magenta4 = "#ebc6d2",
}

local M = {}
--- Generate colors table:
--- * opts:
---   - colors: Table of personalized colors and/or overrides of existing ones.
---     Defaults to GalaxConfig.colors.
---   - theme: Use selected theme. Defaults to GalaxConfig.theme
---     according to the value of 'background' option.
---@param opts? { colors?: table, theme?: string, accent?: string }
---@return { theme: ThemeColors, palette: PaletteColors}
function M.setup(opts)
  opts = opts or {}
  local override_colors = opts.colors or require("galax").config.colors
  local theme = opts.theme or require("galax")._CURRENT_THEME -- WARN: this fails if called before galax.load()

  if not theme then
    error(
      "galax.colors.setup(): Unable to infer `theme`. Either specify a theme or call this function after ':colorscheme galax'"
    )
  end

  -- Add to and/or override palette_colors
  local updated_palette_colors =
    vim.tbl_extend("force", palette, { accent = palette[opts.accent] }, override_colors.palette or {})

  -- Generate the theme according to the updated palette colors
  local theme_colors = require("galax.themes")[theme](updated_palette_colors)

  -- Add to and/or override theme_colors
  local theme_overrides =
    vim.tbl_deep_extend("force", override_colors.theme["all"] or {}, override_colors.theme[theme] or {})
  local updated_theme_colors = vim.tbl_deep_extend("force", theme_colors, theme_overrides)
  -- return palette_colors AND theme_colors

  return {
    theme = updated_theme_colors,
    palette = updated_palette_colors,
  }
end

return M
