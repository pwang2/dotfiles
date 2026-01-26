-- Theme-agnostic highlight configuration
-- Supports both light and dark backgrounds

local M = {}

M.colors = {}

-- Detect if background is dark
local function is_dark_background()
  return vim.o.background == "dark"
end

-- Dark theme palette (based on current onehalfdark colors)
local dark_palette = {
  -- Border and separator colors
  border = "#5b5b5b",
  separator = "#585858",

  -- Visual selection
  visual = "#474e5d",

  -- Folded text
  folded = "#569cd6",

  -- Popup menu
  pmenu_fg = "#98a3ad",
  pmenu_sel_bg = "#6ac0ff",
  pmenu_sel_fg = "#f1f1f1",

  -- Floating windows
  normal_float = "#b7cad4",

  -- Non-text markers
  nontext = "#81a46b",

  -- LSP decorations
  codelens = "#888888",

  -- Diff colors
  diff_add_bg = "#223322",
  diff_add_fg = "#a6e22e",
  diff_change_bg = "#222233",
  diff_change_fg = "#66d9ef",
  diff_delete_bg = "#332222",
  diff_delete_fg = "#f92672",

  -- Bufferline colors
  bufferline_inactive_bg = "#1c1c1c",
  bufferline_inactive_fg = "#e0e0e0",
  bufferline_visible_bg = "#0e0e0e",
  bufferline_visible_fg = "#5c6370",
  bufferline_selected_bg = "#282c34",
  bufferline_selected_fg = "#00afff",
  bufferline_background = "#1c1c1c",
  bufferline_offset_separator_fg = "#585858",
  bufferline_modified = "#ff0000",

  -- CMP colors
  cmp_deprecated = "#808080",
  cmp_match = "#56d690",
  cmp_match_fuzzy = "#569CD6",
  cmp_variable = "#9CDCFE",
  cmp_function = "#C586C0",
  cmp_method = "#C586C0",
  cmp_keyword = "#D4D4D4",
  cmp_property = "#D4D4D4",
  cmp_unit = "#D4D4D4",
  cmp_copilot = "#6CC644",

  -- Diffview colors
  diffview_diff_add_bg = "#263834",
  diffview_diff_change_bg = "#263834",
  diffview_diff_text_bg = "#335d3d",
  diffview_diff_text_fg = "#d1d7e0",
  diffview_diff_delete_bg = "#3e2e34",
  diffview_diff_delete_fg = "#cacad3",

  -- Lualine colors
  lualine_darkgray = "#16161d",
  lualine_gray = "#a8a8a8",
  lualine_outerbg = "#16161D",
  lualine_normal = "#6ac0ff",
  lualine_insert = "#98bb6c",
  lualine_visual = "#ffa066",
  lualine_replace = "#e46876",
  lualine_command = "#e6c384",
  lualine_special = "#ff9e64",

  -- Notify background
  notify_bg = "#000000",

  -- Wilder colors
  wilder_foreground = "#ff4303",
}

