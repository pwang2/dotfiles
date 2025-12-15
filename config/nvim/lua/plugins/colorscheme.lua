return {
  {
    "navarasu/onedark.nvim",
    enabled = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      style = "darker", --  'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      toggle_style_key = "<leader>dd", -- keybind to toggle theme style.
    },
  },
  {
    "sonph/onehalf",
    enabled = true,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    init = function()
      vim.g.airline_theme = "onehalfdark"
    end,
    config = function()
      local lazypath = vim.fn.stdpath("data") .. "/lazy"
      vim.opt.runtimepath:append(lazypath .. "/onehalf/vim")
      vim.cmd([[colorscheme onehalfdark]])
    end,
  },
}
