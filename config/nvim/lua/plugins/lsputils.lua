return {
  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    config = function()
      -- https://github.com/kosayoda/nvim-lightbulb?tab=readme-ov-file#configuration
      require("nvim-lightbulb").setup({
        code_lenses = true,
        autocmd = { enabled = true },
      })
    end,
  },
  {
    "Chaitanyabsprip/fastaction.nvim",
    event = "LspAttach",
    -- https://github.com/Chaitanyabsprip/fastaction.nvim?tab=readme-ov-file#configuration
    opts = {
      dismiss_keys = { "j", "k", "<c-c>", "q" },
      keys = "qwertyuiopasdfghlzxcvbnm",
      priority = {
        typescript = {
          { pattern = "Add import from", key = "a", order = 1 },
        },
      },
    },
  },
  {
    "antosha417/nvim-lsp-file-operations",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- must be loaded first
      "nvim-tree/nvim-tree.lua",
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
}
