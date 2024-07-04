--TODO:
--PreProc needs its own color
--parameter and field should be different
---@class SyntaxElements
---@field string ColorSpec
---@field variable ColorSpec
---@field number ColorSpec
---@field constant ColorSpec
---@field identifier ColorSpec
---@field parameter ColorSpec
---@field fun ColorSpec
---@field statement ColorSpec
---@field keyword ColorSpec
---@field operator ColorSpec
---@field preproc ColorSpec
---@field type ColorSpec
---@field regex ColorSpec
---@field deprecated ColorSpec
---@field comment ColorSpec
---@field punct ColorSpec
---@field special1 ColorSpec
---@field special2 ColorSpec
---@field special3 ColorSpec

---@class DiagnosticsElements
---@field error ColorSpec
---@field ok ColorSpec
---@field warning ColorSpec
---@field info ColorSpec
---@field hint ColorSpec
--
---@class DiffElements
---@field add ColorSpec
---@field delete ColorSpec
---@field change ColorSpec
---@field text ColorSpec

---@class VCSElements
---@field added ColorSpec
---@field removed ColorSpec
---@field changed ColorSpec

---@class UiElements
---@field accent ColorSpec
---@field fg ColorSpec Default foreground
---@field fg_dim ColorSpec Dimmed foreground
---@field fg_reverse ColorSpec
---@field bg_dim ColorSpec Dimmed background
---@field bg_m3 ColorSpec
---@field bg_m2 ColorSpec
---@field bg_m1 ColorSpec
---@field bg ColorSpec Default background
---@field bg_p1 ColorSpec Lighter background ColorColumn, Folded, Gutter
---@field bg_p2 ColorSpec Lighter background Cursor{Line,Column}, TabLineSel (Selected Items)
---@field bg_gutter ColorSpec {Sign,Fold}Column, LineNr
---@field special ColorSpec SpecialKey
---@field nontext ColorSpec LineNr, NonText
---@field whitespace ColorSpec Whitespace
---@field bg_search ColorSpec
---@field bg_search_current ColorSpec
---@field bg_visual ColorSpec
---@field pmenu MenuElements
---@field float FloatElements

---@class FloatElements
---@field title ColorSpec
---@field title_focused ColorSpec
---@field fg ColorSpec
---@field bg ColorSpec
---@field fg_border ColorSpec
---@field bg_border ColorSpec

---@class MenuElements
---@field bg ColorSpec
---@field fg ColorSpec
---@field fg_sel ColorSpec
---@field bg_sel ColorSpec
---@field bg_sbar ColorSpec
---@field bg_thumb ColorSpec

---@class ThemeColors
---@field syn SyntaxElements
---@field diag DiagnosticsElements
---@field vcs VCSElements
---@field diff DiffElements
---@field ui UiElements
---@field term ColorSpec[]

return {
  ---@param palette PaletteColors
  ---@param accent string
  ---@return ThemeColors
  beige = function(palette, accent)
    return {
      ui = {
        accent = palette[accent],

        fg = palette.white1,
        fg_dim = palette.white0,
        fg_reverse = palette.ink2,

        bg_dim = palette.ink1,
        bg_gutter = palette.ink4,

        bg_m3 = palette.ink3,
        bg_m2 = palette.ink1,
        bg_m1 = palette.ink3,
        bg = palette.ink2,
        bg_p1 = palette.ink4,
        bg_p2 = palette.ink5,

        special = palette.violet1,
        nontext = palette.ink6,
        whitespace = palette.ink5,

        bg_search = palette.blue0,
        bg_search_current = palette.violet1,
        bg_visual = palette.ink4,

        pmenu = {
          fg = palette.white0,
          fg_sel = "none", -- This is important to make highlights pass-through
          bg = palette.ink4,
          bg_sel = palette.ink5,
          bg_sbar = palette.ink3,
          bg_thumb = palette.ink4,
        },
        float = {
          title = palette.gray2,
          title_focused = palette.blue1,
          fg = palette.white1,
          bg = palette.ink0,
          fg_border = palette.ink5,
          bg_border = palette.ink0,
        },
      },
      syn = {
        string = palette.green1,
        variable = "none",
        number = palette.magenta1,
        constant = palette.amber1,
        identifier = palette.yellow1,
        parameter = palette.red3,
        fun = palette.blue1,
        statement = palette.violet1,
        keyword = palette.violet1,
        operator = palette.yellow1,
        preproc = palette.red1,
        type = palette.aqua2,
        regex = palette.yellow1,
        deprecated = palette.gray0,
        comment = palette.gray1,
        punct = palette.white0,
        special1 = palette.blue2,
        special2 = palette.violet3,
        special3 = palette.magenta2,
      },
      vcs = {
        added = palette.green0,
        removed = palette.red0,
        changed = palette.yellow0,
      },
      diff = {
        add = palette.green_dark,
        delete = palette.red_dark,
        change = palette.yellow_dark,
        text = palette.aqua_dark,
      },
      diag = {
        ok = palette.green1,
        error = palette.red1,
        warning = palette.yellow1,
        info = palette.blue1,
        hint = palette.aqua1,
      },
      term = {
        palette.ink0, -- black
        palette.red1, -- red
        palette.green1, -- green
        palette.yellow1, -- yellow
        palette.blue1, -- blue
        palette.violet1, -- magenta
        palette.aqua1, -- cyan
        palette.white1, -- white
        palette.gray1, -- bright black
        palette.red0, -- bright red
        palette.green0, -- bright green
        palette.yellow0, -- bright yellow
        palette.blue0, -- bright blue
        palette.violet0, -- bright magenta
        palette.aqua0, -- bright cyan
        palette.white2, -- bright white
        palette.amber1, -- extended color 1
        palette.magenta1, -- extended color 2
      },
    }
  end,
}
