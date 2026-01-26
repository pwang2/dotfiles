return {
  "akinsho/bufferline.nvim",
  event = "BufReadPost",
  keys = {
    { "<leader>0", "<cmd>lua require('bufferline').go_to(0, true)<cr>", silent = true, desc = "Go to last buffer" },
    { "<leader>1", "<cmd>lua require('bufferline').go_to(1, true)<cr>", silent = true, desc = "Go to buffer 1" },
    { "<leader>2", "<cmd>lua require('bufferline').go_to(2, true)<cr>", silent = true, desc = "Go to buffer 2" },
    { "<leader>3", "<cmd>lua require('bufferline').go_to(3, true)<cr>", silent = true, desc = "Go to buffer 3" },
    { "<leader>4", "<cmd>lua require('bufferline').go_to(4, true)<cr>", silent = true, desc = "Go to buffer 4" },
    { "<leader>5", "<cmd>lua require('bufferline').go_to(5, true)<cr>", silent = true, desc = "Go to buffer 5" },
    { "<leader>6", "<cmd>lua require('bufferline').go_to(6, true)<cr>", silent = true, desc = "Go to buffer 6" },
    { "<leader>7", "<cmd>lua require('bufferline').go_to(7, true)<cr>", silent = true, desc = "Go to buffer 7" },
    { "<leader>8", "<cmd>lua require('bufferline').go_to(8, true)<cr>", silent = true, desc = "Go to buffer 8" },
    { "<leader>9", "<cmd>lua require('bufferline').go_to(9, true)<cr>", silent = true, desc = "Go to buffer 9" },
  },
  config = function()
    local bufferline = require("bufferline")
    bufferline.setup({
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
        always_show_bufferline = true,
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
