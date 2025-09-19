return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      modules = {},
      ignore_install = {},
      auto_install = true,
      ensure_installed = {
        "markdown",
        "markdown_inline",
        "json",
        "jsonc",
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
      indent = { enable = true },
    })
  end,
}
