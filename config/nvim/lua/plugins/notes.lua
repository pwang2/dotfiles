return {
  "epwalsh/obsidian.nvim",
  enabled = false,
  version = "*",
  lazy = true,
  ft = { "markdown" },
  -- event = {
  --   "BufReadPre " .. vim.fn.expand("~") .. "/vaults/*.md",
  --   "BufNewFile " .. vim.fn.expand("~") .. "/vaults/*.md",
  -- },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "para",
        path = "~/vaults/PARA",
      },
    },
    completion = {
      -- Set to false to disable completion.
      nvim_cmp = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },
  },
}
