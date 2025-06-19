return {
  "akinsho/bufferline.nvim",
  event = "BufReadPost",
  keys = {
    { "<leader>1", "<cmd>lua require('bufferline').go_to(1, true)<cr>", silent = true },
    { "<leader>2", "<cmd>lua require('bufferline').go_to(2, true)<cr>", silent = true },
    { "<leader>3", "<cmd>lua require('bufferline').go_to(3, true)<cr>", silent = true },
    { "<leader>4", "<cmd>lua require('bufferline').go_to(4, true)<cr>", silent = true },
    { "<leader>5", "<cmd>lua require('bufferline').go_to(5, true)<cr>", silent = true },
    { "<leader>6", "<cmd>lua require('bufferline').go_to(6, true)<cr>", silent = true },
    { "<leader>7", "<cmd>lua require('bufferline').go_to(7, true)<cr>", silent = true },
    { "<leader>8", "<cmd>lua require('bufferline').go_to(8, true)<cr>", silent = true },
    { "<leader>9", "<cmd>lua require('bufferline').go_to(9, true)<cr>", silent = true },
    { "<leader>$", "<cmd>lua require('bufferline').go_to(-1, true)<cr>", silent = true },
  },
  config = function()
    local bufferline = require("bufferline")
    local inactive_bg = "#1c1c1c"
    local inactive_fg = "#e0e0e0"
    local visible_bg = "#0e0e0e"
    local visible_fg = "#5c6370"
    local selected_bg = "#282c34"
    local selected_fg = "#00afff"
    local background = "#1c1c1c"
    local inactive_set = { fg = inactive_fg, bg = inactive_bg }
    local visible_set = { fg = visible_fg, bg = visible_bg }
    local active_set = { fg = selected_fg, bg = selected_bg }
    bufferline.setup({
      highlights = {
        background = inactive_set,
        buffer_visible = visible_set,
        buffer_selected = active_set,

        numbers = inactive_set,
        numbers_visible = visible_set,
        numbers_selected = active_set,

        close_button = inactive_set,
        close_button_visible = visible_set,
        close_button_selected = active_set,

        offset_separator = { fg = "#585858", bg = selected_bg },

        separator = { fg = background, bg = inactive_bg },
        separator_visible = { fg = background, bg = visible_bg },
        separator_selected = { fg = background, bg = selected_bg },

        modified = { fg = "#ff0000", bg = inactive_bg },
        modified_visible = { fg = "#ff0000", bg = visible_bg },
        modified_selected = { fg = "#ff0000", bg = selected_bg },
        fill = { bg = background },
      },
      options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
        themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
        numbers = "both", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        diagnostics = "nvim_lsp",
        diagnostics_update_on_event = true, -- use nvim's diagnostic handler
        diagnostics_indicator = function(count)
          return "(" .. count .. ")"
        end,
        color_icons = true,
        separator_style = "slant", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
        always_show_bufferline = false,
        indicator = {
          icon = "▎", -- this should be omitted if indicator style is not 'icon'
          style = "icon", --"icon" | "underline" | "none",
        },
        offsets = {
          {
            filetype = "NvimTree",
            text = "",
            highlight = "Directory",
            separator = true, -- use a "true" to enable the default, or set your own character
          },
        },
      },
    })
  end,
}
