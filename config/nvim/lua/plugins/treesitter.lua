return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
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
      textobjects = {
        move = {
          enable = true,
          set_jumps = true, -- Add to jumplist
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
      },
    })
  end,
}
