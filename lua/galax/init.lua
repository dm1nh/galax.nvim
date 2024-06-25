local M = {}

---@alias ColorSpec string RGB Hex string
---@alias ColorTable table<string, ColorSpec>
---@alias GalaxColorsSpec { palette: ColorTable, theme: ColorTable }
---@alias GalaxColors { palette: PaletteColors, theme: ThemeColors }

--- default config
---@class GalaxConfig
M.config = {
  theme = "beige",
  accent = "green1",
  compile = false,
  ---@type { dark: string, light: string }
  background = { dark = "beige", light = "white" },
  undercurl = true,
  style = {
    comments = { italic = true },
    functions = {},
    keywords = {},
    statements = { bold = true },
    types = {},
  },
  transparent = false,
  dimInactive = false,
  term = true,
  colors = { theme = { beige = {}, white = {}, all = {} }, palette = {} },
  ---@type fun(colors: GalaxColorsSpec): table<string, table>
  overrides = function()
    return {}
  end,
}

local function check_config(config)
  local err
  return not err
end

--- update global configuration with user settings
---@param config? GalaxConfig user configuration
function M.setup(config)
  if check_config(config) then
    M.config = vim.tbl_deep_extend("force", M.config, config or {})
  else
    vim.notify("Galax: Errors found while loading user config. Using default config.", vim.log.levels.ERROR)
  end
end

--- load the colorscheme
---@param theme? string
function M.load(theme)
  local utils = require("galax.utils")

  theme = theme or M.config.background[vim.o.background] or M.config.theme
  M._CURRENT_THEME = theme

  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.g.colors_name = "galax"
  vim.o.termguicolors = true

  if M.config.compile then
    if utils.load_compiled(theme) then
      return
    end

    M.compile()
    utils.load_compiled(theme)
  else
    local colors = require("galax.colors").setup({ theme = theme, colors = M.config.colors, accent = M.config.accent })
    local highlights = require("galax.highlights").setup(colors, M.config)
    require("galax.highlights").highlight(highlights, M.config.term and colors.theme.term or {})
  end
end

function M.compile()
  for theme, _ in pairs(require("galax.themes")) do
    local colors = require("galax.colors").setup({ theme = theme, colors = M.config.colors })
    local highlights = require("galax.highlights").setup(colors, M.config)
    require("galax.utils").compile(theme, highlights, M.config.term and colors.theme.term or {})
  end
end

vim.api.nvim_create_user_command("GalaxCompile", function()
  for mod, _ in pairs(package.loaded) do
    if mod:match("^galax%.") then
      package.loaded[mod] = nil
    end
  end
  M.compile()
  vim.notify("Galax: compiled successfully!", vim.log.levels.INFO)
  M.load(M._CURRENT_THEME)
  vim.api.nvim_exec_autocmds("ColorScheme", { modeline = false })
end, {})

return M