-- Light theme palette (adjusted for light backgrounds)
local light_palette = {
  -- Border and separator colors (lighter)
  border = "#a0a0a0",
  separator = "#c0c0c0",

  -- Visual selection (lighter)
  visual = "#d4d8e4",

  -- Folded text (darker for contrast)
  folded = "#2b6cb0",

  -- Popup menu (darker for contrast)
  pmenu_fg = "#707880",
  pmenu_sel_bg = "#4a9fff",
  pmenu_sel_fg = "#ffffff",

  -- Floating windows
  normal_float = "#8a9ca4",

  -- Non-text markers
  nontext = "#618c4b",

  -- LSP decorations
  codelens = "#707070",

  -- Diff colors (lighter backgrounds)
  diff_add_bg = "#d4e6d4",
  diff_add_fg = "#2d7a2d",
  diff_change_bg = "#d4d4e6",
  diff_change_fg = "#2d7a7a",
  diff_delete_bg = "#e6d4d4",
  diff_delete_fg = "#7a2d2d",

  -- Bufferline colors (lighter)
  bufferline_inactive_bg = "#f0f0f0",
  bufferline_inactive_fg = "#505050",
  bufferline_visible_bg = "#e0e0e0",
  bufferline_visible_fg = "#404850",
  bufferline_selected_bg = "#d8dce4",
  bufferline_selected_fg = "#0080cc",
  bufferline_background = "#f0f0f0",
  bufferline_offset_separator_fg = "#a0a0a0",
  bufferline_modified = "#cc0000",

  -- CMP colors (adjusted for light background)
  cmp_deprecated = "#909090",
  cmp_match = "#46c680",
  cmp_match_fuzzy = "#468CD6",
  cmp_variable = "#7CBCEE",
  cmp_function = "#B576B0",
  cmp_method = "#B576B0",
  cmp_keyword = "#C4C4C4",
  cmp_property = "#C4C4C4",
  cmp_unit = "#C4C4C4",
  cmp_copilot = "#5CB634",

  -- Diffview colors (lighter)
  diffview_diff_add_bg = "#d4e8d4",
  diffview_diff_change_bg = "#d4d4e8",
  diffview_diff_text_bg = "#c4e0c4",
  diffview_diff_text_fg = "#303840",
  diffview_diff_delete_bg = "#e8d4d4",
  diffview_diff_delete_fg = "#403030",

  -- Lualine colors (brighter for light theme)
  lualine_darkgray = "#e6e6e6",
  lualine_gray = "#707070",
  lualine_outerbg = "#e6e6E6",
  lualine_normal = "#4a9fff",
  lualine_insert = "#78ab5c",
  lualine_visual = "#ff9046",
  lualine_replace = "#d45866",
  lualine_command = "#d6b364",
  lualine_special = "#ff8e54",

  -- Notify background (lighter)
  notify_bg = "#ffffff",

  -- Wilder colors
  wilder_foreground = "#ff3300",
}

-- Update colors based on current background
function M.update_colors()
  M.colors = is_dark_background() and dark_palette or light_palette
end

-- Apply all highlight groups
function M.setup()
  M.update_colors()
  local c = M.colors

  -- Basic highlight groups (from init.lua)
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = c.border, bg = "NONE" })
  vim.api.nvim_set_hl(0, "WinBorder", { fg = c.border, bg = "NONE" })
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = c.separator })
  vim.api.nvim_set_hl(0, "Visual", { bg = c.visual })
  vim.api.nvim_set_hl(0, "Folded", { fg = c.folded, bg = "NONE" })
  vim.api.nvim_set_hl(0, "Pmenu", { fg = c.pmenu_fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "PmenuSel", { fg = c.pmenu_sel_fg, bg = c.pmenu_sel_bg })
  vim.api.nvim_set_hl(0, "NormalFloat", { fg = c.normal_float, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NonText", { fg = c.nontext, bg = "NONE" })
  vim.api.nvim_set_hl(0, "LspCodeLens", {
    fg = c.codelens,
    bg = "NONE",
    italic = true,
    underline = true,
  })

  -- Diff highlights
  vim.api.nvim_set_hl(0, "DiffAdd", {
    fg = c.diff_add_fg,
    bg = c.diff_add_bg,
    bold = true,
  })
  vim.api.nvim_set_hl(0, "DiffChange", {
    fg = c.diff_change_fg,
    bg = c.diff_change_bg,
  })
  vim.api.nvim_set_hl(0, "DiffDelete", {
    fg = c.diff_delete_fg,
    bg = c.diff_delete_bg,
    italic = true,
    bold = true,
  })

  -- CMP highlights (will be applied by cmp.lua using M.colors)
  -- Bufferline highlights (will be applied by bufferline.lua using M.colors)
  -- Other plugin highlights will be applied in their respective configs
end

-- Auto-reapply highlights when colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    M.update_colors()
    M.setup()
  end,
})

-- Initialize colors on module load
M.update_colors()

vim.api.nvim_set_hl(0, "FoldColumn", { link = "Comment" })
vim.api.nvim_set_hl(0, "LspInlayHint", { link = "Comment" })

return M

