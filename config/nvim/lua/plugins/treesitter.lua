return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        modules = {},
        ignore_install = {},
        auto_install = true,
        ensure_installed = {
          "c",
          "bash",
          "regex",
          "lua",
          "rust",
          "vim",
          "vimdoc",
          "typescript",
          "vue",
          "javascript",
          "css",
          "python",
          "html",
        },
        sync_install = false,
        highlight = {
          enable = true,
          -- treesitter has too basic syntax highlight for html
          disable = { "html" },
        },
        indent = { enable = true },
      })
    end,
  },
}
