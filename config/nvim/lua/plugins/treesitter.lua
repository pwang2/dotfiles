return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
    },
  },
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      modules = {},
      ignore_install = {},
      auto_install = true,
      ensure_installed = {
        "markdown",
        "markdown_inline",
        "bash",
        "c",
        "css",
        "jsx",
        "tsx",
        "javascript",
        "typescript",
        "json",
        "jsonc",
        "vue",
        "regex",
        "lua",
        "rust",
        "vim",
        "vimdoc",
        "python",
        "html",
        "kulala_http",
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
