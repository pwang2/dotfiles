return {
  {
    "navarasu/onedark.nvim",
    disabled = true,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      style = "darker", --  'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      toggle_style_key = "<leader>dd", -- keybind to toggle theme style.
    },
  },
  {
    "sonph/onehalf",
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      local lazypath = vim.fn.stdpath("data") .. "/lazy"
      vim.opt.runtimepath:append(lazypath .. "/onehalf/vim")
      vim.cmd([[colorscheme onehalfdark]])
    end,
  },
}
