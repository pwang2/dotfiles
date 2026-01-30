return {
  "neovim/nvim-lspconfig",
  keys = {
    { "<leader>rr", "<cmd>LspRestart<cr>", { silent = true } },
  },
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "b0o/schemastore.nvim",
    { "Hoffs/omnisharp-extended-lsp.nvim" }, --used to make lsp gd working
    {
      "rachartier/tiny-inline-diagnostic.nvim",
      event = "VeryLazy",
      priority = 1000,
      config = function()
        require("tiny-inline-diagnostic").setup()
        vim.diagnostic.config({ virtual_text = false })
      end,
    },

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
  },
  config = function()
    require("lsp").setup()
  end,
}
